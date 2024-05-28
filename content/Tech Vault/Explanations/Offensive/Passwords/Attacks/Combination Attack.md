Takes two wordlists as input and create combos from them.
Useful because it is common for users to join two or more words together, thinking this creates a stronger pw, i.e. `welcomehome` or `hotelcalifornia`
To demo, consider the following wordlists
```demo
$cat wordlist1
super
world
secret

$cat wordlist2
hello
password
```
If given these two word lists, [[hashcat]] will produce exactly `3x2=6` words:
```demo
$ awk '(NR==FNR) { a[NR]=$0 } (NR != FNR) { for (i in a) { print $0 a[i] } }' file2 file1

superhello
superpassword
worldhello
wordpassword
secrethello
secretpassword
```
This can also be accomplished with [[hashcat]] using the `stdout` flag which can be very helpful for debugging purposes and seeing how the tool is handling things:
```demo
$ hashcat -a 1 --stdout file1 file2
superhello
superpassword
worldhello
worldpassword
secrethello
secretpassword
```
