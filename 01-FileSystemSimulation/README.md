# FILE SYSTEM SIMULATION


## Summary
This project simulates a file systems which can *create/delete/write/read* simulated files, and *create/delete* simulated directories. Simulated files and directories are not created as "real" files or directories. Instead, this program program execution generate a series of txt files keeping track of information relative to the simulated files and directories as would a files system keeping track of files and directories and their associated memory space. 


## Usage
The program launches using 
```
fs cmd.txt
```

*cmd.txt* feeds a list of commands to *fs.exe*. Example: 

```
creation_repertoire /main
```
This command create a simulated directory named *main*. 
```
creation_fichier /main/a1/b1/c1/fichier1.txt 0123456789
```
This command create a simulated file named *fichier1.txt* and write *0123456789* as its content.  


A proper execution of fs will generate a series of files;
*mem.txt* keeps tracks of simulated files content. Memory space is divided in block of 16 bytes to memorise files content. Unused bytes withing a block will be marked as *null* character in *mem.txt*. 

*fList.txt* keeps tracks of simulated files and directory structures. Each lines tracks either a directory or file and its emplacement. 

*bitTab.txt* keeps tracks of free memory blocks (marked as 0) and used memory blocks (marked as 1) in the simulated memory space. 

*ino.txt* keeps tracks of simulated inodes abstract data structure storing disk block allocation to simulated files. 
