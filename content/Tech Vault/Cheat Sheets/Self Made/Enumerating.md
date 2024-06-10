> [!Remember]
> Always take notes and screenshots of outputs and info

Start by running the following cmds to orient yourself and taking screenshots of the outputs.
- `whoami` - what user are you running as
- `id` - what groups does your user belong to?
- `hostname` - what is the server named. can you gather anything from the naming convention?
- `ifconfig` or `ip -a` - what subnet did you land in, does the host have additional NICs in other subnets?
- `sudo -l` - can your user run anything with sudo (as another user as root) w/o needing a password? This can sometimes be the easiest win and you can do something like `sudo su` and drop right into a root shell.
- `$ cat /etc/os-release` is used to obtain OS info and check to see if it is out-of-date or maintained.
- `$ echo $PATH` will output the current user's `PATH`.
- `$ env` will return environment variables that are set for the current user. It is possible to get lucky and find something sensitive in there, like a passwd.
- `$ uname -a`, or `$ cat /proc/version` to note down the Kernel version.
- `lscpu` to gather additional info about the host itself.
- `$ cat /etc/shells` to show what login shells exist on the host