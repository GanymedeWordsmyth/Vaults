[Hashcat](https://hashcat.net/hashcat/) can be downloaded using `wget` then decompressed using the `7z` file archiver via cli:
```installation
wget https://hashcat.net/files/hashcat-<version>.7z
7z x hashcat-<version>.7z
```
The folder contains 64-bit binaries for both Windows and Linux. The `-a` and `-m` arguments are used to specify the type of attack mode and hash type. `Hashcat` supports the following attack modes:

| **#** | **Mode**                |
| ----- | ----------------------- |
| 0     | Straight aka Dictionary |
| 1     | Combination             |
| 3     | Brute-force             |
| 6     | Hybrid Wordlist + Mask  |
| 7     | Hybrid Mask + Wordlist  |

The hash type value is based on the algorithm of the hash to be cracked. A complete list of hash types and their corresponding examples can be found [here](https://hashcat.net/wiki/doku.php?id=example_hashes). The table helps in quickly identifying the number for a given hash type. You can also view the list of example hashes via the command line using the following command: `./hashcat.bin --example-hashes | less`
## Benchmark
```shell-session
Poppy36@htb[/htb]$ hashcat -b -m 0
hashcat (v6.1.1) starting in benchmark mode...

Benchmarking uses hand-optimized kernel code by default.
You can use it in your cracking session by setting the -O option.
Note: Using optimized kernel code limits the maximum supported password length.
To disable the optimized kernel code in benchmark mode, use the -w option.

OpenCL API (OpenCL 1.2 pocl 1.5, None+Asserts, LLVM 9.0.1, RELOC, SLEEF, DISTRO, POCL_DEBUG) - Platform #1 [The pocl project]
=============================================================================================================================
* Device #1: pthread-Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz, 4377/4441 MB (2048 MB allocatable), 6MCU

Benchmark relevant options:
===========================
* --optimized-kernel-enable

Hashmode: 0 - MD5


Speed.#1.........:   449.4 MH/s (12.84ms) @ Accel:1024 Loops:1024 Thr:1 Vec:8

Started: Fri Aug 28 21:52:35 2020
Stopped: Fri Aug 28 21:53:25 2020
```

For example, the hash rate for MD5 on a given CPU is found to be 450.7 MH/s.

We can also run `hashcat -b` to run benchmarks for all hash modes.
## Optimizations

Hashcat has two main ways to optimize speed:

|Option|Description|
|---|---|
|Optimized Kernels|This is the `-O` flag, which according to the documentation, means `Enable optimized kernels (limits password length)`. The magical password length number is generally 32, with most wordlists won't even hit that number. This can take the estimated time from days to hours, so it is always recommended to run with `-O` first and then rerun after without the `-O` if your GPU is idle.|
|Workload|This is the `-w` flag, which, according to the documentation, means `Enable a specific workload profile`. The default number is `2`, but if you want to use your computer while Hashcat is running, set this to `1`. If you plan on the computer only running Hashcat, this can be set to `3`.|

It is important to note that the use of `--force` should be avoided. While this appears to make `Hashcat` work on certain hosts, it is actually disabling safety checks, muting warnings, and bypasses problems that the tool's developers have deemed to be blockers. These problems can lead to false positives, false negatives, malfunctions, etc. If the tool is not working properly without forcing it to run with `--force` appended to your command, we should troubleshoot the root cause (i.e., a driver issue). Using `--force` is discouraged by the tool's developers and should only be used by experienced users or developers.
## Status
Consider the more complex hash of [Bcrypt](https://en.wikipedia.org/wiki/Bcrypt), which is a type of pw hash based on the [Blowfish](https://en.wikipedia.org/wiki/Blowfish_(cipher)) cipher. It uses a salt to protect it from rainbow table attacks and can have many rounds of the algorithm applied, making the hash particularly resistant to brute-force attacks, even with a large pw cracking rig.

Let's take the bcrypt hash of the pw "`!academy`" which would be `$2a$05$ZdEkj8cup/JycBRn2CX.B.nIceCYR8GbPbCCg6RlD7uvuREexEbVy` with 5 rounds of the Blowfish algorithm applied. This hash run on the same hardware as what was run to crack a `SHA256` hash using `rockyou.txt` takes considerably longer to crack.

At any time during the cracking process, you can hit the "`s`" key to get a status on the cracking job, which shows that to attempt every pw in the `rockyou.txt` wordlist will take over 1.5 hours, as applying more round of the algorithm will inc cracking time exponentially. In the cases of hashes such as bcrypt, it is often better to use smaller, more targeted, wordlists.
## Straight or Dictionary Attack
```syntax
$ hashcat -a 0 -m <hash type> <hash file> <wordlist>
```
## [[Combination Attack]]
The syntax for a [[Combination Attack]] is:
```combo-demo
$hashcat -a 1 -m <hash-type> <hash-file> <wordlist1> <wordlist2>
```
This atk provides more flexibility and customization when using wordlists.
## [[Mask Attack]]
Consider the company Inlane Freight, which this time has pws with the scheme `ILFREIGHT<userid><year>`, where userid is 5 chars long. The mask `ILFREIGHT?l?l?l?l?l20[0-1]?d` can by used to crack pws with the specific pattern where `?l` is a letter and `20[0-1]?d` will include all years from 2000 to 2019.
The syntax for a [[Mask Attack]] is:
```mask-demo
$hashcat -a 3 -m <hash-type> <hash-file> <optional-custom-placeholder[-1to-4]> <mask>
```
## [[Hybrid Attack]]
Consider the pw `football1$`, whose MD5 hash would be `f7a4a94ff3a722bf500d60805e16b604`.
Hashcat reads words from the wordlist and appends a unique string based on the mask supplied. In this case, the mask `?d?s` tells hashcat to append a digit and a special char at the end of each word in the `rockyou.txt` wordlist
The syntax for a [[Hybrid Attack]] is:
```hybrid-demo-append
$hashcat -a 6 -m <hash-type> <hash-file> <wordlist> <optional-custom-placeholder> <mask>
```
Additionally, attack mode `7` can be used to prepend chars to words using a given mask. The following syntax could be used against a pw that would look like `2015football`, where the custom char mask `20?1?d` and the custom char set `-1 01` will prepend the wordlist:
```hybrid-demo-prepend
$hashcat -a 7 -m <hash-type> <hash-file> <wordlist> <optional-custom-placeholder> <mask>
```
## Conclusion
Dictionary Attacks can be very effective against weak pws, but the atks efficacy also depends on the type of hash targeted. Certain types of weaker pws can be much more difficult to crack just based on the hashing alg in use. This does not mean that a weak pw using a stronger hashing alg is any more "secure," however. pw cracking hardware varies, and "cracking rigs" with many GPUs could make short work of a pw hash that would take hours or days on a single CPU.
## Previously Cracked Passwords
By default, hashcat stores all cracked pws in the `hashcat.potfile` file; the format is `hash:password`. The main purpose of this file is to rm previously cracked hashes from the work log and display the pws with the `--show` command. However, it can be used to create new wordlists of previously cracked pws, and when combined with rule files, it can prove effective at cracking themed pws:
```shell-session
Poppy36@htb[/htb]$ cut -d: -f 2- ~/hashcat.potfile
```
### hashcat-utils
The hashcat-utils [repo](https://github.com/hashcat/hashcat-utils) contains many utils that can be useful for more advanced pw cracking. The tool [maskprocessor](https://github.com/hashcat/maskprocessor), for example, can be used to create wordlists using a given mask. Detailed usage for this tool can be found [here](https://hashcat.net/wiki/doku.php?id=maskprocessor).
## Common Hash Types
During pentest engagements, a wide variety of hash types will be encountered; ranging from extremely common to seen vary rarely, if ever. The creators of `Hashcat` maintain a list of [example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes) most hash modes that `Hashcat` supports. The list includes the hash mode, hash name, and a sample has of the specified type.
### Database Dumps
MD5, SHA1, and bcrypt hashes are often seen in db dumps. These hashes may be retrieved following a successful SQL injection atk or found in the publicly available pw data breach db dumps. MD5 and SHA1 are typically easier to crack than bcrypt, which may have many rounds of the Blowfish alg applied.
### Linux Shadow File
SHA512crypt hashes are commonly found in the `/etc/shadow` file on Linux systems. This file contains the pw hashes for all accounts with a login shell assigned to them. Access to a Linux system may be gained during a pentest via a web app atk or successful exploitation of a vuln service. After gaining access, it is possible to exploit a service that is already running as `root` and perform a successful priv esc atk and access the `/etc/shadow` file. Pw re-use is widespread and a cracked pw may allow the pentester accessful to other servers, network devices, or even be used as a foothold into a target's [[Active Directory]] environment.
### Common Active Directory Password Hash Types
Credential theft and pw re-use are widespread tactives during assessments against orgs using [[Active Directory]] (AD) to manage their environment. It's often possible to obtain creds in cleartext or re-use pw hashes to further access via Pass-the-Hash or SMB Relay atks. Some techniques will result in a pw hash that must be cracked offline to further our access e.g. NetNTLMv1 or NetNTLMv2 obtained through a [[Man-in-the-middle]] (MitM) atk, a Kerberos 5 TGS-REP hash obtained through a [[Kerberoasting]] atk, or an NTLM hash obtained either by dumping creds from memory using the `Mimikatz` tool or obtained from from a Win machine's local SAM db.
#### NTLM
One example is retrieving an NTLM pw hash for a user that has Remote Desktop (RDP) access to a server but is not a local admin, so the NTLM hash cannot be used for a pass-the-hash atk to gain access. In this case, the cleartext pw is necessary to further our access by connecting to the server via RDP and performing further enumeration within the network or looking for local priv esc vectors.
#### NetNTLMv2
During a pentest, it is common to run tools such as [Responder](https://github.com/lgandx/Responder) to perform MitM atks to attempt to "steal" creds. In busy corp networks, it is common to retrieve many NetNTLMv2 pw hashes using this method and then cracked and leveraged to est a foothold in the AD env or sometimes even gain full admin access to many or all systems depending on the privs granted to the user account associated with the pw hash.
## Cracking Wireless (WPA/WPA2) Handshakes
Clients often ask for wireless assessments as part of an Internal Penetration Test engagement. While not always the most exciting, it can get interesting if you capture a WPA/WPA2 handshake. Wireless networks are often not properly segmented from a company's corporate network, and successful authentication to the wireless network may grant full access to the internal corporate netword

`hashcat` can be used to successfully crack both the MIC (4-way handshake) and PMKID (1st packet/handshake).

### Cracking MIC
When a client connecting to the wireless network and the wireless access point (WAP) communicate, they must ensure that they both have/know the wireless network key but are not transmitting the key across the network. The key is enc'd and verified by the AP.

To perform this type of offline cracking atk, we need to capture a valid 4-way handshake by sending de-auth frames to force a client (user) to disconnect from an AP. When the client reauth (usually automatically), the atk'er can attempt to sniff out the WPA 4-way handshake without their knowledge, which is a collection of keys exchanged during the auth process between the client and the associated AP. Note: wireless atks are out of the scope for this module but will be covered in other modules.

These keys are used to gen a common key called the Message Integrity Check (MIC) used by an AP to verify that each packet has not been compromised and received in its original state.

The following diagram illustrated the 4-way handshake:
![[Pasted image 20240504170631.png]]
There are various tools, such as [[airodump-ng]], which you can use to successfully capture a 4-way handshake. Then, convert it to a format a format that can be supplied to `hashcat` for cracking using the `hccapx` format. `hashcat` hosts an online service to convert to this format (not recommended for actual client data but fine for lab/practice exercises): [cap2hashcat online](https://hashcat.net/cap2hashcat). Alternatively, you can perform an offline conversion using the `hashcat-utils` repo from GitHub.
```hashcat-utils-installation
$ git clone https://github.com/hashcat/hashcat-utils.git
$ cd hashcat-utils/src
$ make
```
> [!Note] Important Note:
> HtB states that you must use `-m 22000` to crack the MIC. For some reason this doesn't work. You have to use the deprecated `-m 2500` mode, but add `--deprecated-check-disable` at the end.
### Cracking PMKID
This atk can be performed against wireless networks that use WPA/WPA2-PSK (pre-shared key) and allows us to obtain the PSK being used by the targeted wireless network by atk'ing the AP directly. This atk does not req deauth of any users from the target AP. The PNK is the same as in the MIC (4-way handshake) atk but can be generally obtained faster and w/o interrupting any users.

The Pairwise Master Key Identifier (PMKID) is the AP's unique identifier to keep track of the Pairwise Master Key (PMK) used by the client. The PMKID is located in the 1st packet of the 4-way handshake and can be easier to obtain since it doesn't req capturing the entire 4-way handshake. PMKID is calculated with HMAC-SHA1 with the PMK (Wireless network pw) used as a key, the string "PMK Name," MAC addr of the AP, and the MAC addr of the station. Below is a visual rep of the PMKID calc:
![[Pasted image 20240504180428.png]]
