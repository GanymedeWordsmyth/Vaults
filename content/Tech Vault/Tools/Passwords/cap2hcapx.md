 There are various tools, such as [[airodump-ng]], which you can use to successfully capture a 4-way handshake. Then, convert it to a format a format that can be supplied to `hashcat` for cracking using the `hccapx` format. `hashcat` hosts an online service to convert to this format (not recommended for actual client data but fine for lab/practice exercises): [cap2hashcat online](https://hashcat.net/cap2hashcat). Alternatively, you can perform an offline conversion using the `hashcat-utils` repo from GitHub.
```syntax
$ ./cap2hccapx.bin input.cap output.hccapx [filter-by-essid] [additional-network-essid:bssid]
```
```example
./cap2hccapx.bin corp_capture1-01.cap mic_to_crack.hccapx
```
After creating this file, move on to cracking it. The [[hashcat]] mode for this example is 22000. Note: mode 2500 has been deprecated