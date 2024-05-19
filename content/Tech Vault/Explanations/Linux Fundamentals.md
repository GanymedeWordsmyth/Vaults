# Overview
## Philosophy
Linux follows five core principles:

| **Principle**                                                 | **Description**                                                                                                                                                |
| ------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Everything is a file`                                        | All configuration files for the various services running on the Linux operating system are stored in one or more text files.                                   |
| `Small, single-purpose programs`                              | Linux offers many different tools that we will work with, which can be combined to work together.                                                              |
| `Ability to chain programs together to perform complex tasks` | The integration and combination of different tools enable us to carry out many large and complex tasks, such as processing or filtering specific data results. |
| `Avoid captive user interfaces`                               | Linux is designed to work mainly with the shell (or terminal), which gives the user greater control over the operating system.                                 |
| `Configuration data stored in a text file`                    | An example of such a file is the `/etc/passwd` file, which stores all users registered on the system.                                                          |
## Components

| **Component**     | **Description**                                                                                                                                                                                                                                                                                                                                 |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Bootloader`      | A piece of code that runs to guide the booting process to start the operating system. Parrot Linux uses the GRUB Bootloader.                                                                                                                                                                                                                    |
| `OS Kernel`       | The kernel is the main component of an operating system. It manages the resources for system's I/O devices at the hardware level.                                                                                                                                                                                                               |
| `Daemons`         | Background services are called "daemons" in Linux. Their purpose is to ensure that key functions such as scheduling, printing, and multimedia are working correctly. These small programs load after we booted or log into the computer.                                                                                                        |
| `OS Shell`        | The operating system shell or the command language interpreter (also known as the command line) is the interface between the OS and the user. This interface allows the user to tell the OS what to do. The most commonly used shells are Bash, Tcsh/Csh, Ksh, Zsh, and Fish.                                                                   |
| `Graphics server` | This provides a graphical sub-system (server) called "X" or "X-server" that allows graphical programs to run locally or remotely on the X-windowing system.                                                                                                                                                                                     |
| `Window Manager`  | Also known as a graphical user interface (GUI). There are many options, including GNOME, KDE, MATE, Unity, and Cinnamon. A desktop environment usually has several applications, including file and web browsers. These allow the user to access and manage the essential and frequently accessed features and services of an operating system. |
| `Utilities`       | Applications or utilities are programs that perform particular functions for the user or another program.                                                                                                                                                                                                                                       |
## Linux Architecture
The Linux operating system can be broken down into layers:

|**Layer**|**Description**|
|---|---|
|`Hardware`|Peripheral devices such as the system's RAM, hard drive, CPU, and others.|
|`Kernel`|The core of the Linux operating system whose function is to virtualize and control common computer hardware resources like CPU, allocated memory, accessed data, and others. The kernel gives each process its own virtual resources and prevents/mitigates conflicts between different processes.|
|`Shell`|A command-line interface (**CLI**), also known as a shell that a user can enter commands into to execute the kernel's functions.|
|`System Utility`|Makes available to the user all of the operating system's functionality.|

## File System Hierarchy

