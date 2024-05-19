This is a `Python` tool which can be used to detect [various kinds of hashes](https://github.com/psypanda/hashID/blob/master/doc/HASHINFO.xlsx).
```Installation
$ sudo apt-get install python3 git
$ git clone https://github.com/psypanda/hashid.git
$ cd hashid
$ sudo install -g 0 -o 0 -m 0644 doc/man/hashid.7 /usr/share/man/man7/
$ sudo gzip /usr/share/man/man7/hashid.7
```
#### Usage:
```
$ ./hashid.py [-h] [-e] [-m] [-j] [-o FILE] [--version] INPUT
```

| Parameter               | Description                                         |
| ----------------------- | --------------------------------------------------- |
| INPUT                   | input to analyze (default: STDIN)                   |
| -e, --extended          | list all hash algorithms including salted passwords |
| -m, --mode              | show corresponding hashcat mode in output           |
| -j, --john              | show corresponding JohnTheRipper format in output   |
| -o FILE, --outfile FILE | write output to file (default: STDOUT)              |
| --help                  | show help message and exit                          |
| --version               | show program's version number and exit              |
Hashes can be supplied as a cli arg or a file:
```Identifying-Hashes
Poppy36@htb[/htb]$ hashid '$apr1$71850310$gh9m4xcAn3MGxogwX/ztb.'

Analyzing '$apr1$71850310$gh9m4xcAn3MGxogwX/ztb.'
[+] MD5(APR) 
[+] Apache MD5
```
```Identifying-Hashes
Poppy36@htb[/htb]$ hashid hashes.txt 

--File 'hashes.txt'--
Analyzing '2fc5a684737ce1bf7b3b239df432416e0dd07357:2014'
[+] SHA-1 
[+] Double SHA-1 
[+] RIPEMD-160 
[+] Haval-160 
[+] Tiger-160 
[+] HAS-160 
[+] LinkedIn 
[+] Skein-256(160) 
[+] Skein-512(160) 
[+] Redmine Project Management Web App 
[+] SMF ≥ v1.1 
Analyzing '$P$984478476IagS59wHZvyQMArzfx58u.'
[+] Wordpress ≥ v2.6.2 
[+] Joomla ≥ v2.5.18 
[+] PHPass' Portable Hash 
--End of file 'hashes.txt'--
```
If known, `hashid` can also provide the corresponding `Hashcat` hash mode with the `-m` flag if it is able to determine the hash type:
```Identifying-Hashes
Poppy36@htb[/htb]$ hashid '$DCC2$10240#tom#e4e938d12fe5974dc42a90120bd9c90f' -m
Analyzing '$DCC2$10240#tom#e4e938d12fe5974dc42a90120bd9c90f'
[+] Domain Cached Credentials 2 [Hashcat Mode: 2100]
```