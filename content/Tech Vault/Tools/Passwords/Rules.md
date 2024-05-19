Rules help perform various ops on the input wordlist, such as prefixing, suffixing, toggling case, cutting, reversing, and more.
Rules take a mask-based atk and inc cracking rates.
Useage of rules saves disk space and processing time incurred as a result of larger wordlists.

A rule can be created using fcs, which take a word as input and output it's modded version. The following table describes some fcs which are compatible with JtR and [[hashcat]]:

| **Function**    | **Description**                                                    | **Input**                             | **Output**                                                                                                        |
| --------------- | ------------------------------------------------------------------ | ------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| l               | Convert all letters to lowercase                                   | InlaneFreight2020                     | inlanefreight2020                                                                                                 |
| u               | Convert all letters to uppercase                                   | InlaneFreight2020                     | INLANEFREIGHT2020                                                                                                 |
| c / C           | capitalize / lowercase first letter and invert the rest            | inlaneFreight2020 / Inlanefreight2020 | Inlanefreight2020 / iNLANEFREIGHT2020                                                                             |
| t / TN          | Toggle case : whole word / at position N                           | InlaneFreight2020                     | iNLANEfREIGHT2020                                                                                                 |
| d / q / zN / ZN | Duplicate word / all characters / first character / last character | InlaneFreight2020                     | InlaneFreight2020InlaneFreight2020 / IInnllaanneeFFrreeiigghhtt22002200 / IInlaneFreight2020 / InlaneFreight20200 |
| { / }           | Rotate word left / right                                           | InlaneFreight2020                     | nlaneFreight2020I / 0InlaneFreight202                                                                             |
| ^X / $X         | Prepend / Append character X                                       | InlaneFreight2020 (^! / $! )          | !InlaneFreight2020 / InlaneFreight2020!                                                                           |
| r               | Reverse                                                            | InlaneFreight2020                     | 0202thgierFenalnI                                                                                                 |
A complete list of functions can be found [here](https://hashcat.net/wiki/doku.php?id=rule_based_attack#implemented_compatible_functions). Sometimes, the input wordlists contain words that don't match the target specs e.g. a co's pw policy might not allow users to set pws less than 7 chars in length. In such cases, rejection rules can be used to prevent the processing of such words.

Words of length less than N can be rejected with `>N`, while words greater than N can be rejected with `<N`. A list of rejection rules can be found [here](https://hashcat.net/wiki/doku.php?id=rule_based_attack#rules_used_to_reject_plains).

> [!Note] Important Note:
> Reject rules only work either with `hachcat-legacy`, or when using `-j` or `-k` with `hashcat`. They will not work as regular rules (in a rule file) with `hashcat`.

## Example Rule Creation
Usual user behavior suggests that they tend to replace letters with similar numbers, like `o` can be replaced with a `0` or `i` can be replaced with a `1`. This is commonly known as `L337speak` and is very efficient. Corp pws are often prepended or appended by a year. Create a rule to gen such words as follows: `c so0 si1 se3 ss5 sa@ $2 $0 $1 $9`. The first leet word is cap'd with the `c` fc. Then the rule uses the sub fcs `s` to replace `o` with a `0`, `i` with a `1`, `e` with a `3`, `s` with a `5`, and `a` with a `@`. At the end, the year `2019` is appended to it. Copy the rule to a file to debug it:
```create-rule-file
$ echo 'c so0 si1 se3 ss5 sa@ $2 $0 $1 $9' > rule.txt
```
```create-pw-test-file
$ echo 'password_ilfreight' > test.txt
```
Rules can be debugged using the `-r` flag to specify the rule followed by the wordlist:
```debugging
$ hashcat -r rule.txt test.txt --stdout

P@55w0rd_1lfr31ght2019
```
As expected, the first letter was cap'd, and the letters were replaced with numbers.
Now consider the following pw and create the `SHA1` hash of it via cli: `St@r5h1p2019`
```gen-SHA1-hash
$ echo -n 'St@r5h1p2019' | sha1sum | awk '{print $1}' | tee hash
```
Then use custom rule created above and the `rockyou.txt` dict file to crack the hash using `hashcat`:
```cracking-pw-wordlist-rules
$ hashcat -a 0 -m 100 hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt -r rule.txt

hashcat (v6.1.1) starting...
<SNIP>

08004e35561328e357e34d07c53c7e4f41944e28:St@r5h1p2019
                                                 
Session..........: hashcat
Status...........: Cracked
Hash.Name........: SHA1
Hash.Target......: 08004e35561328e357e34d07c53c7e4f41944e28
Time.Started.....: Fri Aug 28 22:17:13 2020, (3 secs)
Time.Estimated...: Fri Aug 28 22:17:16 2020, (0 secs)
Guess.Base.......: File (/opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt)
Guess.Mod........: Rules (rule.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:  3519.2 kH/s (0.39ms) @ Accel:1024 Loops:1 Thr:1 Vec:8
Recovered........: 1/1 (100.00%) Digests
Progress.........: 10592256/14344385 (73.84%)
Rejected.........: 0/10592256 (0.00%)
Restore.Point....: 10586112/14344385 (73.80%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidates.#1....: St0p69692019 -> S0r051x53nt2019
```
`hashcat` supports the usage of multi-rules with the repeated use of the `-r` flag. `hashcat` installs with a variety of rules by default, which can be found in the rules folder: `ls -lha /usr/share/hashcat/rules`.
It's always better to try using these rules first before creating custom rules.

Using the `-g` flag, will tell `hashcat` gen random rules on the fly and apply them to the input wordlist. There is no certainty to the success rate of this atk as the gen'd rules are not constant. The following command will gen 1000 random rules and apply them to each word from `rockyou.txt`: `$ hashcat -a 0 -m 100 -g 1000 hash /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt

There are a variety of publicly available rules as well, such as the [nsa-rules](https://github.com/NSAKEY/nsa-rules), [Hob0Rules](https://github.com/praetorian-code/Hob0Rules), and the [corporate.rule](https://github.com/sparcflow/HackLikeALegend/blob/master/old/chap3/corporate.rule) which is featured in the book [How to Hack Like a Legend](https://www.sparcflow.com/new-release-hack-like-legend/). These are curated rulesets generally targeted at common corporate Windows password policies or based on statistics and probably industry password patterns.

It is generally best to start with small targeted wordlists and rule sets, esp if the pw policy is known or we have a general idea of the policy. Extremely large dict files combo'd with large rule sets can be effective as well, but are limited by computing power. Understanding the power of rules will help greatly refine pw cracking abilities, saving both time and resources in the process.