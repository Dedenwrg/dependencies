# PostgreSQL Usage Guide

A practical guide for using PostgreSQL: creating users, managing databases, running SQL queries, and more.

---

## 📦 Installation

Follow the official installation guide based on your OS:

🔗 https://www.postgresql.org/download/

For Ubuntu-based systems:

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

---

## ▶️ Starting PostgreSQL

Start and enable the PostgreSQL service:

```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

Check status:

```bash
sudo systemctl status postgresql
```

---

## 👤 Switching to PostgreSQL User

PostgreSQL creates a default Linux user named `postgres`. Use it to access `psql`:

```bash
sudo -i -u postgres
psql
```

To exit `psql`, type:

```sql
\q
```

---

## 🛠 Create & Manage Users and Databases

### Create a New User

```sql
CREATE USER myuser WITH PASSWORD 'mypassword';
```

### Give Privileges

Grant database creation and login:

```sql
ALTER USER myuser CREATEDB;
```

### Create a Database

```sql
CREATE DATABASE mydb OWNER myuser;
```

### Connect to a Database

```sql
\c mydb
```

---

## 🔐 Role Management

### List All Roles

```sql
\du
```

### Create a Role with Superuser Privileges

```sql
CREATE ROLE admin WITH LOGIN SUPERUSER PASSWORD 'securepass';
```

---

## 📂 Backup & Restore

### Logical Backup (SQL Dump)

```bash
pg_dump -U myuser mydb > backup.sql
```

### Restore from SQL

```bash
psql -U myuser -d mydb -f backup.sql
```

### Physical Backup (Data Directory)

> Stop PostgreSQL before copying data directory:

```bash
sudo systemctl stop postgresql
sudo cp -r /var/lib/postgresql/14 /your/backup/location
```

To restore, copy it back and start PostgreSQL again.

---

## 🧪 Common SQL Queries

### Create Table

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Insert Data

```sql
INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
```

### Select Data

```sql
SELECT * FROM users;
```

### Update Data

```sql
UPDATE users SET name = 'Bob' WHERE id = 1;
```

### Delete Data

```sql
DELETE FROM users WHERE id = 1;
```

---

## 📊 Helpful `psql` Meta-Commands

- `\l` — list databases  
- `\c dbname` — connect to a database  
- `\dt` — list tables  
- `\d tablename` — describe table structure  
- `\du` — list roles  
- `\q` — quit psql  

---

## ⚙️ Configuration Files

Located in the PostgreSQL data directory (e.g., `/var/lib/postgresql/14/main`):

- `postgresql.conf`: Main config
- `pg_hba.conf`: Access rules (IP whitelist, auth methods)

After editing config files, restart PostgreSQL:

```bash
sudo systemctl restart postgresql
```

---

## 📌 Tips

- Use `pgAdmin` for a GUI-based interface.
- Use `.pgpass` for storing passwords securely.
- Always test backups and restores in non-production environments.

---

## 📚 More Resources

- https://www.postgresql.org/docs/
- https://www.pgadmin.org/
```

---
