# Introduction
The root acct on Linux sys's provides full admin level access to the OS. During an assessment, you may gain a low-priv shell on a Linux host and need to perform priv escalation to the root acct. Fully compromising the host would allow us to capture traff and access sensitive files, which may be used to further access w/i the env. Additionally, if the Linux machine is domain joined, you can gain the NTLM hash and being enum'ing and atk'ing AD (Active Directory).
## Enumeration
Enum is the key to priv-esc. Several helper scripts (such as [LinEnum](https://github.com/rebootuser/LinEnum)) exist to assist w enum. Still, it is also important to understand what pieces of info to look for and to be able to perform your enum manually. When you gain initial shell access to the host, it is important to check several key details.

`OS Version`: Knowing the distro (Ubuntu, Debian, FreeBSD, Fedura, SUSE, Red Hat, CentOS, etc) will give you an idea of the types of tools that may be avail. This would also ID the OS version, for which there may be public exploits avail.

`Kernel Version`: As w the OS version, there may be public exploits that target a vuln in a specific kernel version. Kernel exploits can cause system instability or even a complete crash. Be careful running these against any production system, and make sure to fully understand the exploit and possible ramifications b4 running one.

`Running Services`: Knowing what services are running on the host is important, esp those running as root. A misconfig or vuln service running as root can be an easy win for priv-esc. Flaws have been discovered in many common services such as Nagios, Exim, Samba, ProFTPd, etc. Public exploit PoCs exist for many of them, such as CVE-2016-9566, a local priv-esc flaw in Nagios Core < 4.2.4.
#### List Current Processes
```shell
$ ps aux | grep root

root         1  1.3  0.1  37656  5664 ?        Ss   23:26   0:01 /sbin/init
root         2  0.0  0.0      0     0 ?        S    23:26   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        S    23:26   0:00 [ksoftirqd/0]
root         4  0.0  0.0      0     0 ?        S    23:26   0:00 [kworker/0:0]
root         5  0.0  0.0      0     0 ?        S<   23:26   0:00 [kworker/0:0H]
root         6  0.0  0.0      0     0 ?        S    23:26   0:00 [kworker/u8:0]
root         7  0.0  0.0      0     0 ?        S    23:26   0:00 [rcu_sched]
root         8  0.0  0.0      0     0 ?        S    23:26   0:00 [rcu_bh]
root         9  0.0  0.0      0     0 ?        S    23:26   0:00 [migration/0]

<SNIP>
```
`Installed Packages and Versions`: Like running services, it is important to check for any out-of-date or vuln pkgs that may be easily leveraged for priv-esc. As example is Screen, which is a common terminal multiplexer (similar to `tmux`). It allows you to start a session and open many windows or virtual terminals instead of opening multiple terminal sessions. Screen v4.05.00 suffers from a priv-esc vuln that can be easily leveraged.

`Logged in Users`: Knowing which other users are logged into the sys and what they are doing can give greater info into possible local lateral movement and priv-esc paths.
#### List Current Processes
```shell
$ ps au

USER       		PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      		1256  0.0  0.1  65832  3364 tty1     Ss   23:26   0:00 /bin/login --
cliff.moore     1322  0.0  0.1  22600  5160 tty1     S    23:26   0:00 -bash
shared     		1367  0.0  0.1  22568  5116 pts/0    Ss   23:27   0:00 -bash
root      		1384  0.0  0.1  52700  3812 tty1     S    23:29   0:00 sudo su
root      		1385  0.0  0.1  52284  3448 tty1     S    23:29   0:00 su
root      		1386  0.0  0.1  21224  3764 tty1     S+   23:29   0:00 bash
shared     		1397  0.0  0.1  37364  3428 pts/0    R+   23:30   0:00 ps au
```
`User Home Directories`: Are other user's home dir's accessibly? User home folders may also contain SSH keys that can be used to access other sys's or scripts and config files containing creds. It is not uncommon to find files containing creds that can be leveraged to access other sys's or even gain entry into the AD env.
#### Home Directory Contents
```shell
$ ls /home

backupsvc  bob.jones  cliff.moore  logger  mrb3n  shared  stacey.jenkins
```
It is also possible to check individual user dir's and check to see if files such as the `.bash_history` file are readable and contain any interesting cmds, look for config files, and check to see if it's possible to obtain copies of a user's SSH keys.
#### User's Home Directory Contents
```shell
$ ls -la /home/stacey.jenkins/

total 32
drwxr-xr-x 3 stacey.jenkins stacey.jenkins 4096 Aug 30 23:37 .
drwxr-xr-x 9 root           root           4096 Aug 30 23:33 ..
-rw------- 1 stacey.jenkins stacey.jenkins   41 Aug 30 23:35 .bash_history
-rw-r--r-- 1 stacey.jenkins stacey.jenkins  220 Sep  1  2015 .bash_logout
-rw-r--r-- 1 stacey.jenkins stacey.jenkins 3771 Sep  1  2015 .bashrc
-rw-r--r-- 1 stacey.jenkins stacey.jenkins   97 Aug 30 23:37 config.json
-rw-r--r-- 1 stacey.jenkins stacey.jenkins  655 May 16  2017 .profile
drwx------ 2 stacey.jenkins stacey.jenkins 4096 Aug 30 23:35 .ssh
```
If the current user's SSH key is found, this could be used to open an SSH session on the host (if SSH is exposed externally) and gain a stable and fully interactive session. SSH keys could be leveraged to access other sys's w/i the network as well. At the min, check the ARP cache to see what other hosts are being accessed and cross-reference these against any useable SSH private keys.
#### SSH Directory Contents
```shell
$ ls -l ~/.ssh

total 8
-rw------- 1 mrb3n mrb3n 1679 Aug 30 23:37 id_rsa
-rw-r--r-- 1 mrb3n mrb3n  393 Aug 30 23:37 id_rsa.pub
```
It is also important to check a user's bash history, as they may be passing passwds as an arg on the cmd line, working w git repos, setting up cron jobs, etc. Reviewing what the user has been doing can give considerable insight into the type of server you land on and give a hint as to priv-esc paths.
#### Bash History
```shell
$ history

    1  id
    2  cd /home/cliff.moore
    3  exit
    4  touch backup.sh
    5  tail /var/log/apache2/error.log
    6  ssh ec2-user@dmz02.inlanefreight.local
    7  history
```
`Sudo Privileges`: Can the user run any cmds as another user or as root? If you do not have creds for the user, it may be possible to leverage sudo perms. However, often sudoer entries include `NOPASSWD`, meaning that the user can run the specific cmd w/o being prompted for a passwd. Not all cmds, even ones that can be run as root, will lead to priv-esc. It is not uncommon to gain access as a user w full sudo privs, meaning they can run any cmd as root. Issuing a simple `$ sudo su` cmd will immediately give you a root session.
#### Sudo - List User's Privileges
```shell
$ sudo -l

Matching Defaults entries for sysadm on NIX02:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User sysadm may run the following commands on NIX02:
    (root) NOPASSWD: /usr/sbin/tcpdump
```
`Configuration Files`: Config files can hold a wealth of info. It is worth searching through all files that end in ext's such as `.conf` and `.config`, for usernames, passwds, and other secrets.

`Readable Shadow File`: If the shadow file is readable, you will be able to gather passwd hashes for all users who have a passwd set. While this does not guarantee further access, these hashes can be subjected to an offline brute-force atk to recover the cleartext passwd.

`Password Hashes in /etc/passwd`: Occassionally, you will see passwd hashes directly in the /etc/passwd file. This file is readable by all users, and as w hashes in the `shadow` file, these can be subjected to an offline passwd cracking atk. This config, while not common, can sometimes be seen on embedded devices and routers.
#### /etc/passwd
```shell
$ cat /etc/passwd

root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
<...SNIP...>
dnsmasq:x:109:65534:dnsmasq,,,:/var/lib/misc:/bin/false
sshd:x:110:65534::/var/run/sshd:/usr/sbin/nologin
mrb3n:x:1000:1000:mrb3n,,,:/home/mrb3n:/bin/bash
colord:x:111:118:colord colour management daemon,,,:/var/lib/colord:/bin/false
backupsvc:x:1001:1001::/home/backupsvc:
bob.jones:x:1002:1002::/home/bob.jones:
cliff.moore:x:1003:1003::/home/cliff.moore:
logger:x:1004:1004::/home/logger:
shared:x:1005:1005::/home/shared:
stacey.jenkins:x:1006:1006::/home/stacey.jenkins:
sysadm:$6$vdH7vuQIv6anIBWg$Ysk.UZzI7WxYUBYt8WRIWF0EzWlksOElDE0HLYinee38QI1A.0HW7WZCrUhZ9wwDz13bPpkTjNuRoUGYhwFE11:1007:1007::/home/sysadm:
```
`Cron Jobs`: Cron jobs on Linux sys's are similar to Windows scheduled tasks. They are often set up to perform maintenance and backup tasks. In conjuction w other misconfigs such as relative paths or weak perms, they can be leveraged for priv-esc when the scheduled cron job runs.
#### Cron Jobs
```shell
$ ls -la /etc/cron.daily/

total 60
drwxr-xr-x  2 root root 4096 Aug 30 23:49 .
drwxr-xr-x 93 root root 4096 Aug 30 23:47 ..
-rwxr-xr-x  1 root root  376 Mar 31  2016 apport
-rwxr-xr-x  1 root root 1474 Sep 26  2017 apt-compat
-rwx--x--x  1 root root  379 Aug 30 23:49 backup
-rwxr-xr-x  1 root root  355 May 22  2012 bsdmainutils
-rwxr-xr-x  1 root root 1597 Nov 27  2015 dpkg
-rwxr-xr-x  1 root root  372 May  6  2015 logrotate
-rwxr-xr-x  1 root root 1293 Nov  6  2015 man-db
-rwxr-xr-x  1 root root  539 Jul 16  2014 mdadm
-rwxr-xr-x  1 root root  435 Nov 18  2014 mlocate
-rwxr-xr-x  1 root root  249 Nov 12  2015 passwd
-rw-r--r--  1 root root  102 Apr  5  2016 .placeholder
-rwxr-xr-x  1 root root 3449 Feb 26  2016 popularity-contest
-rwxr-xr-x  1 root root  214 May 24  2016 update-notifier-common
```
`Unmounted File Systems and Additional Drives`: If you discover and can mount an additional drive or unmounted file sys, you may find sensitive files, passwds, or backups that can be leveraged for priv-esc.
#### File Systems & Additional Drives
```shell
$ lsblk

NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0   30G  0 disk 
├─sda1   8:1    0   29G  0 part /
├─sda2   8:2    0    1K  0 part 
└─sda5   8:5    0  975M  0 part [SWAP]
sr0     11:0    1  848M  0 rom  
```
`SETUID and SETGID Permissions`: Bins are set w these perms to allow a user to run a cmd as root, w/o having to grant root-level access to the user. Many bins contain functionality that can be exploited to get a root shell.

`Writeable Directories`: It is important to discover which dirs are writeable if you need to download tools to the sys. You may discover a writeable dir where a cron job places files, which provides an idea of how often the cron job runs and could be used for priv-esc if the script that the cron job runs is also writeable.
#### Find Writeable Directories
```shell
$ find / -path /proc -prune -o -type d -perm -o+w 2>/dev/null

/dmz-backups
/tmp
/tmp/VMwareDnD
/tmp/.XIM-unix
/tmp/.Test-unix
/tmp/.X11-unix
/tmp/systemd-private-8a2c51fcbad240d09578916b47b0bb17-systemd-timesyncd.service-TIecv0/tmp
/tmp/.font-unix
/tmp/.ICE-unix
/proc
/dev/mqueue
/dev/shm
/var/tmp
/var/tmp/systemd-private-8a2c51fcbad240d09578916b47b0bb17-systemd-timesyncd.service-hm6Qdl/tmp
/var/crash
/run/lock
```
`Writeable Files`: Are any scripts or config files world-writeable? While altering config files can be extremely destructive, there may be instances where a minor mod can open up further access.
#### Find Writeable Files
```shell
$ find / -path /proc -prune -o -type f -perm -o+w 2>/dev/null

/etc/cron.daily/backup
/dmz-backups/backup.sh
/proc
/sys/fs/cgroup/memory/init.scope/cgroup.event_control

<SNIP>

/home/backupsvc/backup.sh

<SNIP>
```
### Moving on
So far, this module has covered various manual enum techniques that can be performed to gain info to inform various priv-esc atks. A variety of techniques exist that can be leveraged to perform local priv-esc on Linux, which will be covered in the next sections.
# Information Gathering
## Environment Enumeration
Enum is the key to priv-esc. Several help scripts (such as [LinPEAS](https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS) and [LinEnum](https://github.com/rebootuser/LinEnum)) exist to assist w enum. Still, it is also important to understand what pieces of info to look for and to be able to perform your enum manually. When you gain initial shell access to the host, it is important to check several key details.
### To recap
`OS Version`: Knowing the distro (Ubuntu, Debian, FreeBSD, Fedura, SUSE, Red Hat, CentOS, etc) will give you an idea of the types of tools that may be avail. This would also ID the OS version, for which there may be public exploits avail.

`Kernel Version`: As w the OS version, there may be public exploits that target a vuln in a specific kernel version. Kernel exploits can cause system instability or even a complete crash. Be careful running these against any production system, and make sure to fully understand the exploit and possible ramifications b4 running one.

`Running Services`: Knowing what services are running on the host is important, esp those running as root. A misconfig or vuln service running as root can be an easy win for priv-esc. Flaws have been discovered in many common services such as Nagios, Exim, Samba, ProFTPd, etc. Public exploit PoCs exist for many of them, such as CVE-2016-9566, a local priv-esc flaw in Nagios Core < 4.2.4.
### Gaining Situational Awareness
Imagine a scenario where you have just gained access to a Linux host by exploiting an unrestricted file upload vuln during an External Pentest. After est'ing a reverse shell (and ideally some sort of persistence), you should start by gathering some basics about the sys you are working with.

First, start by answering the fundamental question: What OS are you dealing with? If you landed on a CentOS host or a Red Hat Enterprise Linux host, your enum would likely be slightly diff than if you landed on a Debian-based host such as Ubuntu. If you landed on a host such as FreeBSD, Solaris, or something more obscure, such as the HP proprietary OS HP-UX or the IBM OS AIX, the cmds you'd work w will likely be diff as well. Though the cmds may be diff, and you may even needto look up a cmd reference in some instances, the principles are the same. For the purposes of ease and simplicity, this scenario will begin w an Ubuntu target to cover the general tactics and techniques. Once you learn the basics and combine them w a new way of thinking and the stages of the Pentesting Process, it shouldn't matter what type of Linux sys you land on b/c you'll have a thorough and repeatable proc.

There are many cheat sheets out there to help w enum Linux sys's and some bits of info you are interested in will have two or more ways to obtain it. This module will cover one methodology that can likely be used for the majority of Linux sys's that you will encounter in the wild. The being said, make sure to understand what the cmds are doing and how to tweak them or find the info you need a diff way if a particular cmd doesn't work. Challenge yourself during this module to try things various ways to practice your methodology and what works best for you. Anyone can re-type cmds from a cheat sheet, but a deep understanding of what you are looking for and how to obtain it will help you be successful in any env.

Typically, you'll want to run a few basic cmds to orient yourself:
- `whoami` - what user are you running as
- `id` - what groups does your user belong to?
- `hostname` - what is the server named. can you gather anything from the naming convention?
- `ifconfig` or `ip -a` - what subnet did you land in, does the host have additional NICs in other subnets?
- `sudo -l` - can your user run anything with sudo (as another user as root) w/o needing a password? This can sometimes be the easiest win and you can do something like `sudo su` and drop right into a root shell.
Including screenshots of the above info can be helpful in a client report to provide evidence of a successful Remote Code Execution (RCE) and to clearly ID the affected sys. The following goes into a more detailed, step-by-step, enum.

Start out by checking what OS and version you are dealing w:
```shell
$ cat /etc/os-release

NAME="Ubuntu"
VERSION="20.04.4 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.4 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```
This tells you, in this case, that the target is running [Ubuntu 20.04.4 LTS ("Focal Fossa")](https://releases.ubuntu.com/20.04/). For whatever version you encounter, it is important to see if you're dealing w something out-of-date or maintained. Ubuntu publishes its [release cycle here](https://ubuntu.com/about/release-cycle) and from this it's apparent that "Focal Fossa" does not reach end of life until Apr 2030. From this info, it can be noted that it is unlikely you will encounter a well-known Kernel vuln b/c the customer has been keeping their internet-facing asset patched but it is wise to still look regardless.

Next, check the current user's `PATH`, which is where the Linux sys looks everytime a cmd is exec'd for any executables to match the name of what you type, i.e. `id`, which on this sys is located at `/usr/bin/id`. As will be discussed later in the module, if the `PATH` var for a target user is misconfig'd you may be able to leverage it for priv-esc. For now, just note it down and add it to you notetaking tool of choice.
```shell
$ echo $PATH

/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```
Env vars that are set for the current user may also be checked. And you may get lucky and find something sensitive in there such as a passwd.
```shell
$ env

SHELL=/bin/bash
PWD=/home/htb-student
LOGNAME=htb-student
XDG_SESSION_TYPE=tty
MOTD_SHOWN=pam
HOME=/home/htb-student
LANG=en_US.UTF-8

<SNIP>
```
Moving on to the Kernel version. Perform some searches to see if the target is running a vuln Kernel (which you'll get to take advantage of later in this module), which has some known public exploit PoC. There are a few ways to do this, such as `$ cat /proc/version`, but for now, just use the `uname -a` cmd.
```shell
$ uname -a

Linux nixlpe02 5.4.0-122-generic #138-Ubuntu SMP Wed Jun 22 15:00:31 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```
Use the `lscpu` cmd to gather additional info about the host itself, such as the CPU type/version:
```shell
$ lscpu 

Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   43 bits physical, 48 bits virtual
CPU(s):                          2
On-line CPU(s) list:             0,1
Thread(s) per core:              1
Core(s) per socket:              2
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       AuthenticAMD
CPU family:                      23
Model:                           49
Model name:                      AMD EPYC 7302P 16-Core Processor
Stepping:                        0
CPU MHz:                         2994.375
BogoMIPS:                        5988.75
Hypervisor vendor:               VMware

<SNIP>
```
What login shells exist on the server? Note these down and highlight that both Tmux and Screen are avail to you.
```shell
$ cat /etc/shells

# /etc/shells: valid login shells
/bin/sh
/bin/bash
/usr/bin/bash
/bin/rbash
/usr/bin/rbash
/bin/dash
/usr/bin/dash
/usr/bin/tmux
/usr/bin/screen
```