#!/bin/bash

# Prompt user for moniker
read -p "Please enter your moniker: " MONIKER

# Export environment variables
echo "export WALLET='wallet'" >> $HOME/.bash_profile
echo "export MONIKER='$MONIKER'" >> $HOME/.bash_profile
echo "export INITIA_CHAIN_ID='initiation-1'" >> $HOME/.bash_profile
echo "export INITIA_PORT='19'" >> $HOME/.bash_profile

source $HOME/.bash_profile

# Set up Initia environment
cd $HOME
mkdir -p lib
git clone https://github.com/initia-labs/initia
cd initia
git checkout v0.2.14
export GOPATH="${HOME}/lib"
make install

# Copy binaries to go bin
cp ${HOME}/lib/bin/* $HOME/go/bin/

# Initialize Initia node
initiad init $MONIKER --chain-id $INITIA_CHAIN_ID
sed -i -e "s|^node *=.*|node = \"tcp://localhost:${INITIA_PORT}657\"|" $HOME/.initia/config/client.toml

# Download genesis and addrbook files
curl -Ls https://snapshot.adanothe.com/initia/genesis.json > $HOME/.initia/config/genesis.json
curl -Ls https://snapshot.adanothe.com/initia/addrbook.json > $HOME/.initia/config/addrbook.json

# Configure peers and seeds
PEERS="093e1b89a498b6a8760ad2188fbda30a05e4f300@35.240.207.217:26656"
PEERS="dd94a609ed61354c123f1707cba6fe126f2a5bb6@95.217.152.243:15656,2b1915a1c08d711a0fa0d723bbbef1dc4692b709@149.102.140.81:1565,aee7083ab11910ba3f1b8126d1b3728f13f54943@65.108.193.254:11656,a670a0386383e56065e87b0e68e198f55aa8765c@89.117.57.28:46656,c9d57dbf7968e7f159613a0728ee6db29a8bb392@31.220.77.25:26656,8394f236b9c2150dab2d44649d16e6090379c4ef@34.125.186.80:53456,78c07f147ea3bef03b323930145238a16020f928@64.225.58.97:26656,d952f8524f597ec1bca7f8d634f4630ac985b87c@65.109.113.233:25756"

sed -i \
    -e "s/^seeds *=.*/seeds = \"$SEEDS\"/" \
    -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" \
    $HOME/.initia/config/config.toml

# Set custom ports in app.toml and config.toml
sed -i.bak -e "s%:1317%:${INITIA_PORT}317%g;
s%:8080%:${INITIA_PORT}080%g;
s%:9090%:${INITIA_PORT}090%g;
s%:9091%:${INITIA_PORT}091%g;
s%:8545%:${INITIA_PORT}545%g;
s%:8546%:${INITIA_PORT}546%g;
s%:6065%:${INITIA_PORT}065%g" $HOME/.initia/config/app.toml

sed -i.bak -e "s%:26658%:${INITIA_PORT}658%g;
s%:26657%:${INITIA_PORT}657%g;
s%:6060%:${INITIA_PORT}060%g;
s%:26656%:${INITIA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${INITIA_PORT}656\"%;
s%:26660%:${INITIA_PORT}660%g" $HOME/.initia/config/config.toml

# Config pruning
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.initia/config/app.toml

# Set minimum gas price, enable prometheus, and disable indexing
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.15uinit,0.01uusdc\"|" $HOME/.initia/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.initia/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.initia/config/config.toml

# Create systemd service file
sudo tee /etc/systemd/system/initiad.service > /dev/null <<EOF
[Unit]
Description=Initia node
After=network-online.target

[Service]
User=$USER
WorkingDirectory=$HOME/.initia
ExecStart=$(which initiad) start --home $HOME/.initia
Restart=on-failure
RestartSec=5
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

# Download and extract snapshot
initiad tendermint unsafe-reset-all --home $HOME/.initia
if curl -s --head https://snapshot.adanothe.com/initia/initia-snapshot-20240517.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
curl https://snapshot.adanothe.com/initia/initia-snapshot-20240517.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.initia
    else
  echo no have snap
fi

# Enable and start Initia service
sudo systemctl daemon-reload
sudo systemctl enable initiad
sudo systemctl restart initiad && sudo journalctl -u initiad -f
