[[hashcat]] has 5 different attack modes. Each have different applications depending on the type of hash you are trying to crack and the complexity of the pw. The dictionary attack is the most straightfoward and extremely effective attack type. 
It's not uncommon to encounter orgs w/ weak pw policies whose users select common words and phrases with little to no complexity as their pws.
The org SplashData analyzed millions of leaked pws and the top 5 most common as of 2020 are:
	12345
	123456789
	qwerty
	password
	1234567
Despite training users on sec awareness, users will often choose one out of convenience if an org allows weak pws, which appear in most dictionary file used to perform this type of attack. Password lists can be obtained from many sources, such as [SecLists](https://github.com/danielmiessler/SecLists/tree/master/Passwords). The most popular wordlist, by far, is the `rockyou.txt` wordlist, which is found in most pentesting Linux distros.
We can also find large wordlists such as [CrackStation's Password Cracking Dictionary](https://crackstation.net/crackstation-wordlist-password-cracking-dictionary.htm), which contains 1,493,677,782 words and is 15GB in size. There are also much larger wordlists made up of cleartext pws obtained from multiple breaches and pw dumps, some well over 40gp in size. These can be extremely useful when attempting to crack a single password, critical to your engagement's success, on a powerful GPU or when performing a domain password analysis of all of the user passwords in an Active Directory environment by attempting to crack as many of the NTLM password hashes in the NTDS.dit file as possible.
## Straight or Dictionary Attack
This attack reads from a wordlist and tries to crack the supplied hashes. Dictionary attacks are useful if you know that the target org uses weak pws or just wants to run through some cracking attempts rather quickly. This attack is typically faster to complete than the more complex available atks. The basic syntax is: `hashcat -a 0 -m <hash_type> <hash_file> <wordlist>`