# Introduction
## Organization
**Best practice to organize hosts and servers based on the OS’s**
Organizing our structure according to pentesting stages and the targets' OS's could look like the following:
Poppy36@htb[/htb]$ tree .
	.
	└── Penetration-Testing
	│
	├── Pre-Engagement
	│       └── ...
    ├── Linux
    │   ├── Information-Gathering
    │   │   └── ...
    │   ├── Vulnerability-Assessment
    │   │   └── ...
    │   ├── Exploitation
    │   │   └── ...
    │   ├── Post-Exploitation
    │   │   └── ...
    │   └── Lateral-Movement
    │       └── ...
    ├── Windows
    │   ├── Information-Gathering
    │   │   └── ...
    │   ├── Vulnerability-Assessment
    │   │   └── ...
    │   ├── Exploitation
    │   │   └── ...
    │   ├── Post-Exploitation
    │   │   └── ...
    │   └── Lateral-Movement
    │       └── ...
    ├── Reporting
    │   └── ...
	└── Results
	    └── ...

You could also organize it thusly:
Poppy36@htb[/htb]$ tree .
	.
	└── Penetration-Testing
		│
		├── Pre-Engagement
		│       └── ...
	    ├── Network-Pentesting
		│       ├── Linux
		│       │   ├── Information-Gathering
		│		│   │   └── ...
		│       │   ├── Vulnerability-Assessment
	    │       │   │	└── ...
	    │       │	└── ...
	    │       │    	└── ...
	    │		├── Windows
	    │ 		│   ├── Information-Gathering
	    │		│   │   └── ...
	    │		│   └── ...
	    │       └── ...
	    ├── WebApp-Pentesting
		│       └── ...
	    ├── Social-Engineering
		│       └── ...
	    ├── .......
		│       └── ...
	    ├── Reporting
	    │   └── ...
		└── Results
		    └── ...

However you feel most comfortable organizing doesn't matter. What matters is coming up with an organization method that streamlines the setup and preparation phase. Always have some kind of procedure, regardless of how many are on the team (even if it's just you). 

### Bookmarks
Streamlining add-ons and bookmarks is as simple as downloading and signing into Firefox. This automatically installs and syncs all add-ons and bookmarks to a new machine. Be aware, though, not to store any resources containing potentially sensitive information or private resources. A list of bookmarks should always be created with a single principle:
**`This list will be seen by third parties sooner or later.`**
Therefore, create a pentesting only account. The safest way to edit and extend your bookmark list is to store it locally and import it to the pentesting account. Once you do this, only then should you change to your private (non-pentesting) account.

