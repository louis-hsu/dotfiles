# Taskwarrior configuration
The configurations for Taskwarrior ('task') and utilies:
1. `taskopen`
    [taskopen Github](https://github.com/jschlatow/taskopen)
2. `taskwarrior_tui`
    [taskwarrior github](https://github.com/kdheepak/taskwarrior-tui)
    [doc](https://github.com/kdheepak/taskwarrior-tui/tree/main/docs)

## Update history

#### 2024/0327
Since 'task-3.0.0' adopts the new mechanism for 'task-sync', and after studying the manpage 'task-sync':
1. Sync data to local disk/directory as manpage describes
2. And local disk/directory is the symbolic link to Dropbox
as the accommodating/temporary solution

Remove description/TODO items related to 'taskd' which is obsolete

#### 2024/0327
1. 'task-3.0.0' is out with mechanisms re-written (same CLI). However, 'brew' version is not there yet
2. Remove 'brew' version and compile/install from source code, which is installed under '/usr/local/'
3. There is no 'uninstall' function in 'make' file. According to 'INSTALL' doc, following directories/files have to be removed manually when 'brew' version 'task' is available:

```
CMAKE_INSTALL_PREFIX/TASK_BINDIR   /usr/local/bin
CMAKE_INSTALL_PREFIX/TASK_DOCDIR   /usr/local/share/doc/task
CMAKE_INSTALL_PREFIX/TASK_RCDIR    /usr/local/share/doc/task/rc
CMAKE_INSTALL_PREFIX/TASK_MAN1DIR  /usr/local/share/man/man1
CMAKE_INSTALL_PREFIX/TASK_MAN5DIR  /usr/local/share/man/man5
```

#### 2024/0322
1. `taskrc` and task data folder `task_data` have been moved to $XDG_CONFIG_HOME/task and work
2. Update 2024 calendar

#### 2024/0320
Revise README.md 

## TODO
1. Wait for 'brew' version 'task-3.0.0' 
2. Adopt new version of taskopen and install brew version

