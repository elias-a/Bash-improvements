### .bash_aliases 
An improvement of the **cd** command. Allows the user to navigate up an arbitrary number of directories with ease. For example, **cd ...** navigates back two directories, and **cd .....** navigates back four directories. 
Place this file in the home directory, and make sure that the .bashrc file contains the code 

```
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