### Password Managers
The weakest link in the system is whoever is sitting in the chair. The most common vulnerability or attack method within a network is "password reuse".
The are only three problems with passwords:
	1. Complexity
		It is challenging for standard users to create a complex password, as the human mind has a hard time remembering things it does not connect with. [NordPass](https://nordpass.com/most-common-passwords-list/) created a list of the most common passwords.
	2. Re-usage
		Remembering a complex and hard-to-guess password is still possible for a standard user. The second issue is that one password then gets used everywhere.
	3. Remembering
		That password gets used everywhere because the human mind has trouble remembering one complex, hard-to-guess password. It certainly can't remember and not mix up many complex, hard-to-guess passwords.
Enter: password managers
	These clever systems solve all the problems mentioned above, not only for standard users, but also for pentesters. Pentesters work with dozens, if not hundreds, of different services and servers for which they need a new, strong, and complex password every time. Another advantage is that users only have to remember one password to access all other passwords.

### Updates and Automation
It is important to continually update the components, OS's, and all the Github collections that are gathered and used over time. It is highly recommended to record all the resources and their sources in a file to more easily automate them later.

Automated scripts are OS-dependent. Creating automation scripts is a good exercise for learning and practicing scripting and can also help to prepare and reinstall a system more efficiently. As you delve deeper into this industry, you will find more tools, practical explanations, and cheat sheets when learning new methods and technologies. It is recommended to keep those in a record and keep the entries up to date.

### Note-Taking
Just like how the mind is unable to remember many complex passwords, it also has a difficult time remembering all of the quickly accumulated information, results, and ideas. To help streamline note-taking quickly, there are five different main types of information that need to be noted down:
	1. Newly discovered information
		- General info: new IP addresses, usernames, passwords, source code, etc. that are related to the pentesting engagement and process
	2. Ideas for further tests and processing
		- You will gain a lot of different information over the course of a pentest that will require adapting your approach.
		- These results will give ideas for subsequent steps you can take, and other vulnerabilities or misconfigurations may be forgotten or overlooked.
		- Because of this, you should get in the habit of noting down everything you see that should be investigated as part of the assessment.
		- Get used to a note taking software that helps make note-taking more streamlined: [Notion.so](https://notion.so/), [Xmind](https://www.xmind.net/), [Obsidian](https://obsidian.md/), etc
	3. Scan results
		- Scan results and penetration testing steps are of paramount significance and knowing how to filter out the most critical pieces of information comes with experience.
		- Especially important when starting is to note down all information and results so you don't miss something meaningful and because a piece of info may prove helpful later.
		- Additionally, these results are often used for documentation, so writing down the results is important even if it isn't necessarily useful.
		- CherryTree, [GhostWriter](https://github.com/GhostManager/Ghostwriter), and [Pwndoc](https://github.com/pwndoc/pwndoc) are great tools that streamline documentation generation and have a clear overview of the steps we have taken
	4. Logging
		- Logging is essential for both documentation and our protection. If third parties attack the company during our pentest and damage occurs, you can prove the damage did not result from your activities.
		- `Date` can be used to display the exact date and time of each command in your command line. to display the timestamp, replace the PS1 variable in the `.bashrc` file with the following content.
			- `PS1="\[\033[1;32m\]\342\224\200\$([[ \$(/opt/vpnbash.sh) == *\"10.\"* ]) && echo \"[\[\033[1;34m\]\$(/opt/vpnserver.sh)\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\$(/opt/vpnbash.sh)\[\033[1;32m\]]\342\224\200\")[\[\033[1;37m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\w\[\033[1;32m\]]\n\[\033[1;32m\]\342\224\224\342\224\200\342\224\200\342\225\274 [\[\e[01;33m\]$(date +%D-%r)\[\e[01;32m\]]\\$ \[\e[0m\]"`
		- `Script` will log every command and subsequent result in a background file.
			- to start logging with `script` (for Linux) and [Start-Transcript](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.host/start-transcript?view=powershell-7.1) (for Windows), use the following command and rename it according to your needs: 
				- Script:
					`script 032421-1400-exploitation.log`
					`...SNIP...`
					`exit`
				- Start-Transcript
					`C:\> Start-Transcript -Path "C:\Pentesting\032421-1400-exploitation.log`
					`C:\> ...SNIP...`
					`C:\> Stop-Transcript`
			- It is recommended to define a certain format in advance after saving the individual logs. The above command uses the format: `<date>-<start time>-<name>.log` where `<date>` uses `MMDDYY` and `<start time>` uses 24hr format.
			- This will automatically sort our logs in the correct order. This streamlines your work as you will no longer have to examine the logs manually and if you are on a team, this makes it more straightforward for team members to understand what steps have been taken and when.
			- Another benefit is that you can later analyze our approach to optimize your process. If you repeat one or two steps continuously and always use them in combination with each other, it may be worthwhile to write a simple script to automate those steps to save time moving forward.
			- Additionally, most tools offer the ability to save the results in separate files, which is highly recommended as the results can also change. If specific results seem to have changed, we can compare the current results with the previous ones. [Tmux](https://github.com/tmux/tmux/wiki) and [Terminator](https://terminator-gtk3.readthedocs.io/en/latest/) are two tools which allow you to log all commands and output them automatically. If you come across a tool that does not allow you to log the output, you can with with redirections and the program tee:
				Linux Output Redirection:
					`name$ ./custom-tool.py 10.129.28.119 > logs.custom-tool`
					or
					`name$ ./custom-tool.py 10.129.28.119 | tee -a logs.custom-tool`
				Windows Output Redirection:
					`C:\> .\custom-tool.ps1 10.129.28.119 > logs.custom-tool`
					or
					`C:\> .\custom-tool.ps1 10.129.28.119 | Out-File -Append logs.custom-tool`
	5. Screenshots
		- Screenshots record and represent proof of obtained results, necessary for the Proof-Of-Concept and your documentation.
		- [Flameshot](https://github.com/flameshot-org/flameshot) is one of the best tools for this. It has all the essential functions needed to quickly edit your screenshots with using an additional editing program. Install it using APT package manager or via Github download
		- [Peek](https://github.com/phw/peek) is a great alternative for when you can't capture all the necessary steps and information in one or more screenshots by creating GIFs that record all the required actions for you.

## Virtualization
Virtualization is an abstraction of physical computing resources. Both hardware and software components can be abstracted and used precisely as its physical counterpart. An abstracted computer component is referred to as a virtual or logical components. The main advantage is the abstraction layer between the physical resource and the virtual image (idk what this means). This is the basis of various cloud services, which are becoming increasingly important in everyday business. Virtualization is decidedly different from the concepts of simulation and emulation.

Virtualization involves the abstraction of physical computing resources i.e. hardware, software, storage, and network components. The aim is to make these resources available on a virtual level and distribute them to different customers in a manner that is as flexible as it is demand-driven. This ensures improved utilization of computer resources. The goal is to run applications on a system that is not supported by it (why? Oh! I think this means that using a VM allows you to run apps that are not supported by the host system). In virtualization, distinguish between the following:
	Hardware virtualization
	Application virtualization
	Storage virtualization
	Data virtualization
	Network virtualization
Hardware virtualization is about technologies that enable hardware components to be made available independently of their physical basis using [hypervisor](https://en.wikipedia.org/wiki/Hypervisor) software. The best-known example of this (and one I've used before) is the `vitual machine (VM)`. A VM is a virtual computer that behave like a physical computer, including hardware and OS. VMs run as virtual guest systems on one or more physical systems referred to as `hosts`.

### Virtual Machines
A `virtual machine (VM)` is a virtual OS that runs on a host system (an actual physical computer system). Several VMs isolated from each other can be operated in parallel. A `hypervisor` allocates the physical hardware resources of the host system, which creates a sealed-off, virtualized environment with which several guest systems can be operated, independent of the OS, in parallel, on one physical computer. A hypervisor manages the hardware resources, and from the VM's PoV, allocated computing power, RAM, hard disk capacity, and network connections are exclusively available.

From the application's perspective, an OS installed within the VM behaves as if installed directly on the hardware. It is not apparent to the applications or the OS's that they are running in a virtual environment. Virtualization is usually associated with performance losses for the VM because the intermediate virtualization layer itself requires resources. VMs offer numerous advantages over running an OS or application directly on a physical system. The most important benefits of which are:
	1. Applications and services of a VM do not interfere with each other
	2. Compete independence of the guest system from the host system's OS and the underlying physical hardware
	3. VMs can be cloned or moved to other systems by simply copying and pasting
	4. Hardware resources can be dynamically allocated via the hypervisor
	5. Better and more efficient utilization of existing hardware resources
	6. Shorter provisioning times for systems and applications
	7. Simplified management of virtual systems

VMware is probably better, but costly. I'll be sticking with 
#### [VirtualBox](https://www.virtualbox.org/)
Hard disks are emulated in container files, called Virtual Disk Images (`VDI`). VB can also handle hard disk files from VMware virtualization products (`.vdmk`), the `Virtual Hard Disk` format (`.vhd`) and others. It's also possible to convert these external formats from the command line or download the installation file from the [official website](https://www.virtualbox.org/wiki/Downloads) and install it manually.

## Containers
A `container` cannot be defined as a VM but as an isolated group of `processes` running on a single host that corresponds to a complete application, including its config and dependencies. Packaged in a precisely defined and reusable format. Does not contain its OS or kernel like VMs do, therefore it's not a virtualized OS. This makes them much slimmer. Also referred to as application virtualization in this context.

[Resource](https://wiki.aquasec.com/download/attachments/2854029/docker-birthday-3-intro-to-docker-slides-18-638.jpg?version=1&modificationDate=1515522843003&api=v2)

A significant issue when rolling out new apps or releases is that each app depends on some aspects of its environment, including local settings or function libraries, among other things. The settings in the dev environment often differ from those in the test environment and production, which can quickly lead to an application working differently or not at all in production.


| Virtual Machine                                                    | Container                                                        |
| ------------------------------------------------------------------ | ---------------------------------------------------------------- |
| Contain apps and OS                                                | Certain apps and only necessary OS components                    |
| A hypervisor provides virtualization                               | The OS with the container engine provides its own virtualization |
| Multiple VMs run in isolation from each other on a physical server | Several containers run isolated from each other on one OS        |

Technically, this technology has been available under the Linux OS for some time and the kernel uses these functions to `isolate` applications. Thus, apps run isolated from each other as a process in different user accounts, even though they belong to a familiar Linux environment simultaneously. The cooperation of various apps is also possible, and if the containers run on the same system, a container daemon is used (i.e. the `Linux Container Daemon` or `LXD` for short). LXD is a similar tech to `Linux Containers` (`LXC`), except LXC is a container-based virtualization tech at the OS level, and technically combines isolated namespaces and the Linux kernel "cgroups" to implement isolated environments for code execution.

An image of the file system forms the basis of each container. You can either use a premade image or make one yourself. Containers are incredibly scalable. This is necessary in today's highly dynamic IT infrastructure in companies and makes it possible to ideally adapt the capacities for the users' provision of applications. Meanwhile, even larger container setups can be managed without any problems because of orchestration systems such as `Apache Mesos` and `Google Kubernetes`, which distribute the containers over the existing hardware based on predefined rules and monitor them.

### Intro to Docker
[Docker](https://www.docker.com/get-started) is an open-source software (FOSS for personal use) that can isolate applications in containers, similar to OS virtualization, greatly simplifying the deployment of applications i.e. app data can be transported and installed easily with this method. The use of containers ensures computer resources are strictly separated from each other. These form the basis for virtualized containers that can run on almost any OS. Doing so makes applications portable and uncomplicated, whether during development or when scaling [SaaS](https://en.wikipedia.org/wiki/Software_as_a_service) clusters.

The main component of container virtualization is [Docker Engine](https://docs.docker.com/engine/), providing the interface between host resources and running containers. Any system that has Docker Engine installed can use Docker containers. Docker was originally designed for Linus systems, but, with virtualization, the engine also works on Windows and Mac OS devices. 

Docker Installation
```
[!bash!]$ sudo apt update -y
[!bash!]$ sudo apt install docker.io -y

C:\> IEX((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
C:\> choco upgrade chocolatey
C:\> choco install docker-desktop
```
### Intro to Vagrant
[Vagrant](https://www.vagrantup.com/) is a tool that can create, configure, and manage VMs or VM environments by describing them in code in a `Vagrantfile` instead of creating and configuring them manually. To better structure the program code, the Vagrant file can include additional code files. The code can then be processed using the Vagrant CLI and through this you can create, provision, and start your own VMs. Additionally, if the VMs are no longer needed, they can be destroyed just as quickly and easily. Vagrant natively offers providers for VMware and Docker.

[Resource](https://stefanscherer.github.io/content/images/2016/03/windows_swarm_demo.png)

Vagrant Installation
```
[!bash!]$ sudo apt update -y
[!bash!]$ sudo apt install virtualbox virtualbox-dkms vagrant

C:\> IEX((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
C:\> choco upgrade chocolatey
C:\> cinst virtualbox cyg-get vagrant
```
It is highly recommended to play around with different containers and experiment to get a feel for them. You should look at the documentation and read through it to understand how the containers work and what they depend on. Doing so will also help you understand what advantages and disadvantages they bring.
# Operating Systems
## Linux
Because Linux is the most popular OS for pentesting, it is imperative that anyone wanting to code and pentest not only learn it intimately, but also develop a certain standard for it that always leads to the same setup you are used to. Additionally, learning how not only how Linux works, but how virtualization works will allow you to preconfigure an image exactly how you want it so you don't have to waste time during the beginning of a job.

### Penetration Testing Distributions
There are numerous pentesting distros available to use, all of which have their own advantages and disadvantages. The question to be asked should not be, "which distro is best," rather, "which distro is best for me?" There does exist, however, a quantifiable list that one should follow to find the best of the choices available: 
1. A large and active community
2. Comprehensive and detailed documentation
Among the most popular choices include, but are not limited to:
1. [ParrotOS](https://www.parrotsec.org/) (`Pwnbox`)
2. [Kali Linux](https://kali.org/)
3. [BlackArch](https://blackarch.org/)
4. [BackBox](https://linux.backbox.org/)
HtB prefers to use ParrotOS, though I have used Kali in the past. I plan to use ParrotOS during the training but may switch to another.

### [Logical Volume Manager](https://en.wikipedia.org/wiki/Logical_volume_management)
`LVM` is a partitioning scheme mainly used in Unis and Linux environments, which provides a level of abstraction between disks, partitions, and file system. Using LVM, it is possible to form dynamically changeable partitions, which can also extend over several disks.

### LUKS Encryption
`LVM` is an additional abstraction layer between physical data storage and the computer's OS with its logical data storage area and the file system. LVM supports the organization of logical volumes in a RAID array to protect computers from individual hard disk failure. Unlike RAID, however, the LVM concept does not provide redundancy. It has been present in almost all Unix and Linus distros but also for other OS's. Windows or macOS also have the concept of LVM but use different names for it like [Storage Spaces](https://docs.microsoft.com/en-us/windows-server/storage/storage-spaces/overview) (Windows) or [CoreStorage](https://en.wikipedia.org/wiki/Core_Storage) (macOS).

### Updates & APT Package Manager
Step 1: Install ParrotOS VM, complete
Step 2: Bring it up to date:
The `Advanced Packaging Tool` is a package management system that originated in the Debian OS that uses dpkg for actual package management. The package manager is used for package management, which means we can search, update, and install program packages. APT uses repositories (thus package sources), which are held in the `/etc/apt/sources.list` directory (in ParrotOS it's in: `/etc/apt.sources.list.d/parrot.list`)

#### ParrotOS Sources List
```shell-session
┌─[cry0l1t3@parrot]─[~]
└──╼ $ cat /etc/apt/sources.list.d/parrot.list

# parrot repository
# this file was automatically generated by parrot-mirror-selector
deb https://deb.parrot.sh/parrot/ rolling main contrib non-free
#deb-src https://deb.parrot.sh/parrot/ rolling main contrib non-free
deb https://deb.parrot.sh/parrot/ rolling-security main contrib non-free
#deb-src https://deb.parrot.sh/parrot/ rolling-security main contrib non-free
```
Here the package manager can access a list of HTTP and FTP servers and obtain and install the corresponding packages from there. If the packages are searched for, they are automatically loaded from the list of available repositories. Since program versions can be compared quickly under APT and can be loaded automatically from the repo list, updating existing program packages under APT is relatively easy and comfortable.
#### Updating ParrotOS
```shell-session
┌─[cry0l1t3@parrotos]─[~]
└──╼ $ sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
[sudo] password for cry0l1t3:                                                 

Hit:1 https://deb.parrot.sh/parrot rolling InRelease
Hit:2 https://deb.parrot.sh/parrot rolling-security InRelease
Reading package lists... Done
Building dependency tree
Reading state information... Done
2310 packages can be upgraded. Run 'apt list --upgradable' to see them.       
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
The following packages were automatically installed and are no longer required:
  cryptsetup-nuke-password dwarfdump
  ...SNIP...
```

#### Tools List
```shell-session
┌─[cry0l1t3@parrotos]─[~]
└──╼ $ cat tools.list

netcat
ncat
nmap
wireshark
tcpdump
hashcat
ffuf
gobuster
hydra
zaproxy
proxychains
sqlmap
radare2
metasploit-framework
python2.7
python3
spiderfoot
theharvester
remmina
xfreerdp
rdesktop
crackmapexec
exiftool
curl
seclists
testssl.sh
git
vim
tmux
```
#### Installing Additional Tools
If there are only a few packages that we want to install, we can enter them manually in the following command.
```shell-session
┌─[cry0l1t3@parrotos]─[~]
└──╼ $ sudo apt install netcat ncat nmap wireshark tcpdump ...SNIP... git vim tmux -y
[sudo] password for cry0l1t3:       

Reading package lists... Done
Building dependency tree
Reading state information... Done
The following packages were automatically installed and are no longer required: 
  libarmadillo9 libboost-locale1.71.0 libcfitsio8 libdap25 libgdal27 libgfapi0
  ...SNIP...
```
#### Installing Additional Tools from a List
However, if the list contains more than five packages, we should always create a list and keep it updated. With the following command, we will install all the tools from the list at once using APT.
```shell-session
┌─[cry0l1t3@parrotos]─[~]
└──╼ $ sudo apt install $(cat tools.list | tr "\n" " ") -y
[sudo] password for cry0l1t3:       

Reading package lists... Done
Building dependency tree
Reading state information... Done
The following packages were automatically installed and are no longer required: 
  libarmadillo9 libboost-locale1.71.0 libcfitsio8 libdap25 libgdal27 libgfapi0
  ...SNIP...
```
### Using Github
We will also come across tools that are not found in the repos and therefore have to download them manually from Github. For example, if you are missing specific tools for Privilege Escalation and want to download the [Privilege-Escalation-Awesome-Scripts-Suite](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite), you would issue the following command:
#### Clone Github Repository
```shell-session
┌─[cry0l1t3@parrotos]─[~]
└──╼ $ git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git

Cloning into 'privilege-escalation-awesome-scripts-suite'...
remote: Enumerating objects: 29, done.
remote: Counting objects: 100% (29/29), done.
remote: Compressing objects: 100% (17/17), done.
remote: Total 5242 (delta 18), reused 22 (delta 11), pack-reused 5213
Receiving objects: 100% (5242/5242), 18.65 MiB | 5.11 MiB/s, done.
Resolving deltas: 100% (3129/3129), done.
```
#### List Contents
```shell-session
┌─[cry0l1t3@parrotos]─[~]
└──╼ $ ls -l privilege-escalation-awesome-scripts-suite/

total 16
-rwxrwxr-x 1 cry0l1t3 cry0l1t3 1069 Mar 23 16:41 LICENSE
drwxrwxr-x 3 cry0l1t3 cry0l1t3 4096 Mar 23 16:41 linPEAS
-rwxrwxr-x 1 cry0l1t3 cry0l1t3 2506 Mar 23 16:41 README.md
drwxrwxr-x 4 cry0l1t3 cry0l1t3 4096 Mar 23 16:41 winPEAS
```

### Snapshot
After installing all known and relevant packages and repos, it is highly recommended to take a `VM snapshot`. In the following steps, you will be making changes to specific configuration files, which, if you are not careful, can brick the system. Doing so would force us to waste precious time going back through the entire setup again. You should name the snapshot something descriptive like, "`Initial Setup`."

*Before* we create this snapshot, shutdown the OS. This will significantly decrease the time required to do so. Otherwise, the snapshot will be taken from a running system that you will return to.

If you break the system in some way while performing subsequent configuration steps, you can revert back to a good, known, working copy. A (powered off) snapshot should be taken after every major configuration stage. It is also a good idea to periodically take a VM snapshot during a penetration test in case something goes wrong. 

### Terminal Adjustment
Now that you've created a snapshot and can work with our configs, start by taking a look at your terminal environment. Many different terminal emulators emulate the actual command line input you will use to enter and execute the system's commands. Like pentesting distros and virtualization software, the one that is best for you depends on many personal desires and expectations. Some of the more popular terminal emulators include:
1. [Terminator](https://terminator-gtk3.readthedocs.io/en/latest/)
2. [Guake](http://guake-project.org/)
3. [iTerm2](https://iterm2.com/)
4. [Terminology](https://www.enlightenment.org/docs/apps/terminology.md)
An efficient alternative, which can also be used as an extension, is [Tmux](https://github.com/tmux/tmux/wiki). `Tmux` is a terminal multiplexer that allows creating a whole shell session with multiple windows and subwindows from a single shell window. Started processes abort when the terminal session or SSH connection disappears. Tmux's console keeps the process alive by working with session. As an example, if you are connected to a constantly running server in this way, you can close the terminal or shut down the computer on the local client without terminating the Tmux session. If you log back into the remote server via SSH, you can view the existing sessions and rejoin the desired session.

[IppSec](https://www.youtube.com/channel/UCa6eh7gCkpPo5XXUDfygQQA) has also created a short video where he introduced Tmux. There he explains some advantages of Tmux and shows with examples how he words with it.
![](https://youtu.be/Lqehvpe_djs?si=6zRyucnPJYLyQkmp)

#### Customize Bash Prompt
Use the [Bash Prompt Generator](https://bash-prompt-generator.org/) to easily design your bash prompt the way you want it.
Enter the following two commands into the terminal
```
user@hostname:~$ cp .bashrc .bashrc.bak
user@hostname:~$ echo 'export PS1="\[\e[91m\]┌──[\[\e[0;39m\]\D{%Y%b%e%a}\[\e[93m\]-\[\e[96m\]\t\[\e[91m\]]─[\[\e[0;39m\]\u\[\e[93m\]@\[\e[96m\]\h\[\e[91m\]]\n└──╼[\[\e[33m\]\w\[\e[91m\]]\[\e[93m\]\$\[\e[0m\]"' >> .bashrc
```
Additionally, there is a [community](https://www.reddit.com/r/unixporn/) on Reddit which designs the GUIs in many different ways

### Automation
The automation process is also an essential part of your preparation for pentesting. This should be fast and efficient. Ideally, you'd setup Bash scripts that automatically adjust our settings to the new system. An example script of the above terminal adjustment would look like the following:
#### Bash Prompt Customization Script - Prompt.sh
```
#!/bin/bash

#### Make a backup of the .bashrc file
cp ~/.bashrc ~/.bashrc.bak

#### Customize bash prompt
echo 'export PS1="\[\e[91m\]┌──[\[\e[0;39m\]\D{%Y%b%e%a}\[\e[93m\]-\[\e[96m\]\t\[\e[91m\]]─[\[\e[0;39m\]\u\[\e[93m\]@\[\e[96m\]\h\[\e[91m\]]\n└──╼[\[\e[33m\]\w\[\e[91m\]]\[\e[93m\]\$\[\e[0m\]"' >> .bashrc
```
#### Request Prompt.sh
If we then host this script on our VPS, you can retrieve it from our customer's Linux workstation and apply it.
```
user@workstation:~$ curl -s http://myvps.vps-provider.net/Prompt.sh | bash
```
#### Customization Scripts
A simple designation of these scripts is also of great use. Name the scripts something that makes sense for what the script does. If you have created several scripts like this, you can write a simple Bash script from memory on the working station to do all the configuration for you. As an example, assume you've created the following list of scripts and are hosting them on you `Vitual Private Server` (`VPS`)
```
user@hostname:~$ cat customization-scripts.txt

Prompt.sh
Tools.sh
GUI.sh
Tmux.sh
Vim.sh
```
You can now write a Bash script that takes care of all these settings for you or even combines them into a single command:
```shell-session
user@hostname:~$ for script in $(cat customization-scripts.txt); do curl -s http://myvps.vps-provider.net/$script | bash; done
```
With this command, each customization script is retrieved and executed one by one from your VPS. This allows you to make any changes to the workstation or your new VM quickly and from memory.


### Final Snapshot
Getting back to the VM, once you have adjusted all your configs and settings, you should create a `Final snapshot` again to save your settings. Add all the changes and tasks to the description of the new snapshot.

If you want to test your installation scripts to see if they work as intended, you can copy them to the host system, revert the VM to the `Initial Setup` snapshot and run those scripts there. When you are satisfied with your scripts, you can switch back to the `Final snapshot` and continue with VM encryption.
### VM Encryption
In addition to LVM encryption, you can encrypt the entire VM with another strong password. This gives you an extra layer of protection that will protect your results and any customer data residing on the system. This means that no one will be able to start the VM without the password you set.
## Windows
> Personally don't care that much about Windows at the moment, but in the future, I can find the setup page [here](https://academy.hackthebox.com/module/87/section/885).


Windows computers serve an essential role as testbeds and victims for aspiring pentesters. However, it makes for a great pentesting platform as well. There some advantages to using Windows as your daily driver. It blends in most enterprise environments with other hosts on an Active Directory domain if you use Windows versus Linux and some Python tooling. Traversing SMB and utilizing shares is much easier this way. With this in mind, it can be beneficial to familiarize yourself with Windows and set a standard that ensures you have a stable and effective platform to perform your actions.

Building your pentesting Windows platform can help you in multiple ways:
1. Since you built it and installed only the necessary tools, you should have a better understanding of what is happening under the hood. This also allows you to ensure you do not have any unnecessary services running that could potentially be a risk to yourself and the customer when on an engagement.
2. It provides you the flexibility of having multiple OS types at your disposal if needed. These same systems used for your engagements can also serve as a testbed for payloads and exploits before launching them at the customer.
3. By building and testing the systems yourself, you know they will function as intended during the pentest and save yourself time troubleshooting during the engagement.
`Windows Subsystem for Linux (WSL)` allows for the Linux OS's to run alongside your Windows install, which helps by giving you a space to run tools developed for Linux right inside your Windows host without the need for a hypervisor program or installation of a third-party application such as Virtualbox or Docker.

This section will examine and install the core components needed to get your systems in order, such as `WSL, Visual Studio Core, Python, Git, and the Chocolatey Package Manager`. **It's important to keep in mind that most exploitation tools and code are `USED for EXPLOITATION` and can be harmful to your host if you're not careful.**
### Installation Requirements
The installation of the Windows VM is done the same way as the Linux VM and can either be installed on a bare-metal host or in a hypervisor. With either option, we have some requirements to think about when installing Windows 10.
# VPS Providers
A `Virtual Private Server` (`VPS`) is an isolated environment created on a physical server using virtualization technology. A VPS is fundamentally part of `Infrastructure-as-as-Service` `(IaaS)` solutions. 