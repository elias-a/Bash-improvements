### .bash_aliases 
An improvement of the **cd** command. Allows the user to navigate up an arbitrary number of directories with ease. For example, **cd ...** navigates back two directories, and **cd ....** navigates back three directories. 
Place this file in the home directory, and make sure that the .bashrc file contains the following code. 

```
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

### rm
Moves a file to a directory named .trash instead of permanently deleting the file. The .trash directory is created in the current working directory if it does not already exist. Place this file in a directory higher up the path than /bin, where the default **rm** script is located.

### cp
Identical to the default ** cp [SOURCE] [DEST] ** command, except that if the DEST file exists, it is moved to a .trash directory instead of being overwritten. The .trash directory is created in the current working directory if it does not already exist. Place this file in a directory higher up the path than /bin, where the default **cp** script is located.

### mv
Identical to the default ** mv [SOURCE] [DEST] ** command, except that if the DEST file exists, it is moved to a .trash directory instead of being overwritten. The .trash directory is created in the current working directory if it does not already exist. Place this file in a directory higher up the path than /bin, where the default **mv** script is located.
