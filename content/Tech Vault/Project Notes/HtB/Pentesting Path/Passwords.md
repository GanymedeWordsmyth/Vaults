# Hashing vs Encryption
## Hashing
Hashing is the process of converting some text to a string, which is unique to that particular text. This always returns hashes with the same length regardless of the type, length, or size of the data.
Many reasons to use different hash algorithms:
	[MD5](https://en.wikipedia.org/wiki/MG5) and [SHA256](https://en.wikipedia.org/wiki/SHA-2) are used to verify the integrity of a file
	[PBKDF2](https://en.wikipedia.org/wiki/PBKDF2) is used to hash passwords before storage
	Some hash functions can be [[Keyed]], such as [HMAC](https://en.wikipedia.org/wiki/HMAC), which acts as a [checksum](https://en.wikipedia.org/wiki/Checksum) to verify if a particular message was tampered with during transmission.
One-way process. Therefore, the only attack available it to use a list containing possible passwords where each password from the list is hashed and compared to the original hash.
	4 main algorithms that are used to prot pw on Unix:
		SHA-512
			converts a long string of char into a has value
			Fast and efficient, but susceptible to [rainbow table attacks](https://en.wikipedia.org/wiki/Rainbow_table), where an attacker uses a pre-computed table to reconstruct orig pw.
		Blowfish
			A symmetric block cipher algorithm that enc a pw with a key.
			Slower than SHA-512, but more secure
		BCrypt
			Uses a slow hash func to make it harder for attackers to guess pws or perform [rainbow table attacks](https://en.wikipedia.org/wiki/Rainbow_table)
		Argon2
			Modern and secure algorithm explicitly designed for pw hashing systems.
			Uses multiple rounds of hash func and a large amt of mem to make harder for attackers to guess pw
			Considered one of the most secure algorithms because it has a high time and resources req
### Salting Passwords
Effective against brute-forcing hashes, a salt is a random piece of data added to the plaintext before hashing it. This inc the computation time but does not prevent brute-forcing altogether.

### Example
Consider the plaintext pw value, "p@ssw0rd". The MD5 has for this can be calculated as follows:
```shell-session
Poppy36@htb[/htb]$ echo -n "p@ssw0rd" | md5sum

0f359740bd1cda994f8b55330c86d845
```
Now, suppose a random salt such as "123456" is introduced and appended to the plaintext:
```shell-session
Poppy36@htb[/htb]$ echo -n "p@ssw0rd123456" | md5sum

f64c413ca36f5cfe643ddbec4f7d92d0
```
A completely new hash was gen'd using this method, which will not be present in any pre-computed list. An attacker will have to sac extra time to append this salt before calc the hash.
>[!Note] Important Note:
>Some hash func such as MD5 have also been vuln to [[Collisions]], where two sets of plaintext can produce the same hash.

## Encryption
The process of converting data into a format in which the original content is not accessible.
Reversible - it's possible to decrypt the ciphertext (enc data) and obtain the orig content.
Classic encryption examples are:
	[Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
	[Bacon's Cipher](https://en.wikipedia.org/wiki/Bacon%27s_cipher)
	[Substitution Cipher](https://en.wikipedia.org/wiki/Substitution_cipher)
### Symmetric Encryption
Symmetric algorithms use a key or secret to enc the data and use the same key to decrypt it. A basic example of symmetric enc is XOR:
```shell-session
Poppy36@htb[/htb]$ python3

Python 3.8.3 (default, May 14 2020, 11:03:12) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from pwn import xor
>>> xor("p@ssw0rd", "secret")
b'\x03%\x10\x01\x12D\x01\x01'
```
In the shell-session above, the plaintext is "p@ssw0rd" and the key is "secret". Anyone who has the key can decrypt the ciphertext and obtain the plaintext.
```shell-session
Poppy36@htb[/htb]$ python3

Python 3.8.3 (default, May 14 2020, 11:03:12) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from pwn import xor
>>> xor('\x03%\x10\x01\x12D\x01\x01', "secret")
b'p@ssw0rd'
```
The `b` in the above outputs denotes a byte string. This distinction was not made pre `Python3`
Other examples of symmetric algorithms are as follows:
	[AES](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
	[DES](https://en.wikipedia.org/wiki/Data_Encryption_Standard)
	[3DES](https://en.wikipedia.org/wiki/Triple_DES)
	[Blowfish](https://en.wikipedia.org/wiki/Blowfish_(cipher)#The_algorithm)
These can be vuln to attacks such as:
	Key brute-forcing
	[Frequency Analysis](https://en.wikipedia.org/wiki/Frequency_analysis)
	[Padding Oracle Attack](https://en.wikipedia.org/wiki/Padding_oracle_attack)
### Asymmetric Encryption
Divides the key into two parts (i.e. public and private). The public key can be given to anyone who wishes to decrypt some info and pass it securely to the owner. The owner then uses their private key to decrypt the content. Examples include:
	[RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem))
	[ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm)
	[Diffie-Hellman](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)
The most prominent uses of asymmetric enc is the `Hypertext Transfer Protocol Secure` (`HTTPS`) the the form of `Secure Sockets Layer` (`SSL`). Client connects to a server hosting an HTTPS website, a public key exchange occurs, client's browser uses this public key to enc any kind of data sent to the server, then server decrypts incoming traffic before passing it on to the processing service.
# Identifying Hashes
Most hashing algorithms produce hashes of a constant length, therefore, the length of a hash can be used to identify (aka map it to) the algorithm used for the hash (e.g. a 32 char length hash points to either the MD5 or NTLM hash algorithms).
Other times, hashes are stored in certain formats (e.g. `hash:salt` or `$id$salt$hash`)
The hash `2fc5a684737ce1bf7b3b239df432416e0dd07357:2014` is a SHA1 hash with the salt of `2014`.
The hash`$6$vb1tLY1qiY$M.1ZCqKtJBxBtZm1gRi8Bbkn39KU0YJW1cuMFzTRANcNKFKR4RmAQVk4rqQQCkaJT6wXqjUkFcA/qNxLyqW.U/` contains three fields delimited by `$`, where the first field is the `id`, i.e., `6`. This is used to identify the type of algorithm used for hashing:
```Identifying-Hashes
$1$  : MD5
$2a$ : Blowfish
$2y$ : Blowfish, with correct handling of 8 bit characters
$5$  : SHA256
$6$  : SHA512
```
The next field, `vb1tLY1qiY`, is the salt used during hashing, and the final field is the actual hash.
Open and closed source software use many different kinds of hash formats. For example, the `Apache` web server stores its hashes in the format `$apr1$71850310$gh9m4xcAn3MGxogwX/ztb.`, while `WordPress` stores hashes in the form `$P$984478476IagS59wHZvyQMArzfx58u`.
### Context is Important
It is not always possible to identify the algorithm based on the obtained hash as the plaintext might undergo multiple enc rounds and salting transformations.
It is important to note that `hashid` uses regex to make a best-effort determination for the type of hash provided. Often, `hashid` will provide many possibilities for a given hash, and we have to guess from there.
A good way to figure out which algorithm was used ask yourself how the hash was obtained:
	Via an Active Directory (AD) attack or from a Windows host?
	Via the successful exploitation of a SQL injection vuln?
Knowing where a hash came from will greatly help narrow down the hash type and, therefore, the `Hashcat` mode necessary to attempt to crack it.
`Hashcat` provides an invaluable [reference](https://hashcat.net/wiki/doku.php?id=example_hashes) that maps hash modes to example hashes.
Passing the hash `a2d1f7b7a1862d0d4a52644e72d59df5:500:lp@trash-mail.com` to `hashid` will give us various possibilities:
```example
Poppy36@htb[/htb]$ hashid 'a2d1f7b7a1862d0d4a52644e72d59df5:500:lp@trash-mail.com'

Analyzing 'a2d1f7b7a1862d0d4a52644e72d59df5:500:lp@trash-mail.com'
[+] MD5 
[+] MD4 
[+] Double MD5 
[+] LM 
[+] RIPEMD-128 
[+] Haval-128 
[+] Tiger-128 
[+] Skein-256(128) 
[+] Skein-512(128) 
[+] Lotus Notes/Domino 5 
[+] Skype 
[+] Lastpass 
```
However, looking through the `Hashcat` example hashes reference shows that it is a Lastpass hash, which is hash mode 6800. **Context is important** during assessments and is important to consider when working with any tool that attempts to identify hash types.