The Linux operating system is structured in a tree-like hierarchy and is documented in the [Filesystem Hierarchy](http://www.pathname.com/fhs/) Standard (FHS). Linux is structured with the following standard top-level directories:

![iamge](https://academy.hackthebox.com/storage/modules/18/NEW_filesystem.png)

| **Path** | **Description**                                                                                                                                                                                                                                                                                                                   |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/`      | The top-level directory is the root filesystem and contains all of the files required to boot the operating system before other filesystems are mounted as well as the files required to boot the other filesystems. After boot, all of the other filesystems are mounted at standard mount points as subdirectories of the root. |
| `/bin`   | Contains essential command binaries.                                                                                                                                                                                                                                                                                              |
| `/boot`  | Consists of the static bootloader, kernel executable, and files required to boot the Linux OS.                                                                                                                                                                                                                                    |
| `/dev`   | Contains device files to facilitate access to every hardware device attached to the system.                                                                                                                                                                                                                                       |
| `/etc`   | Local system configuration files. Configuration files for installed applications may be saved here as well.                                                                                                                                                                                                                       |
| `/home`  | Each user on the system has a subdirectory here for storage.                                                                                                                                                                                                                                                                      |
| `/lib`   | Shared library files that are required for system boot.                                                                                                                                                                                                                                                                           |
| `/media` | External removable media devices such as USB drives are mounted here.                                                                                                                                                                                                                                                             |
| `/mnt`   | Temporary mount point for regular filesystems.                                                                                                                                                                                                                                                                                    |
| `/opt`   | Optional files such as third-party tools can be saved here.                                                                                                                                                                                                                                                                       |
| `/root`  | The home directory for the root user.                                                                                                                                                                                                                                                                                             |
| `/sbin`  | This directory contains executables used for system administration (binary system files).                                                                                                                                                                                                                                         |
| `/tmp`   | The operating system and many programs use this directory to store temporary files. This directory is generally cleared upon system boot and may be deleted at other times without any warning.                                                                                                                                   |
| `/usr`   | Contains executables, libraries, man files, etc.                                                                                                                                                                                                                                                                                  |
| `/var`   | This directory contains variable data files such as log files, email in-boxes, web application related files, cron files, and more.                                                                                                                                                                                               |>

>[!Note] Interesting Note:
>The prompt character denotes whether or not a user is privileged. "$" means an unprivileged user while a privileged user's prompt character is a "#".
>A "~" denotes that user's home directory
## Getting help:
man [tool]
apropos [tool]
https://explainshell.com/
# Search
## Which
One of the common tools is `which`. This tool returns the path to the file or link that should be executed. This allows us to determine if specific programs, like cURL, netcat, wget, python, gcc, are available on the operating system.
## Find
Another handy tool is `find`. Besides the function to find files and folders, this tool also contains the function to filter the results. We can use filter parameters like the size of the file or the date. We can also specify if we only search for files or folders.

|**Option**|**Description**|
|---|---|
|`-type f`|Hereby, we define the type of the searched object. In this case, '`f`' stands for '`file`'.|
|`-name *.conf`|With '`-name`', we indicate the name of the file we are looking for. The asterisk (`*`) stands for 'all' files with the '`.conf`' extension.|
|`-user root`|This option filters all files whose owner is the root user.|
|`-size +20k`|We can then filter all the located files and specify that we only want to see the files that are larger than 20 KiB.|
|`-newermt 2020-03-03`|With this option, we set the date. Only files newer than the specified date will be presented.|
|`-exec ls -al {} \;`|This option executes the specified command, using the curly brackets as placeholders for each result. The backslash escapes the next character from being interpreted by the shell because otherwise, the semicolon would terminate the command and not reach the redirection.|
|`2>/dev/null`|This is a `STDERR` redirection to the '`null device`', which we will come back to in the next section. This redirection ensures that no errors are displayed in the terminal. This redirection must `not` be an option of the 'find' command.|
## Locate
It will take much time to search through the whole system for our files and directories to perform many different searches. The command `locate` offers us a quicker way to search through the system. In contrast to the `find` command, `locate` works with a local database that contains all information about existing files and folders. We can update this database with the following command.
```step1-update-db
$ sudo updatedb
```
If we now search for all files with the "`.conf`" extension, you will find that this search produces results much faster than using `find`.
```example
$ locate *.conf

/etc/GeoIP.conf
/etc/NetworkManager/NetworkManager.conf
/etc/UPower/UPower.conf
/etc/adduser.conf
<SNIP>
```
However, this tool does not have as many filter options that we can use. So it is always worth considering whether we can use the `locate` command or instead use the `find` command. It always depends on what we are looking for.
# File Descriptors and Redirections
## File Descriptors

A file descriptor (FD) in Unix/Linux operating systems is an indicator of connection maintained by the kernel to perform Input/Output (I/O) operations. In Windows-based operating systems, it is called filehandle. It is the connection (generally to a file) from the Operating system to perform I/O operations (Input/Output of Bytes). By default, the first three file descriptors in Linux are:

1. Data Stream for Input
    - `STDIN – 0`
2. Data Stream for Output
    - `STDOUT – 1`
3. Data Stream for Output that relates to an error occurring.
    - `STDERR – 2`
`2>/dev/null` redirects the STDERR to the null device, which discards all data.
`> [file-name].txt` use this to direct the STDOUT of a command to a file. If this file does not exist, it will be created.
`2> stderr.txt 1> stdout.txt` will redirect the STDOUT and STDERR of commands into separate files.
`< [file-name].txt` works to redirect the STDIN to a command
`>>` redirects STDOUT to append a file, instead of replace it.
`<<` use this to add a STDIN through a stream. 
(`cat << EOF > stream.txt`)
`|` pipes ( shift + \ ) are used when you want the STDOUT from one program to be processed by another.
# Filter Contents
`More` opens a pager, like `cat`, but you can scroll through more easier than `cat`.
`Less` Like `more` but with more features (pun intended)
`Head` for when you are only interested in the first few lines of a file. By default, `head` displays the first ten lines.
`Tail` like `head` but displays the last ten lines (unless otherwise specified)
`Sort` pretty much does what it says on the tin
`Grep` search a file for a given pattern. Alternatively, use `| grep -v` to exclude specific patterns.
`Cut` perfect for removing unwanted delimiters and show the words on a line in a specific position. `| cut -d ":" -f1` set `:` as the delimiter and only print the first position (`-f1`)
`Tr` use this to replace certain characters with more desirable characters in a given file. `| tr ":" " "` will replace any colons in a file with spaces.
`Column` since search results can have unclear representation, use `| column -t` to display results in a table to make it easier to read.
`Awk` display results as simply as possible using the (`g`)`awk` programming. `| awk '{print $1, $NF}` prints the first (`$1`) and last (`$NF`) result of a line.
`Sed` Whenever you wish to change specific names in the whole file or STIN, use this tool. It's most commonly used in text substitution. `sed` looks for patterns defined in the form of regular expressions (regex) and replaces them with another pattern that was also defined. `| sed 's/bin/HtB/g'` the "`s/`" flag at the beginning stands for the substitute command. Then, specify the pattern you want to replace. After the slash (`/`), enter the pattern you wish to use as the replacement. Finally, use the "`/g`" flag to tell `sed` to replace all matching instances.
`Wc` use `wc` to avoid manually counting the lines or characters. The `-l` flag prints the newline counts, `-m` prints character counts, `-w` prints word counts.
# Regular Expressions (Regex)
And art of expression lang to search for patterns in texts and files. Can be used to find and replace text, analyze data, validate input, perform searches, and more. Put simply, they are a filter citerion that can be used to analyze and manipulate strings.

A regular expression is a sequence of letters and symbols that form a search pattern. Additionally, regexes can be created with patterns called metacharacters, which in turn are symbols that define the search pattern but have no literal meaning. 
## Grouping
Among other things, regex offers the possibility to group the desired search patterns, and follows three concepts, distinguished by the three types of brackets:

| **Operators** | **Description**                                                                                                                                                             |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `(a)`         | The round brackets are used to group parts of a regex. Within the brackets, you can define further patterns which should be processed together.                             |
| `[a-z]`       | The square brackets are used to define character classes. Inside the brackets, you can specify a list of characters to search for.                                          |
| `{1,10}`      | The curly brackets are used to define quantifiers. Inside the brackets, you can specify a number or a range that indicates how often a previous pattern should be repeated. |
| `\|`          | Also called the OR operator and shows results when one of the two expressions matches                                                                                       |
| `.*`          | Also called the AND operator and displayed results only if both expressions match                                                                                           |
## Practice
Here are some optional tasks to practice regex that can help us to handle it better and more efficiently. For all exercises, we will use the `/etc/ssh/sshd_config` file on our `Pwnbox` instance.

| **doot** | **doot**                                                               |
| -------- | ---------------------------------------------------------------------- |
| 1        | Show all lines that do not contain the `#` character.                  |
| 2        | Search for all lines that contain a word that starts with `Permit`.    |
| 3        | Search for all lines that contain a word ending with `Authentication`. |
| 4        | Search for all lines containing the word `Key`.                        |
| 5        | Search for all lines beginning with `Password` and containing `yes`.   |
| 6        | Search for all lines that end with `yes`.                              |

# Permission Management
Under Linux, permissions are assigned to users and groups. Each user can be a member of different groups, and membership in these groups gives the user specific, additional permissions. Each file and dir belongs to a specific user and a specific group. So the perms for usrs and groups that def a file are also def'd for the respective owners. When a new files or dir is created, it belongs to the group the user is a part of as well as the user.

Whenever a user wants to access the contents of a Linux dir, they must first traverse the dir, which means navigating to that dir, req'ing the user to have `execute (x)` perms on the dir. W/o this perm, the user cannot access the dir's contents and will instead be presented with a "`Permissions Denied`" error msg.

> [!Note] Important Note:
> `Execute` permissions are necessary to traverse a directory, no matter the user's level of access. Additionally, `execute` permissions on a directory do not allow a user to execute or modify any files or contents within the directory, only to traverse and access the content of the directory.
> 
> To execute files within a directory, a user needs `execute` permissions on the corresponding file. To modify the contents of a directory (create, delete, or rename files and subdirectories), the user needs `write (w)` permissions on the directory

The whole permissions system on Linux systems is based on the octal number system, and basically, there are three different types of permissions a file or dir can be assigned:
- (`r`) - Read
- (`w`) - Write
- (`x`) - Execute
The perms can be set for the `owner`, `group`, and `others`:
```permission-explanation
$ ls -l /etc/passwd

- rwx rw- r--   1 root root 1641 May  4 23:42 /etc/passwd
- --- --- ---   |  |    |    |   |__________|
|  |   |   |    |  |    |    |        |_ Date
|  |   |   |    |  |    |    |__________ File Size
|  |   |   |    |  |    |_______________ Group
|  |   |   |    |  |____________________ User
|  |   |   |    |_______________________ Number of hard links
|  |   |   |_ Permission of others (read)
|  |   |_____ Permissions of the group (read, write)
|  |_________ Permissions of the owner (read, write, execute)
|____________ File type (- = File, d = Directory, l = Link, ... )
```
## Change Permissions w `chmod`
Modify perms with the `chmod` command, perm group references (`u` - owner, `g` - group, `o` - others, `a` - all users), and either a `+` or a `-` to add or remove the designated perms.
```add-read-perms-all-users
chmod a+r <file-or-dir>
chmod 754 <file-or-dir>
```
```calc-octal-value
Binary Notation:                4 2 1  |  4 2 1  |  4 2 1
----------------------------------------------------------
Binary Representation:          1 1 1  |  1 0 1  |  1 0 0
----------------------------------------------------------
Octal Value:                      7    |    5    |    4
----------------------------------------------------------
Permission Representation:      r w x  |  r - x  |  r - -
```
In the octal calculation, the first digit sets permissions for the owner, the second for the group, and the third for others.

|Octal Value|File Permissions Set|Permissions Description|
|:--|:--|:--|
|0|---|No permissions|
|1|--x|Execute permission only|
|2|-w-|Write permission only|
|3|-wx|Write and execute permissions|
|4|r--|Read permission only|
|5|r-x|Read and execute permissions|
|6|rw-|Read and write permissions|
|7|rwx|Read, write, and execute permissions|
## Change Owner w `chown`
```syntax
$ chown <user>:<group> <file/dir>
```
## SUID & SGID
Besides assigning direct user and group perms, you can also conf special perms for files by setting the `Set User ID (SUID)` and `Set Group ID (SGID)` bits e.g. these `SUID`/`SGID` bits allow users to run prgs w the rights of another user. Admins often use this to give their users special rights for certain applications or files. The letter "`s`" is used instead of an "`x`". When executing such a prg, the SUID/SGID of the file owner is used.

Often, admins are not familiar with the applications but still assign the SUID/SGID bits, which leads to a high-sec risk. Such prgs may contain functions that allow the execution of a shell from a pager, such as the application "`journalctl`."

If the admin sets the SUID bit to "`journalctl`," any user with access to this app could execute a shell as `root`. More information about this and other such applications can be found at [GTFObins](https://gtfobins.github.io/gtfobins/journalctl/).

## Sticky Bit
Sticky bits are a type of file perms in Linux that can be set on dirs. This type of perm provides an extra layer of sec when ctrl'ing the deletion and renaming of files w/i a dir. It is typically used on dirs that are shared by multiple users to prevent one user from accidentally deleting or renaming files that important to others.

When a sticky bit is set on a dir, it is rep'd by the letter `t` in the execute perm of the dir's perms e.g. if a dir has perms `rwxrwxrwt`, it means the sticky bit is set for the `others`.

If the sticky bit is capitalized (`T`), then all `other` users do not have `execute (x)` perms and, therefore, cannot see the contents of the folder nor run any prgs from it. The lowercase sticky bit (`t`) is the sticky bit where the `execute (x)` perms have been set.
# User Management
Sometimes admins need to create new users or add other users to specific groups, or to execute cmds as a diff user. It's not rare that users of only one specific group have the perms to view or edit specific files or dirs. This allows pentesters to collect more info locally on the machine, which can be v important. 

Here is a list that will help us to better understand and deal with user management.

|**Command**|**Description**|
|---|---|
|`sudo`|Execute command as a different user.|
|`su`|The `su` utility requests appropriate user credentials via PAM and switches to that user ID (the default user is the superuser). A shell is then executed.|
|`useradd`|Creates a new user or update default new user information.|
|`userdel`|Deletes a user account and related files.|
|`usermod`|Modifies a user account.|
|`addgroup`|Adds a group to the system.|
|`delgroup`|Removes a group from the system.|
|`passwd`|Changes user password.|

User management is essential in any operating system, and the best way to become familiar with it is to try out the individual commands in conjunction with their various options.
# Package Management
Packages are archives that contain binaries of software, configuration files, information about dependencies and keep track of updates and upgrades. The features that most package management systems provide are:
- Package downloading
- Dependency resolution
- A standard binary package format
- Common installation and configuration locations
- Additional system-related configuration and functionality
- Quality control
If an installed software has been deleted, the package management system then retakes the package's information, modifies it based on its configuration, and deletes files. There are different package management programs that we can use for this. Here is a list of examples of such programs:

|**Command**|**Description**|
|---|---|
|`dpkg`|The `dpkg` is a tool to install, build, remove, and manage Debian packages. The primary and more user-friendly front-end for `dpkg` is aptitude.|
|`apt`|Apt provides a high-level command-line interface for the package management system.|
|`aptitude`|Aptitude is an alternative to apt and is a high-level interface to the package manager.|
|`snap`|Install, configure, refresh, and remove snap packages. Snaps enable the secure distribution of the latest apps and utilities for the cloud, servers, desktops, and the internet of things.|
|`gem`|Gem is the front-end to RubyGems, the standard package manager for Ruby.|
|`pip`|Pip is a Python package installer recommended for installing Python packages that are not available in the Debian archive. It can work with version control repositories (currently only Git, Mercurial, and Bazaar repositories), logs output extensively, and prevents partial installs by downloading all requirements before starting installation.|
|`git`|Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.|

# Service and Process Management
In general, there are two types of services: internal, the relevant services that are req'd at system startup e.g. progs that perform hardware-related tasks; and services that are installed by the user, which usually include all server services. Such servers run in the bg w/o any user interaction. These are also called `daemons` and are identified by the letter `d` at the end of the prog name e.g. `sshd` or `systemd`.

Most Linux distros have now switched to `systemd`. This daemon is an `Init process` started first and thus has the process ID (PID) 1 and monitors and takes care of the orderly starting and stopping of other services. All processes have an assigned PID that can be viewed under `/proc/` with the corresponding number. Some processes can have a parent process ID (PPID) and if so, is known as the child process.

Besides `systemctl`, you can also use `update-rc.d` to manage SysV init script links.
## Systemctl
Start the service with: `$ system start ssh`
Check if it runs w/o errors: `$ systemctl status ssh`
Add OpenSSH to the SysV script to tell the system to run this service on startup: `$ systemctl enable ssh`
After rebooting the system, check to see if the OpenSSH server is up: `$ ps -aux | grep ssh`
List all services with: `$ systemctl list-units --type=service`
Use `journalctl` to view the logs of any services that do not start due to an error: `$ journalctl -u ssh.service --no-pager`
## Kill a Process
A process can be in the following states:
- Running
- Waiting (waiting for an event or system resource)
- Stopped
- Zombie (stopped but still has an entry in the process table).
Processes can be controlled using `kill`, `pkill`, `pgrep`, and `killall`. To interact with a process, we must send a signal to it. We can view all signals with the following command:
```kill-a-process
$ kill -l

 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
11) SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
16) SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
31) SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
38) SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
63) SIGRTMAX-1  64) SIGRTMAX
```
The most commonly used are:

|**Signal**|**Description**|
|---|---|
|`1`|`SIGHUP` - This is sent to a process when the terminal that controls it is closed.|
|`2`|`SIGINT` - Sent when a user presses `[Ctrl] + C` in the controlling terminal to interrupt a process.|
|`3`|`SIGQUIT` - Sent when a user presses `[Ctrl] + D` to quit.|
|`9`|`SIGKILL` - Immediately kill a process with no clean-up operations.|
|`15`|`SIGTERM` - Program termination.|
|`19`|`SIGSTOP` - Stop the program. It cannot be handled anymore.|
|`20`|`SIGTSTP` - Sent when a user presses `[Ctrl] + Z` to request for a service to suspend. The user can handle it afterward.|
For example, if a program were to freeze, we could force to kill it with the following command:
```example
$ kill 9 <PID>
```
## Background a Process
Sometimes it is necessary to put a process (such as a scan) in the background to continue using the current session to interact with the system or start other processes. This can be accomplished with the `[ctrl] + Z` shortcut, which sends the `SIGSTP` signal to the kernal and suspends the process. All background processes can be displayed with the `jobs` command. After pressing `[ctrl] + Z`, processes will not be executed further. To keep them running in the background, you have to enter the `bg` command. Alternatively, you can set the process to start in the background by adding an ampersand sign to the end of a command: `ping -c 10 <target> &`, which will show the results once the process finishes.
## Foreground a Process
After that, we can use the `jobs` command to list all background processes. Backgrounded processes do not require user interaction, and we can use the same shell session without waiting until the process finishes first. Once the scan or process finishes its work, we will get notified by the terminal that the process is finished.

If we want to get the background process into the foreground and interact with it again, we can use the `fg <ID>` command.
# Task Scheduling
This is a feature that allows users to schedule and automate tasks, allowing admins and users to run tasks at a specific time or within specific freq's w/o having to start them manually. Examples include automatically updating software, running scripts, cleaning databases, and automating backups. This also allows users to schedule regular and repetitive tasks to ensure they are run regularly. In addition, alerts can be set up to display when certain events occur or to contact administrators or users. There are many different use cases for automation of this type, but these cover most cases.
## Systemd
Systemd is a service used in Linux systems such as Ubuntu, Redhat Linux, and Solaris to start processes and scripts at a specific time. With it, we can set up processes and scripts to run at a specific time or time interval and can also specify specific events and triggers that will trigger a specific task. To do this, we need to take some steps and precautions before our scripts or processes are automatically executed by the system.
1. Create a timer
2. Create a service
3. Activate the timer
### Create a Timer
To create a timer for systemd, first create a dir where the timer script will be stored:
`$ sudo mkdir /etc/systemd/system/mytimer.timer.d`
`$ sudo vim /etc/systemd/system/mytimer.timer`
Then, create a script that configures the timer. The script must contain the following options: "Unit", "Timer", and "Install". The "Unit" option specifies a description for the timer. The "Timer" option specifies when to start the timer and when to activate it. Finally, the "Install" option specifies where to install the timer.
#### Mytimer.timer
```code-txt
[Unit]
Description=My Timer

[Timer]
OnBootSec=3min
OnUnitActiveSec=1hour

[Install]
WantedBy=timers.target
```
Here it depends on how we want to use our script. For example, if we want to run our script only once after the system boot, we should use `OnBootSec` setting in `Timer`. However, if we want our script to run regularly, then we should use the `OnUnitActiveSec` to have the system run the script at regular intervals. Next, we need to create our `service`.
### Create a Service
`$ sudo vim /etc/systemd/system/mytimer.service`
Here we set a description and specify the full path to the script we want to run. The "multi-user.target" is the unit system that is activated when starting a normal multi-user mode. It defines the services that should be started on a normal system startup.
```code-txt
[Unit]
Description=My Service

[Service]
ExecStart=/full/path/to/my/script.sh

[Install]
WantedBy=multi-user.target
```
After that, we have to let `systemd` read the folders again to include the changes.
#### Reload Systemd
```reload-systemd
$ sudo systemctl daemon-reload
```
After that, we can use `systemctl` to `start` the service manually and `enable` the autostart.
#### Start the Timer & Service
```start
$ sudo systemctl start mytimer.service
$ sudo systemctl enable mytimer.service
```
## Cron
Cron is another tool that can be used in Linux systems to schedule and automate processes. It allows users and administrators to execute tasks at a specific time or within specific intervals. For the above examples, we can also use Cron to automate the same tasks. We just need to create a script and then tell the cron daemon to call it at a specific time.

With Cron, we can automate the same tasks, but the process for setting up the Cron daemon is a little different than Systemd. To set up the cron daemon, we need to store the tasks in a file called `crontab` and then tell the daemon when to run the tasks. Then we can schedule and automate the tasks by configuring the cron daemon accordingly. The structure of Cron consists of the following components:

|**Time Frame**|**Description**|
|---|---|
|Minutes (0-59)|This specifies in which minute the task should be executed.|
|Hours (0-23)|This specifies in which hour the task should be executed.|
|Days of month (1-31)|This specifies on which day of the month the task should be executed.|
|Months (1-12)|This specifies in which month the task should be executed.|
|Days of the week (0-7)|This specifies on which day of the week the task should be executed.|
For example, such a crontab could look like this:
```crontab
# System Update
* */6 * * /path/to/update_software.sh

# Execute scripts
0 0 1 * * /path/to/scripts/run_scripts.sh

# Cleanup DB
0 0 * * 0 /path/to/scripts/clean_database.sh

# Backups
0 0 * * 7 /path/to/scripts/backup.sh
```
The "System Update" should be executed every sixth hour. This is indicated by the entry `*/6` in the hour column. The task is executed by the script `update_software.sh`, whose path is given in the last column.

The task `execute scripts` is to be executed every first day of the month at midnight. This is indicated by the entries `0` and `0` in the minute and hour columns and `1` in the days-of-the-month column. The task is executed by the `run_scripts.sh` script, whose path is given in the last column.

The third task, `Cleanup DB`, is to be executed every Sunday at midnight. This is specified by the entries `0` and `0` in the minute and hour columns and `0` in the days-of-the-week column. The task is executed by the `clean_database.sh` script, whose path is given in the last column.

The fourth task, `backups`, is to be executed every Sunday at midnight. This is indicated by the entries `0` and `0` in the minute and hour columns and `7` in the days-of-the-week column. The task is executed by the `backup.sh` script, whose path is given in the last column.

It is also possible to receive notifications when a task is executed successfully or unsuccessfully. In addition, we can create logs to monitor the execution of the tasks.
## Systemd vs. Cron
Systemd and Cron are both tools that can be used in Linux systems to schedule and automate processes. The key difference between these two tools is how they are configured. With Systemd, you need to create a timer and services script that tells the operating system when to run the tasks. On the other hand, with Cron, you need to create a `crontab` file that tells the cron daemon when to run the tasks.
# Network Services
When working with Linux, you will also have to deal with different network services. Communication with other computers over the network, connect, transfer files, analyze network traffic, and learn how to conf such services to ID potential vulns in later pentests. Knowing this also pushes your understanding of netsec as you learn what options each services and its conf entails.

This section will focus on and cover the most important network services. More will be covered in other sections of the vault.
## SSH
Secure Shell (`ssh`) is a network protocol that allows the secure transmission of data and commands over a network. It is widely used to securely manage remote systems and securely access remote systems to execute commands or transfer files. To connect to a remote Linux host via ssh, a corresponding SSH server must be available and running.

The most commonly used SSH server is the OpenSSH server. OpenSSH is a free and open-source software (FOSS) implementation of the Secure Shell (SSH) protocol.

Admins use OpenSSH to securely manage remote systems by est'ing an enc'd connection to a remote host. With OpenSSH, admins can execute commands on remote systems, securely transfer files, and est a secure remote connection w/o the transmission of data and commands being intercepted by third parties.

Install OpenSSH with the following cmd: `$ sudo apt install openssh-server -y`
Check if a server is running using: `$ systemctl status ssh`
Use this command syntax to log into an ssh server: `$ ssh <userid>:<hostname-or-IPaddr>`
OpenSSH can be configured and customized by editing the file `/etc/ssh/sshd_config` with a text editor.
## NFS
Network File System (`NFS`) is a network protocol that allows storage and management of files on remote systems as if they were stored on the local system. It enables easy and efficient management of files across networks. For Linux, there are several NFS servers, including NFS-UTILS (`Ubuntu`), NFS-Ganesha (`Solaris`), and OpenNFS (`Redhat Linux`).

It can also be used to share and manage resources efficiently, e.g. to replace file systems between servers, and offers features such as access controls, real-time file transfers, and support for multiple users accessing data simultaneously. This service can be used just like FTP in case there is no FTP client installed on the target system, or if NFS is running in place of FTP.

Install NFS: `$ sudo apt install nfs-kernel-server -y`
Check server status: `$ systemctl status nfs-kernel-server`
Create NFS share:
```create-nfs-share
$ mkdir nfs_sharing
$ echo 'home/<username>/nfs_sharing hostname(<permissions>)' >> /etc/exports
$ cat /etc/exports | grep -v "#" # Checks perms
```
Mount NFS Share:
```mounting
$ mkdir ~/target_nfs
$ mount <nfs-ip-addr>:<path/to/nfs_share> ~/target_nfs
```
We can configure NFS via the config file `/etc/exports`. This file specifies which dirs should be shared and the access rights for users and systems. It is also possible to conf settings such as the transfer speed and the use of enc. NFS access rights determine which users and systems can access the shared dirs and what actions they can perform. Some of the more important access rights are as follows:

| **Permissions**  | **Description**                                                                                                                                            |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `rw`             | Gives users and systems read and write permissions to the shared directory.                                                                                |
| `ro`             | Gives users and systems read-only access to the shared directory.                                                                                          |
| `no_root_squash` | Prevents the root user on the client from being restricted to the rights of a normal user.                                                                 |
| `root_squash`    | Restricts the rights of the root user on the client to the rights of a normal user.                                                                        |
| `sync`           | Synchronizes the transfer of data to ensure that changes are only transferred after they have been saved on the file system.                               |
| `async`          | Transfers data asynchronously, which makes the transfer faster, but may cause inconsistencies in the file system if changes have not been fully committed. |
## Web Server
Knowing how web servers work as a pentester is paramount, as they are a critical part of web applications and often server as targets for pentesters to atk. A web wever is a type of software that provides data and docs or other applications and functions over the internet. They use the Hypertest Transfer Protocol (HTTP) to send data to clients such as web browsers and receive requests from those clients. These are then rendered in the form of Hypertext Markup Language (HTML) in the client's browser. This type of communication allows the client to create dynamic web pages that respond to the client's req's. Therefore, it is important to understand the various functions of the web server in order to create secure and efficient web applications and also ensure the security of the system. Some of the most popular web servers for Linux servers are Apache, Nginx, Lighttpd, and Caddy. Apache is one of the most popular and widely used web servers and is available on a variety of OS's, including Ubuntu, Solaris, and Redhat Linux.

Pentesters can use web servers for a variety of purposes like performing file transfers and logging in and interactive with a target system through an incoming HTTP or HTTPS port. Additionally, web servers can be leveraged to perform phishing atks by hosting a copy of the target page on your own server and then attempting to steal user creds, as well as a plethora of other possibilities.

Install Apache: `$ sudo apt install apache2 -y`
For Apache 2, edit the `/etc/apache2/apache.conf` file to specify which folders can be accessed and what actions can be performed on those dirs. This file contains the global settings.
```apache-config-example
<Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</directory>
```
This example configuration specifies that the default `/var/www/html` folder is accessible, that the users can use the `Indexes` and `FollowSymLinks` options, that changes to files in the dir can be overridden (`AllowOverride All`), and that `Require all granted` grants all users access to this dir e.g. if a user wants to transfer files to one of the target systems using a web server, they can put the appropriate files in the `/etc/www/html` folder and use `wget` or `curl` or other applications to download these files on the target system.

It's also possible to customize individual settings at the dir level by using the `.htaccess` file, which can be created in the dir in question. This file allows you to conf certain dir-level settings, such as access controls, w/o having to customize the Apache config file. You can also add modules to get features like `mod_rewrite`, `mod_security`, and `mod_ssl` that help you improve the security of your web application.

Python Web Server is a simple, fast alternative to Apache and can be used to host a single folder with a single command to transfer files to another system. To install Python Web Server, first install Python3 then run the following cmd:
`$ sudo apt install python3 -y`
`$ python3 -m http.server`
The Python Web Server will be started on the `TCP/8000` port, and the current folder (or working directory `pwd`) can be accessed. Host another folder with this cmd:
`$ python3 -m http.server --directory <path/to/dir>`
This will start a Python Web Server on the `TCP/8000` port, and allow access to the `<path/to/dir>` folder from the browser. To transfer files to the other system from the Python Web Server, type the link in that system's browser and download the files. 

It is also possible to host a Python Web Server on a port other than the default port by using the `-p` option:
`$ python3 -m http.server -p 443`
## VPN
Virtual Private Network (VPN) is a technoloy that allows the secure connection to another network as though the user was directly in it. This is accomplished by creating an enc'd tunnel connection between the client and the server i.e. all data transmitted over this connection is enc'd.

VPNs are mainly used by companies to provide their employees with secure access to the internal network w/o having to be physically located at the corporate network, which allows employees access to the internal network and all of its resources and applications from any location. Additionally, VPNs can be used to anonymize traffic and prevent outside access.

Some of the most popular VPN servers for Linux servers are OpenVPN, L2TP/IPsec, PPTP, SSTP, and SoftEther. OpenVPN is a popular open-source PVN server available for various OS's and is used by admins for various purposes, including enabling secure remote access to the corporate network, enc'ing net traffic, and anonymizing traffic.

OpenVPN can also be used by pentesters to connect to internal networks, which can happen when a VPN access is created by a customer so the they can test the internal network for sec vulns. This is an alt for cases when the pentester is too far away from the customer. OpenVPN provides a variety of features, including enc, tunneling, traffic shaping, net routing, and the ability to adapt to dynamically changing networks. Install the server and client with the following cmd:
`$ sudo apt install openvpn -y`
Customize and conf file `/etc/openvpn/server.conf` 
Connect to an OpenVPN server using the `.ovpn` file received from the server and running the following cmd:
`$ sudo openvpn --config <file-name>.ovpn`
# Working with Web Services
There are many ways to set up web servers on Linux OSs, with Apache being the most widely used. Apache offers the possibility to create web pages dynamically using server-side scripting langs, such as PHP, Perl, Ruby, Python, JavaScript, Lua, and .NET.
`$ sudo apt install apache2 -y`
After it is started, navigate using your browser to the default page (http://localhost).
![[Pasted image 20240508141328.png]]
This is the default page after installation and serves to confirm that the webserver is working currectly.
## cURL
`cURL` is a tool that allows the transfer of files from the shall over protocols like `HTTP`,`HTTPS`,`FTP`, `FTPS`, or `SCP` and gives the posibility to control and test websites remotely. In addition to the remote servers' content, we can also view individual requests to look at the client's and server's communication.
## Wget
Alternative to `cURL` is the tool `wget`. Use this tool to download files from FTP or HTTP servers directly from the terminal and it servers as a good download manager. The major difference to `cURL` is that with `wget`, the website content is downloaded and stored locally.
## Python3
A third option that is often used when it comes to data transfer is the use of Python3. In this case, the web server's root dir is where the cmd is executed to start the server. 
# Backrup and Restore
Linux systems offer a variety of software tools for backing up and restoring data that are designed to be efficient and secure, ensuring that data is prot'd while also allowing easy access to the data that's needed:
- Rsync
- Deja Dup
- Duplicity
`Rsync` is an open-source tool that allows quick and secure back up of files and folders to a remote location. It is particularly useful for transferring large amts of data over the network, as it only transmits the changed parts of a file. It can also be used to create backups locally or on remote servers. 
`Deja Dup` is a graphical backup tool for Ubuntu that simplifies the backup process, which also allows quick and easy backup of data. This tool provides a user-friendly interface to create backup copies of data on local or remote storage media, such as FTP servers or cloud storage services. It uses `Rsync` as a backend and also supports data enc.
`Duplicity` is another graphical backup tool for Ubuntu that provides users with comprehensive data prot and secure backups. It also uses `Rsync` as a backend and additionally offers the possibility to enc backup copies and store them on remote storage media.
In order to ensure the security and integrity of backups, take steps to enc them. Enc'ing backups ensures that sensitive data is prot'd from unauthorized access. Alternatively, you can enc backups on Ubuntu systems by utilizing tools such as GnuPG, eCryptfis, and LUKS.
Backing up and restoring data is an essential part of data protection. The 321 method is a good baseline rule to follow: 3 copies, on 2 different storage medias, 1 located off-prem.
`sudo apt install rsync -y` will install the latest version of `Rsync`.
`rsync -av /path/to/mydir user@backup_server:/path/to/backup/dir`
This cmd will copy the entire dir (`/path/to/mydir`) to a remote host (`backup_server`), in the `/path/to/backup/dir` directory. The `archive` option (`a`) is used to preserve the original file attr, such as perms, timestamps, etc, and using the `verbose` option (`-v`) provides a detailed output of the progress of the `rsync` op. Additional options can also be added to customize the backup process, such as using compression and incremental backups, as follows:
`$ rsync -avz --backup --backup-dir=/path/to/backup/folder --detele /path/to/mydir user@backup_server_ip:/path/to/backup/dir`
With this cmd, `mydir` is backed up to the remote `backup_serve_ip`, preserving the original file attr, timestamps, and perms, and enabled compression (`-z`) for faster transfers. The `--backup` option creates incremental backups in the dir `/path/to/backup/folder`, and the `--delete` option removes files from the remote host that are no longer present in the source dir.
Use the following cmd to restore a dir from the backup server to the local dir:
`$ rsyn -av user@remote_host:/path/to/backup/dir /path/to/mydir`
## Encrypted Rsync
To ensure the security of the `rsync` file transfer between the local host and the backup server, combine the use of `ssh` and other sec measures to enc data as it is being transferred, making it much more difficult for any unauth individual to access it:
`$ rsync -avz -e ssh /path/to/mydir user@backup_server:/path/to/backup/dir`
Using this cmd securely transfers data between the local host and the backup server over an encrypted SSH connection. The enc key itself is also safeguarded by a comprehensive set of sec protocols, which adds to this security. Additionally, SSH enc is designed to be highly resistant to any attempts to breach sec.
## Auto-Synchronization
Use a combo of `cron` and `rsync` to enable auto-sync by scheduling a `cron` job to run `rsyn` at regular intervals. Throw the previous enc `rsync` in a `.sh` script file, add execute perms with `chmod +x <script>.sh` then create a crontab. The following runs the script every hour at the 0th minute:
`0 * * * * /path/to/<script>.sh`
# File System Management
Linux supports a wide range of file systems, inluding ext2, ext3, ext4, XFS, Btrd, NTFS, and more, which each file system offering unique features and benefits design for different situations. It is important to properly analyze the needs of a given situation before selecting a file system. However, ext2 is a good default file system and NTFS is good when compatibility with Windows is req'd.

The Linux file system is based on the Unix file system, which is a hierarchical structure composed of various components. The inode table is at the top of this structure and the basis for the entire file system. It is a table of info associated with each file and dir on a Linux system. The inode table is like a db of info about every file and dir on a Linux system, containing metadata about the file or dir i.e. perms, size, type, owner, etc. This allows the OS to quickly access and manage files, which can be stored in one of two ways:
- Regular files
- Directories
Where regular files are the most common file type, stored in the root dir of the file system. Dirs are used to store collections of files. When a file is stored in a dir, the dir is referred to as the parent directory for that file. In addition to regular files and dirs, Linux also supports symbolic links, which are references to other files or dirs and can be used to quickly access files that are located in different parts of the file system (like shortcut paths in Windows). Permissions control who has access to files and dirs and each file and dir has an associated set of perms that determines who can read, write, and execute the file. Note: the same perms apply to all users, so if the perms of one user are changed, all other users will also be affected.
## Disks and Drives
Disk management involves managing physical storage devices i.e. hard drives, solid-state drives, and removable storage devices. The main tool for this is `fdisk`, which allows the creation, deletion, and management of partitions on a drive. It can also display info about the partition table. Partitioning a drive on Linux involves dividing the physical storage space into separate, logical sections, each of which can then be formatted with a specific file system (`ext4`,`NTFS`,`FAT32`) and can be mounted as a separate file system. The most common tools for this are `fdisk`,`gpart`, and `GParted`.
### Mounting
Each logical partition or drive needs to be assigned to a specific dir on Linux, in a process called mounting, making it accessible to the file system hierarchy. Once a drive is mounted, it can be accessed and manipulated just like any other dir on the system. The `mount` tool is used for this task and the `/etc/fstab` file is used to def the default file systems that are mounted at boot time. Using the `mount` cmd w/o any args view display currently mounted file systems, including device name, file system type, mount point, and options.
The following cmd will mount a USB drive with the device name `/dev/sdb1` to the dir `/mnt/usb`:
`$ sudo mount /dev/sdb1 /mnt/usb`
Use the following cmd when you are ready to unmount a file system, making sure to specify the mount point:
`$ umount /mnt/usb` Note: the cmd is `umount` not `unmount`
> [!Note] Important Note:
> Unmounting a file system requires sufficient perms and that it is not in use by a running process. Pipe the output of the `lsof` cmd to `grep` to list the open files on the file system.

It's also possible to set the system to automatically unmount a file system when the system is shut down by adding the `noauto` option to an entry to the `/etc/fstab/` file. Additionally, the `/etc/fstab` file contains info about all the file systems that are mounted on the system.
## SWAP
Swap space is a crucial aspect of memory management in Linux, and plays an important role in ensuring that the systems runs smoothly, even when the available physical mem is depleted. When the system runs out of phys mem, the kernel transfers inactive pages of mem to the swap space, freeing up phys mem for use by active processes, in a process known as swapping.

Swap space can be created either during the installation of the OS or at any time afterwards using the `mkswap` and `swapon` cmds. The `mkswap` cmd is used to set up a Linux swap area on a device or in a file, while the `swapon` cmd is used to activate a swap area. The size of the swap space is a matter of personal pref, depends on the amt of phys mem installed in the system, and the type of usage the system will be subjected to. When creating a swap space, it is important to ensure that it is placed on a dedicated partition or file, separate from the rest of the file system. This helps to prevents fragmentation of the swap space and ensures that the system has adequate swap available when it is needed. It is also important to ensure that the swap space is encrypted, as sensitive data may be stored in the swap space temporarily. 

In addition to being used as a extension of physical memory, swap space can also be used for hibernation, which is a power management feature that allows the system to save its state to disk, then power off instead of shutting down completely. When the system is later powered on, it can restore its state from the swap space, returning to the state it was in before it was powered off.
# Containerization
This is the proc of packaging and running apps in isolate environments, i.e. a container, VM, or serverless env, by allowing users to create, deploy, and manage apps quickly, securely, and efficiently, and are incredibly lightweight. W these tools, users can tailor the app to their specific needs. This is perfect for running multiple apps simultaneously and providing scalability and portability.
## Dockers
Docker is a FOSS platform for automating the deployment of apps as self-contained units called containers. It uses a layered filesystem and resource isolation features to provide flexibility and portability as well as providing a robust set of tools for creating, deploying, and managing apps, helping to streamline the containerization proc.
```installation-script
#!/bin/bash

# Preparation
sudo apt update -y
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Add user htb-student to the Docker group
sudo usermod -aG docker htb-student
echo '[!] You need to log out and log back in for the group changes to take effect.'

# Test Docker installation
docker run hello-world
```
The Docker engine and specific Docker imgs are needed to run a container, all of which can be obtained from the [Docker Hub](https://hub.docker.com/), a repo of pre-made imgs, or created by the user. The [Docker Hub](https://hub.docker.com/) is a cloud-based registry for software repos, i.e. a library for Docker images. It is divided into a `public` and a `private` area. The public area allows users to upload and share images w the community. It also contains official images from the Docker dev team and est open-source projs. Imgs uploaded to a private area of the reg are not publicly accessible. They can only be shared w/i a co or w teams and acquaintances.

Creating a Docker img is done by creating a [Dockerfile](https://docs.docker.com/engine/reference/builder/), which contains all the instructions the Docker engine needs to create the container. You can use Docker containers as your "file hosting" server when transferring specific files to your target system. Therefore, you must create a `Dockerfile` based on Ubuntu 22.04 with `Apache` and `SSH` servers running. Then, use `scp` to transfer files to the docker img, and `Apache` allows you to host files and use tools like `cURL` and `wget` from the target system to download the req'd files.
```example-dockerfile
# Use the latest Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Update the package repository and install the required packages
RUN apt-get update && \
    apt-get install -y \
        apache2 \
        openssh-server \
        && \
    rm -rf /var/lib/apt/lists/*

# Create a new user called "student"
RUN useradd -m docker-user && \
    echo "docker-user:password" | chpasswd

# Give the htb-student user full access to the Apache and SSH services
RUN chown -R docker-user:docker-user /var/www/html && \
    chown -R docker-user:docker-user /var/run/apache2 && \
    chown -R docker-user:docker-user /var/log/apache2 && \
    chown -R docker-user:docker-user /var/lock/apache2 && \
    usermod -aG sudo docker-user && \
    echo "docker-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Expose the required ports
EXPOSE 22 80

# Start the SSH and Apache services
CMD service ssh start && /usr/sbin/apache2ctl -D FOREGROUND
```
### Docker Build
After defining the Dockerfile, convert it to an img with the `build` cmd. This takes the dir w the Dockerfile and executes the steps from the `Dockerfile` and stores the img in the local Docker Engine. If one of the steps fails due to an err, the container creation will be aborted. Passing the `-t` flag will assign a tag to the container, making it easier to ID and work w later:
`$ docker build -t FS_docker .`
Once the Docker img has been created, it can be executed through the Docker engine, similar to the VM concept, based on imgs. The main diff here being that these imgs are read-only templates and provide the file system necessary for runtime and all parameters. A container can be considered a running proc of an img, i.e. when a container is to be started on a system, a pkg w the respective img is first loaded if locally unavailable. Start the container with the following cmd `docker run`(docs can be found [here](https://docs.docker.com/engine/reference/commandline/run/)):
`$ docker run -p <host-port>:<docker-port> -d <docker-container-name>` 
### Docker Management
When managing Docker containers, Docker provides a comprehensive suite of tools that allow users to easily create, deploy, and manage containers. Some of the more commonly used cmds are as follows:

|**Command**|**Description**|
|---|---|
|`docker ps`|List all running containers|
|`docker stop`|Stop a running container.|
|`docker start`|Start a stopped container.|
|`docker restart`|Restart a running container.|
|`docker rm`|Remove a container.|
|`docker rmi`|Remove a Docker image.|
|`docker logs`|View the logs of a container.|
>[!Note]
>It is worth noting that these cmds can be combined w various opt's to provide additional functionality, e.g. specifying which ports to expose, mount volumes, or set env vars. This allows users to customize Docker containers to suit their needs and req's. 
>
>Additionally, it's important to note that any changes made to an existing img are not permanent. Instead, create a new img that inherits from the original and includes the desired changes, which is done by creating a new Dockerfile that starts w the `FROM` statement, specifying the base img, and then adds the necessary cmds to make the desired changes. Then, use the `docker build` cmd as before to build the new img, making sure to tag it w a unique name to help ID it.

## Linux Containers (LXC)
This virtualization tech allows multiple isolated Linux systems to run on a single host. It uses resource isolation features, such as `cgroups` and `namespaces`, to provide a lightweight virtualization solution. LXC also provides a rich set of tools and APIs for managing and configuring containers. By combining the adv's of LXC w the power of Docker, users can achieve a fully-fledged containerization experience in Linux systems.
`$ sudo apt install lxc lxc-utils -y`
### Creating an LXC Container
After installing LXC, use the `lxc-create` cmd following by the container's name and the template to use e.g. use the following cmd to create a new Ubuntu container named `linuxcontainer`:
`$ sudo lxc-create -n linuxcontainer -t ubuntu`
### Managing LXC Containers
Several tasks are involved in managing LXC containers, including creating new containers, settings config, starting and stopping containers, and monitoring performance. Fortunately, there are many cmd-line tools and config files avail that can assist w these tasks, enabling users to quickly and easily manage containers and ensure they are optimized for the user's specific needs and req's.

|Command|Description|
|---|---|
|`lxc-ls`|List all existing containers|
|`lxc-stop -n <container>`|Stop a running container.|
|`lxc-start -n <container>`|Start a stopped container.|
|`lxc-restart -n <container>`|Restart a running container.|
|`lxc-config -n <container name> -s storage`|Manage container storage|
|`lxc-config -n <container name> -s network`|Manage container network settings|
|`lxc-config -n <container name> -s security`|Manage container security settings|
|`lxc-attach -n <container>`|Connect to a container.|
|`lxc-attach -n <container> -f /path/to/share`|Connect to a container and share a specific directory or file.|
## Advantages
Pentesters often encounter situations where they must test software or system dependencies or configs that are difficult to reproduce on machines. LXC's are a perfect solution, as they are lightweight, standalone executable pkgs containing all the necessary dependencies and conf files to run a specific software or system, providing an isolated env that can be run on any Linux machine, regardless of the host's configs.
Containers are particularly useful to test exploits or malware in a controlled env where pentesters can create a container that sims a vuln sys or network and then use that container to safely test those exploits and malware w/o the risk of dmging host machines or networks. However, it is important to conf containers securely to prevent unauth access or malicious activities inside the container. This can be achieved by implementing several sec measures, including:
- Restricting access to the container
- Limiting resources
- Isolating the container from the host
- Enforcing mandatory access control (AC)
- Keeping the container up to date
## Differences
The main diff's of LXC and Docker can be distinguished based on the following categories:
- Approach
- Image Building
- Portability
- Ease of Use
- Security
LXC in a lightweight virt tech that uses resource isolation features of the Linux kernel to provide an isolated env for apps. In LXC, imgs are manually built by creating a root filesystem and installing the necessary pkgs and configs. Those containers are tied to the host system, may not be easily portable, and may req more technical expertise to conf and manage. LXC also provides some sec feats but may not be as robust as Docker.
Docker is an app-centric platform that builds on top of LXC and provides a more user-friendly interface for containerization. Its imgs are build using a Dockerfil, which specifies the base img and the steps req'd to build the img. Those imgs are designed to be portable so they can be easily moved from one env to another. Docker also comes with a rich set of tools and APIs for managing and configuring containers w a more secure env for running apps.

| Optional | Exercises                                                                                              |
| -------- | ------------------------------------------------------------------------------------------------------ |
| 1        | Install LXC on your machine and create your first container.                                           |
| 2        | Configure the network settings for your LXC container.                                                 |
| 3        | Create a custom LXC image and use it to launch a new container.                                        |
| 4        | Configure resource limits for your LXC containers (CPU, memory, disk space).                           |
| 5        | Explore the `lxc-*` commands for managing containers.                                                  |
| 6        | Use LXC to create a container running a specific version of a web server (e.g., Apache, Nginx).        |
| 7        | Configure SSH access to your LXC containers and connect to them remotely.                              |
| 8        | Create a container with persistence, so changes made to the container are saved and can be reused.     |
| 9        | Use LXC to test software in a controlled environment, such as a vulnerable web application or malware. |
# Network Configuration
One key skill req'd as a pentester is conf'ing and managing network settings on Linux sys's. This skill is invaluable in setting up test env's, controlling net traffic, or ID'ing and exploiting vulns. By understanding Linux's net conf options, users can tailor their approach to suit specific needs and optimize results.
One of the primary net conf tasks is config'ing network interfaces, including assigning IP addr, conf net devices such as routers and switches, and setting up net protocols. It is essential to thoroughly understand the net protocals and their specific use-cases, e.g. TCP/IP, DNS, DHCP, and FTP. Additionally, familiarize yourself w diff net interfaces such as wireless and wired connections, and be able to troubleshoot connectivity issues.
Network access control (NAC) is another crit component of net config. It's important to be familiar w the importance of NAC for net sec and the diff NAC techs avail, including discretionary access control (DAC), mandatory access control (MAC), and role-based access control (RBAC). Understand the diff NAC enforcement mechanisms and know how to config Linux net devices for NAC, including setting up SELinux policies, config AppArmor profiles, and using TCP wrappers to control access.
Monitoring net traf is also essential in net config, therefore know how to config net monitoring and logging and be able to analyze net traff for sec purposes using tools such as `syslog`, `rsyslog`, `ss`, `lsof`, and the `ELK` stack.
Moreover, good knowledge of net troubleshooting tools is crucial for IDing vulns and interacting w other networks and hosts. Additionally, familiarize yourself with network diagnostic and enumeration tools such as `ping`, `nslookup`, and `nmap`, which can provide valuable insight into the net traff, packet loss, latency, DNS resolution, and so much more. Understanding how to effectively use these tools will allow a user to quickly pinpoint root causes of any network problems and take the necessary steps to resolves them.
## Configuring Network Interfaces
The `ifconfig` and `ip` cmds are used to view and configure local net interfaces, such as `eth0` on Linux. The `ifconfig` cmd is used to obtain info such as IP addr, netmasks, and status, which are displayed in a clear and organized manner, and is particularly useful when troubleshooting network connectivity issues or setting up a new net config. It should be noted that the `ifconfig` cmd has been deprecated in newer versions of Linux and replaced by the `ip` cmd, which offers more advanced feats. Nevertheless, `ifconfig` is still widely used in many Linux distros and continues to be a reliable tool for net mngment.
- `$ sudo ifconfig eth0 up` and `$ sudo ip link set eth0 up` will both activate the `eth0` net interface.
- `$ sudo ifconfig eth0 192.168.1.2` assigns the ip addr `192.168.1.2` to the `eth0` interface.
- `$ sudo ifconfig eth0 netmask 255.255.255.0` assigns the netmask `255.255.255.0` to `eth0`.
- `$ sudo route add default gw 192.168.1.1 eth0` sets the default gateway (`default gw`) `192.168.1.1` to `eth0`. This designated the IP addr of the router that will be used to send traff to destinations outside the local network. Incorrectly configuring this can lead to connectivity issues.
- When configuring a net interface, it is often necessary to set the Domain Name System (`DNS`) servers to ensure proper net functionality. DNS servers translate domain names into IP addrs, allowing devices to connect w each other on the internet. W/o proper DNS server config, devices may experience net connectivity issues and be unable to access certain online resources. 
	- The `/etc/resolv.conf` file is a plaintext file containing the sys's DNS info. The sys can properly resolve domain names to IP addr's by adding the require DNS server to this file. It is important to note that any changes made to this file will only apply to the current session and must be updated if the sys is restarted or the net config is changed:
		`$ sudo nano /etc/resolv.conf` then add 
		`nameserver 8.8.8.8`
		`nameserver 8.8.4.4`
- After completing the necessary mods to the net config, it is essential to ensure that these changes are saved to persist across reboots by editing the `/etc/network/interfaces` file, which def's net interfaces for Linux-based OS's. Thus, it is vital to save any changes made to this file to avoid any potential issues w net connectivity.
```example-config
auto eth0
iface eth0 inet static
	address 192.168.1.2
	netmask 255.255.255.0
	gateway 192.168.1.1
	dns-nameservers 8.8.8.8 8.8.4.4
```
This sets the `eth0` net interface to the static IP addr of `192.168.1.2`, w a netmask of `255.255.255.0` and a default gateway of `192.168.1.1`, and specifies the DNS servers of `8.8.8.8` and `8.8.4.4`. All of which is placed in the `/etc/network/interfaces` file, which persists across reboots and ensures network connection remains stable and reliable. After making these changes, restart the networking service to apply them:
`$ sudo systemctl restart networking`
## Network Access Control
NAC is an important component of netsec, esp in today's era of inc cyber threats. As a pentester, it is vital to understand the significance of NAC in prot the net and the various NAC techs that can be utilized to enhance sec measure. NAC is a sec sys that ensures that only auth and compliant devices are granted access to the network, preventing unauth access, data breaches, and other sec threats. By implementing NAC, orgs can be confident in their ability to prot their assets and data from cybercriminals who always seek to exploit sys vulns.  DAC, MAC, and RBAC are techs designed to provide diff levels of AC and sec. Each tech has its unique characteristics and is suitable for diff use cases and it is important to know these as a pentester to effectively test and eval a net's sec.
### Discretionary Access Control
DAC helps orgs provide access to their resources while mnging the associated risks of unath access by granting resource owners the responsibility of controlling access perms to their resources as well as what actions (read, write, execute, delete) can be performed by which auth user. 
### Mandatory Access Control
MAC is used in infrastructure that provides more fine-grained control over resource access than DAC sys's by defining rules that determine resource access based on the resource's sec level and the user's sec level or process requesting access. Each resource is assigned a sec label that ID's its sec level, and each user or proc is assigned a sec clearance the ID's its sec level. Access to a resource is only granted if the user's or proc's sec level is equal to or greater than the sec level of the resource. MAC is often used is OS's and apps that req a high level of sec, such as military or gov sys's, financial sys's, and healthcare sys's. MAC sys's are designed to prevent unauth access to resources and minimize the impact of sec breaches.
### Role-Based Access Control
RBAC assigns perms to users based on their roles w/i an org. Users are assigned roles based on their job responsibilities or other criteria, and each role is granted a set of perms that determine the actions they can perform. RBAC simplifies the mngm of access perms, reduces the risk of errs, and ensures that users can access only the resources necessary to perform their job functions. It can restrict access to sensitive resources and data, limit the impact of sec breaches, and ensure compliance w regulatory reqs. Compared to DAC sys's, RBAC provides a more flexible and scalable approach to mng resource acess. In an RBAC sys, each user is assigned one or more roles, and each role is assigned a set of perms that def the user's actions. Resource access is granted based on the user's assigned role rather than their ID or ownership of the resource. RBAC sys's are typically used in env w many users and resources, such as large orgs, gov agencies, and financial institutions.
## Monitoring
Net monitoring involves capturing, analyzing, and interpreting net traff to ID sec threats, vulns, performance issues, and suspicious behavior. E.g. pentesters can capture creds when someone uses an unenc connection and tried to log into an FTP server. As a result, these creds might help to infiltate the network even further or escalate privileges to a higher level.
## Troubleshooting
Net troubleshooting involves ID, analyzing, and implementing solutions to resolve problems. Some of the most commonly used tools include:
1. Ping
2. Traceroute
3. Netstat
4. TCPDump
5. Wireshark
6. Nmap
### Ping
`$ ping <remote_host>` will send ICMP packets to `<remote_host>` and display the response times.
### Traceroute
`$ traceroute <remote_host>` traces the route packets take to reach `<remote_host>` by sending packets w inc Time-to-Live (TTL) vals to `<remote_host>` and displays the IP addrs of the devices that the packets pass through. When setting up a net connection, it is important to specify the dest host and IP addr. This ensures that the connection is est effeciently and reliably and by providing this info, the sys can route traff to the correct dest and limit the num of intermediate stops the data needs to make.
### Netstat
Used to disp active net connections and their associated ports. It can be used to ID net traff and troubleshoot connectivity issues.
Using `netstat` will display detailed info about each connection, uncluding the protocol used, the num of bytes sent and received, IP addr's, port nums of both local and remote devices, and the current connection state. The output of `$ netstat -a` provides valuable insights into the net activity on the sys, highlighting specific connections currently active and listening on specific ports. By knowing which ports are used by which services, users can quickly ID any net issues and troubleshoot accordingly. The most common net issues encountered during a pentest include:
- Network connectivity issues
- DNS resolution issues (hint: it's always DNS)
- Packet loss
- Network performance issue
- Misconfig firewalls or router
- Dmgd net cables or connectors
- Incorrect net settings
- Hardware failure
- Incorrect DNS server settings
- DNS server failure
- Misconf DNS records
- Network congestion
- Outdated net hardware
- Incorrectly conf net settings
- Unpatched software or firmware
- Lack of proper sec ctrls
## Hardening
Several mechanisms are highly effective in securing Linux sys's in keeping data safe. Three such mechanisms are SELinux, AppArmor, and TCP wrappers. These tools are designed to safeguard Linux sys's against various sec threats, from unauth access to malicious atks, esp while conducting a pentest. There is almost no worse scenario than when a co is compromised dur to a pentest. By implementing these sec measures and ensuring that corresponding prots are set up against potential arkrs, the risk of data leaks is significantly reduced and sys's remain secure. 
### Differences
#### SELinux
A MAC sys that is built into the Linux kernel designed to provide fine-grained access ctrl o/ sys resources and apps. SELinux works by enforcing a policy that def's the access ctrls for each proc and file on the sys. It provides a higher level of sec by limiting the dmg a compromised proc can do.
#### AppArmor
A MAC sys that provides a similar level of ctrl o/ a sys resources and apps to SELinux, but is instead implemented as a `Linux Security Module` (`LSM`) and uses profiles to def the resources that an app can access. AppArmor is typically easier to use and conf than SELinux but may not provide the same level of fine-grained ctrl.
#### TCP Wrappers
A host-based net AC mechanism that can be used to restrict access to network services based on the IP addr of the client sys. It works by intercepting incoming net requests and comparing the IP addr of the client sys to the AC rules. These are useful for limiting access to net services from unauth sys's.
### Similarities
These three sec mechanisms share the common goal of ensuring the safety and security of Linux sys's by providing extra prot, restricting access to resources and services, and reducing the risk of unauth access and data breaches. It's also worth noting that these mechanisms are readily avail as part of most Linux distros, making them accessible to pentesters to enhance sys sec. Furthermore, these mechanisms can be easily customized and conf'd using std tools and utils, making them a convenient choice for Linux users.
## Setting up
Navigating the world of Linux will inevitably encounter a wide range of techs, apps, and services that are important. Being able to become proficient in these is a crucial skill, particularly when working in cybersec and strive to improve expertise continuously. It is highly recommended to dedicate time to learning about conf'g important sec measures such as `SELinux`, `AppArmor`, and `TCP wrappers`. It is also recommended to use a personal VM and make freq snapshots, esp before making changes.

There is no one-size-fits-all approach to implementing cybersec measures. It is important to consider specific info that warrants protection and the tools used to do so. However, you can practice and implement several optional tasks w other prospective pentesters in the HtB Discord channel to inc knowledge and skills in this area. By taking adv of the helpfulness of others and sharing your own expertise, you can deepen your understanding of cybersec and help others do the same. Remember: explaining concepts to others helps solidify knowledge in your own mind.
### Optional Exercises
#### SELinux

| d   | d                                                                                                            |
| --- | ------------------------------------------------------------------------------------------------------------ |
| 1.  | Install SELinux on your VM.                                                                                  |
| 2.  | Configure SELinux to prevent a user from accessing a specific file.                                          |
| 3.  | Configure SELinux to allow a single user to access a specific network service but deny access to all others. |
| 4.  | Configure SELinux to deny access to a specific user or group for a specific network service.                 |
#### AppArmor

| d   | d                                                                                                             |
| --- | ------------------------------------------------------------------------------------------------------------- |
| 5.  | Configure AppArmor to prevent a user from accessing a specific file.                                          |
| 6.  | Configure AppArmor to allow a single user to access a specific network service but deny access to all others. |
| 7.  | Configure AppArmor to deny access to a specific user or group for a specific network service.                 |
#### TCP Wrappers

| d   | d                                                                                                  |
| --- | -------------------------------------------------------------------------------------------------- |
| 8.  | Configure TCP wrappers to allow access to a specific network service from a specific IP address.   |
| 9.  | Configure TCP wrappers to deny access to a specific network service from a specific IP address.    |
| 10. | Configure TCP wrappers to allow access to a specific network service from a range of IP addresses. |
# Remote Desktop Protocols in Linux
Remote desktop protocols (RDPs) are used in Windows, Linux, and macOS to provide graphical remote access to a system. The admins can utilize RDP in many scenarios like troubleshooting, software or sys upgrading, and remote sys admin. The admin needs to connect to the remote sys they will administer remotely, and, therefore, they use the appropriate protocol accordingly. In addition, they can log in using diff protocols if they want to install an app on their remote sys. The most common protocols for this are RDP (Windows) and VNC (Linux).
## XServer
The XServer is the user-side part of the `X Window System network protocol` (`X11`/`X`). The `X11` is a fixed system that consists of a collection of protocols and apps that allow admins to call application windows on displays in a graphical user interface (GUI). X11 is predominant on Unix systems, but X servers are also avail for other OS's. Nowadays, the XServer is a part of almost every desktop installation of Ubuntu and its derivatives and does not need to be installed separately.

When a desktop is started on a Linux computer, the communication of the GUI w the OS happens via an X server. The computer's internal network is used, even if the computer should not be in a network. The practical thing about the X protocol is net transparency. This protocol mainly uses TCP/IP as a transport base but can also be used on pure Unix sockets. The ports that are utilized for X server are typically located in the range of `TCP/6001-6009`, allowing communication b/w the client and server. When starting a new desktop session via X server the `TCP port 6000` would be opened for the first X display `:0`. This range of ports enable the server to perform its tasks such as hosting apps, as well as providing services to clients. They are often used to provide remote access to a sys, allowing users to access apps and data from anywhere in the world. Additionally, these ports are also essential for the secure sharing of files and data, making them an integral part of the Open X Server. Thus, an X server is not dependent on the local computer, it can be used to access other computers, and other computers can use the local X sever. Provided that both local and remote computers contain Unix/Linux sys's, additional protocols such as VNC and RDP are superfluous. VNC and RDP gen the graphical output on the remote computer and transport it o/ the network. Whereas w X11, it is rendered on the local computer, saving traffic and a load on the remote computer. However, X11's significant disadv in the unenc data transmission, but this can be overcome by tunneling the SSH protocol.
For this, allow X11 forwarding in the SSH conf file (`/etc/ssh/sshd_config`) on the server that provides the app by changing this option to `yes`
`$ cat /etc/ssh/sshd_config | grep X11Forwarding`
with this, start the application from the client w the following cmd (which will start firefox):
`$ ssh -X <userid>@<remote_host> /usr/bin/firefox`
## X11 Security
X11 is not a secure protocol w/o suitable security measures since X11 comminucation is entirely unenc e.g. a completely open X server lets anyone on the network read the contents of its windows, which goes entirely unnoticed by the user sitting in front of it. Therefore, it is not even necessary to sniff the network. This std X11 functionality is realized w simple X11 tools like `xwd` and `xgrabsc`. This means that anyone one the network can read users' keystrokes, obtain screenshots, move the mouse cursor and send keystrokes from the server o/ the network.

A good example is several vulns found in XServer, where a local atkr can exploit vulns in XServer to execute arbitrary code w user priv and gain user privs. The OS affected by these vulns were UNIX and Linux, Red Hat Enterprise Linux, Ubuntu Linux, and SUSE Linux. THese vulns are known as CVE-2017-2624, CVE-2017-2625, and CVE-2017-2626.
## XDMCP
The `X Display Manager Control Protocol` (`XDMCP`) is used by the `X Display Manager` for communication through UDP port 177 b/w X terminals and computers operating under Unix/Linux. It is used to mng remote X Window sessions on other machines and is often used by Linuc sysadmins to provide access to remote desktops. XDMCP is an insecure protocol and should not be used in any env that req's high levels of sec. W this, it is possible to redirect an entire GUI (e.g. KDE or Gnome) to a corresponding client. For a Linux system to act as an XDMCP server, an X sys w a GUI must be installed and config'd on the server. After starting the comp, a graphical interface should be available locally to the user.

One potential way that XDMCP could be exploited is through a man-in-the-middle atk. In this type of ark, an atkr intercepts the comms b/w the remote comp and the X Window Sys server, and impersonates one of the parties in order to gain unauth access to the server. The atkr could then use the server to run arbitrary cmds, access sensitive data, or perform other actions that could compromise the sec of the sys.
## VNC
`Virtual Network Computing` (`VNC`) is a remote desktop sharing sys based on the RFB protocol that allows users to ctrl a comp remotely. It allows a user to view and interact w a desktop env remotely o/ a network connections. The user can ctrl the remote comp as if sitting in front of it. This is also one of the most common protocols for remote graphical connections for Linux hosts.

VNC is generally considered to be secure. It uses enc to ensure the data is safe while in transit and req auth b4 a user can gain access. Admins make use of VNC to access computers that are not physically accessible. This could be used to troubleshoot and maintain servers, access apps on the other comps, or provide remote access to workstations. VNC can also be used for screen sharing, allowing multiple users to collab on a proj or troubleshoot a problem.

There are two diff concepts for VNC servers. The usual server offers the actual screen of the host comp for user support. B/c the keyboard and mouse mouse remain usable at the remote comp, an arrangement is recommended. The second group of server prgs allows user login to virtual sessions, similar to the terminal server concepts.

Server and viewer progs for VNC are avail for all common OS's. Therefore, many IT services are performed w VNC. The proprietary TeamViewer, and RDP have similar uses.

Traditionally, the VNC server listens on TCP port 5900. So it offers its `display 0` there. Other displays can be offered via additional ports, mostly `590[x]`, where `x` is the display number. Adding multiple connections would be assigned to a higher TCP port like 5901, 5902, 5903, etc.

For these VNC connections, many different tools are used. Among them are for example:

- [TigerVNC](https://tigervnc.org/)
- [TightVNC](https://www.tightvnc.com/)
- [RealVNC](https://www.realvnc.com/en/)
- [UltraVNC](https://uvnc.com/)

The most used tools for such kinds of connections are UltraVNC and Real VNC b/c of their anc and higher sec.

The following cmds sets up a `TigerVNC` server, which req's the `XFCE4` desktop mngr since the VNC connections w GNOME are somewhat unstable. Therefore, it's necessary to install needed pkgs and create a pwd for the VNC connection.
```installing-tigervnc
$ sudo apt install xfce4 xfce4-goodies tigervnc-standalonge-server -y
$ vncpasswd

Password: ******
Verify: ******
Would you like to enter a view-only password (y/n)? n
```
During installation, a hidden folder is created in the home dir called `.vnc`. Then, you have to create two additional files, `xstartup` and `config`. The `xstartup` file determines how the VNC session is created in connection w the display mngr, and the `config` determines its settings.