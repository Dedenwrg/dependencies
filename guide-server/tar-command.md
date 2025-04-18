# Tar Command Usage Guide

`tar` is a utility for compressing and extracting files in Unix-based systems. Below are common usage examples for working with tar archives.

## Table of Contents
1. [Create Archive](#create-archive)
2. [Extract Archive](#extract-archive)
3. [Extract to Specific Folder](#extract-to-specific-folder)
4. [View Archive Contents](#view-archive-contents)
5. [Compress and Decompress with Tar](#compress-and-decompress-with-tar)
6. [Show Progress](#show-progress)
7. [Additional Options](#additional-options)

---

## Create Archive

To create a tar archive from a directory or file:

```bash
tar -cvf archive_name.tar /path/to/directory
```

- `-c`: Create a new archive
- `-v`: Verbose (shows files being archived)
- `-f`: Specifies the name of the archive

---

## Extract Archive

To extract a tar archive:

```bash
tar -xvf archive_name.tar
```

- `-x`: Extract the contents of the archive
- `-v`: Verbose (shows files being extracted)
- `-f`: Specifies the name of the archive

---

## Extract to Specific Folder

To extract a tar archive into a specific directory:

```bash
tar -xvf archive_name.tar -C /path/to/target-directory
```

- `-C`: Change to directory before extracting

Make sure the target directory exists, or create it first with `mkdir -p`.

---

## View Archive Contents

To list the contents of a tar archive without extracting:

```bash
tar -tvf archive_name.tar
```

- `-t`: List the contents of the archive
- `-v`: Verbose (shows detailed info)
- `-f`: Specifies the name of the archive

---

## Compress and Decompress with Tar

### Compressing with gzip

```bash
tar -czvf archive_name.tar.gz /path/to/directory
```

To extract:

```bash
tar -xzvf archive_name.tar.gz
```

### Compressing with bzip2

```bash
tar -cjvf archive_name.tar.bz2 /path/to/directory
```

To extract:

```bash
tar -xjvf archive_name.tar.bz2
```

---

## Show Progress

You can view progress with `--checkpoint` and `--checkpoint-action=dot`:

```bash
tar --checkpoint=1000 --checkpoint-action=dot -xvf archive_name.tar
```

This will print a dot `.` every 1000 files processed.

For larger archives, you can also use `pv` to show a progress bar:

```bash
pv archive_name.tar | tar -xvf - -C /target/folder
```

Install `pv` if needed:

```bash
sudo apt install pv
```

---

## Additional Options

- **Exclude files** from the archive:
  
  ```bash
  tar --exclude='*.log' -cvf archive_name.tar /path/to/directory
  ```

- **Append** files to an existing archive:
  
  ```bash
  tar -rvf archive_name.tar new_file.txt
  ```

- **Extract specific file** from an archive:

  ```bash
  tar -xvf archive_name.tar specific_file.txt
  ```

- **Create a compressed tar archive with `xz`**:

  ```bash
  tar -caf archive_name.tar.xz /path/to/directory
  ```

  - `-a`: Automatically choose compression based on file extension

---
