# File system simulation

## Summary
This project simulates a file systems which can *create/delete/write/read* simulated files, and *create/delete* simulated directories. Simulated files and directories are not created as "real" files or directories. Instead, this program program execution generate a series of txt files keeping track of information relative to the simulated files and directories as would a files system keeping track of files and directories and their associated memory space. 

## Usage
The program launches using the following command line 
```
fs.exe cmd.txt
```
or
```
fs.exe cmd2.txt
```

### Commands file
*cmd.txt* or *cmd2.txt* feed a list of commands to *fs.exe*. The following command create a simulated directory named */main* in the root directory. 
```
creation_repertoire /main
```

The following command creates in directory */main/a1/b1/c1* a simulated file named *fichier1.txt* and write *0123456789* as its content.  
```
creation_fichier /main/a1/b1/c1/fichier1.txt 0123456789
```

### Tracking files
A proper execution of *fs.exe* will generate a series of files;

- *mem.txt* keeps track of simulated files content. Memory space is divided in block of 16 bytes to memorise files content. Unused bytes withing a block will be marked as *null* character in *mem.txt*. 

- *fList.txt* keeps track of simulated files and directory structures. Each lines tracks either a directory or file and its emplacement. 

- *bitTab.txt* keeps track of free memory blocks (marked as 0) and used memory blocks (marked as 1) in the simulated memory space. 

- *ino.txt* keeps track of simulated inodes abstract data structure storing disk block allocation to simulated files. 

After program execution, the content assigned to simulated files can be read in *mem.txt*. 

### Test
Create a modified copy of *cmd.txt* named *cmd2.txt*. Line 6 is modified from 
```
creation_fichier /main/a1/b1/c1/fichier1.txt 0123456789
```
to 
```
creation_fichier /main/a1/b1/c1/fichier1.txt this is a test
```
Then re-executing *fs.exe* with the modified *cmd2.txt*
```
fs.exe cmd2.txt
```
Now reopen *mem.txt*. The simulated memory block that contained *0123456789* will be replaced by *this is a test*. While modifying *cmd.txt* be careful to preserve the file structure as to not disrupt the correct parsing of its content by *fs.exe*. 