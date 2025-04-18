### Basic Linux Commands:
1. **File System Navigation:**
   - `ls`: List directory contents.
     ```bash
     ls
     ```
   - `cd`: Change directory.
     ```bash
     cd /path/to/directory
     ```
   - `pwd`: Print working directory.
     ```bash
     pwd
     ```

2. **File Manipulation:**
   - `touch`: Create an empty file.
     ```bash
     touch new_file.txt
     ```
   - `mkdir`: Create a new directory.
     ```bash
     mkdir new_directory
     ```
   - `cp`: Copy files or directories.
     ```bash
     cp source_file.txt destination_directory/
     ```
   - `mv`: Move or rename files/directories.
     ```bash
     mv old_file.txt new_file.txt
     ```
   - `rm`: Remove files/directories.
     ```bash
     rm file_to_delete.txt
     ```

3. **Process Management:**
   - `ps`: Show running processes.
     ```bash
     ps aux
     ```
   - `kill`: Terminate a process.
     ```bash
     kill -9 <process_id>
     ```

4. **Permissions:**
   - `chmod`: Change file/directory permissions.
     ```bash
     chmod 755 file.txt
     ```
   - `chown`: Change file/directory ownership.
     ```bash
     chown new_owner:new_group file.txt
     ```

5. **Text Manipulation:**
   - `cat`: Display file content.
     ```bash
     cat file.txt
     ```
   - `grep`: Search for text within files.
     ```bash
     grep "keyword" file.txt
     ```
   - `sed`: Stream editor for modifying text.
     ```bash
     sed 's/old_word/new_word/g' file.txt

### Advanced Linux Commands:
6. **File Search and Filtering:**
   - `find`: Search for files/directories based on criteria.
     ```bash
     find /path/to/search -name "file_name.txt"
     ```

7. **File and Text Processing:**
   - `head`: Display the beginning of a file.
     ```bash
     head file.txt
     ```
   - `tail`: Display the end of a file.
     ```bash
     tail file.txt
     ```
   - `sort`: Sort lines in a file.
     ```bash
     sort file.txt
     ```

8. **Advanced Text Processing:**
   - `awk`: Text processing language.
     ```bash
     awk '{print $2}' file.txt
     ```
   - `cut`: Cut out selected portions of each line of a file.
     ```bash
     cut -d, -f2 file.csv
     ```

### Other Commands:
1. **User Management:**
   - `useradd`: Create a new user account.
     ```bash
     useradd -m username
     ```
   - `passwd`: Change user password.
     ```bash
     passwd username
     ```

2. **Package Management:**
   - `apt upgrade`: Upgrade all installed packages.
     ```bash
     sudo apt upgrade
     ```
   - `apt remove`: Remove installed packages.
     ```bash
     sudo apt remove package_name
     ```

3. **System Resource Monitoring:**
   - `df`: Display disk usage.
     ```bash
     df -h
     ```
   - `free`: Display memory usage.
     ```bash
     free -m
     ```

4. **Network Connections:**
   - `netstat`: Display network connections.
     ```bash
     netstat -tuln
     ```
   - `ping`: Check connection to a host.
     ```bash
     ping google.com
     ```

Feel free to use this Markdown list for your reference or documentation purposes!
