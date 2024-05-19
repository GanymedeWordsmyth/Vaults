# Cracking Miscellaneous Files and Hashes
The majority of pw-prot docs can be run through `hashcat` to attempt to crack the hashes.
Various tools exist to help us extract the pw hashes from these files in a format `hashcat` can understand, one of which is `JohnTheRipper`, which comes with many of these tools written in C that are available when installing `JohnTheRipper` or compiling it from its source code. They can be viewed [here](https://github.com/magnumripper/JohnTheRipper/tree/bleeding-jumbo/src). To use these tools, we need to compile them.

## Installation
```installation
$ sudo git clone https://github.com/magnumripper/JohnTheRipper.git
$ cd JohnTheRipper/src
$ sudo ./configure && make
```
There are also Python ports of most of these tools available that are very easy to work with. The majority of them are contained in the `JohnTheRipper` jumbo GitHub repo [here](https://github.com/magnumripper/JohnTheRipper/tree/bleeding-jumbo/run).
One additional tool ported to Python by @Harmj0y is the [keepass2john.py](https://gist.github.com/HarmJ0y/116fa1b559372804877e604d7d367bbc#file-keepass2john-py) tool for extracting a crackable hash from KeePass 1.x/2.x databases that can be run through `Hashcat`. 
## Cracking PwProt MS Office Docs
[[Hashcat]] can by used to crack pw hashes extracted from some Microsoft Office docs using the the [office2john.py](https://raw.githubusercontent.com/magnumripper/JohnTheRipper/bleeding-jumbo/run/office2john.py) tool.

[[hashcat]] supports the following hash modes for MS Office docs:

| **Mode** | **Target**     |
| -------- | -------------- |
| 9400     | MS Office 2007 |
| 9500     | MS Office 2010 |
| 9600     | MS Office 2013 |
```syntax
$ python office2john.py <enc-office-doc(s)>
```
Then run the hash through [[hashcat]] using the appropriate mode and wordlist. This can be a v slow crack, esp if you only have a single CPU. But even if you had a cracking rig, it's still much slower than other hashes such as `MD5` and `NTLM`. Luckily, users often choose v weak pws to pw-prot their docs.
## Cracking PwProt Zip FIles
During an assessment, you may find an interesting zip file, but it is pwprot. Use the [zip2john](https://github.com/magnumripper/JohnTheRipper/blob/bleeding-jumbo/src/zip2john.c) tool to extract these hashes. [[hashcat]] supports a variety of compressed file formats:

| **Mode** | **Target**                                  |
| -------- | ------------------------------------------- |
| 11600    | 7-Zip                                       |
| 13600    | WinZip                                      |
| 17200    | PKZIP (Compressed)                          |
| 17210    | PKZIP (Uncompressed)                        |
| 17220    | PKZIP (Compressed Multi-File)               |
| 17225    | PKZIP (Mixed Multi-File)                    |
| 17230    | PKZIP (Compressed Multi-File Checksum-Only) |
| 23001    | SecureZIP AES-128                           |
| 23002    | SecureZIP AES-192                           |
| 23003    | SecureZIP AES-256                           |
```zip2john-syntax
$ zip2john [options] [zip-file(s)]
```
Then, just like the previous example, run the result through [[hashcat]] to decrypt
## Cracking PwProt KeePass Files
It's also common to find KeePass files during an assessment, e.g. on a sysadmin's workstation or on an accessible file share. KeePass files are akin to finding treasure chests full of creds because sysadmins, netadmins, help desk, etc. may store various pws in a shared KeePass db. Gaining access may provide local admin pws to Win machines, pws to infrastructure such as [[ESXi]] and [[vCenter]], access to network devices, and more.

We can extract these hashes using the compiled version of the [keepass2john](https://github.com/magnumripper/JohnTheRipper/blob/bleeding-jumbo/src/keepass2john.c) tool or using the Python port done by [HarmJ0y](https://gist.github.com/HarmJ0y), [keepass2john.py](https://gist.githubusercontent.com/HarmJ0y/116fa1b559372804877e604d7d367bbc/raw/c0c6f45ad89310e61ec0363a69913e966fe17633/keepass2john.py). `Hashcat` supports a variety of compressed file formats such as:

| **Mode** | **Target**                       |
| -------- | -------------------------------- |
| 13400    | KeePass 1 AES / without keyfile  |
| 13400    | KeePass 2 AES / without keyfile  |
| 13400    | KeePass 1 Twofish / with keyfile |
| 13400    | Keepass 2 AES / with keyfile     |
```keepass-syntax
$ python keepass2john.py [-k <keyfile>] <.kdbx database(s)>
```
## Cracking PwProt PDF Files
It's v common to come across pwprot PDFs on workstations, file shares, or even inside a user's email inbox should access be gained (*and persuing users' email for sensitive info is in-scope for your engagement*).

We can extract the hash of the passphrase using [pdf2john.py](https://raw.githubusercontent.com/truongkma/ctf-tools/master/John/run/pdf2john.py). The following command will extract the hash into a format that `Hashcat` can use.
```pdf2john-syntax
$ python pdf2john.py <.pdf-file(s)>
```
To make it easier to read, you can append `| awk -F":" '{ print $2}'` the the end of the `pdf2john` command as it will only print what comes after the `:`. 

`Hashcat` supports a variety of compressed file formats such as:

| **Mode** | **Target**                                 |
| -------- | ------------------------------------------ |
| 10400    | PDF 1.1 - 1.3 (Acrobat 2 - 4)              |
| 10410    | PDF 1.1 - 1.3 (Acrobat 2 - 4), collider #1 |
| 10420    | PDF 1.1 - 1.3 (Acrobat 2 - 4), collider #2 |
| 10500    | PDF 1.4 - 1.6 (Acrobat 5 - 8)              |
| 10600    | PDF 1.7 Level 3 (Acrobat 9)                |
| 10700    | PDF 1.7 Level 8 (Acrobat 10 - 11)          |
Then pass everything through [[hashcat]] with the proper mode.