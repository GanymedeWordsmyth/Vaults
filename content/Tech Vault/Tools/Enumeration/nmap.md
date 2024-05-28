*Enumeration, enumeration, enumeration. If you can't figure something out, it's because you haven't enumerated enough.*
# Introduction
## Enumeration
`Enumeration` is the most critical part of all. The art, the difficulty, and the goal are not to gain access to our target computer. Instead, it is identifying *all* of the ways we could atk a target that must be found.

This is not just based on the tools used. They only get you so far. The tools are just tools, and tools alone should never replace knowledge and attention to detail. Enumeration is much more about actively interacting w the individual services to see what info they provide and what possibilities the offer.

It is essential to understand how these services work and what syntax they use for effective communication and interaction w the diff services.

This phase aims to improve a pentester's knowledge and understanding of the techs, protocols, and how they work and learn to deal w new info and adapt to a pentester's already acquired knowledge. Enumeration is about collecting as much info as possible. The more info you have, the easier it will be to find vectors of atk.

It's not hard to get access to a target sys once we know how to do it. Most of the ways to gain access can be narrowed down to the following two points:
- `Functions and/or resources that allow us to interact w the target and/or provide additional information`
- `Information that provides us w even more important info to access our target`
When scanning and inspecting, look for these two possibilities. Most of the info gained comes from misconfigs or neglect of sec for the respective services. Misconfigs are either the result of ignorance or a wrong sec mindset e.g. if the admin only relies on the firewall, Group Policy Objects (GPOs), and continuous updates, it is often not enough to secure the network.

`Enumeration is the key`.

That's what most people say, and they are right. However, it is too often misunderstood. Most people understand that they haven't tried all the tools to get the info they need. Most of the time, though, it's not the tools that weren't tried, but rather the fact that they don't know how to interact w the service and what's relevant. 

That's precisely why so many people stay stuck in one spot and don't get ahead. Had these people invested a couple of hours learning more about the service in question, how it works, and what it is meant for, they would save a few hours or even days from reaching their goal and get access to the sys.

`Manual enumeration` is a `critical` component. Many scanning tools simplify and accelerate the proc. However, these cannot always bypass the sec measures of the services.
## Introduction to Nmap
Network Mapper (`Nmap`) is a FOSS network analysis and security auditing tool written in C, C++, Python, and Lua. It is designed to scan networks and ID which hosts are avail on the network using raw packets and services and apps, including the name and version, where possible. It can also ID the OS and versions of these hosts. Besides other features, Nmap also offers scanning capabilities that can determine if packet filters, firewalls, or intrusion detection systems (IDS) are config'd as needed.
This tool is one of the most used tools by net admind and IT sec specialists. It is used to:
- Audit the security aspects of networks
- Simulate penetration tests
- Check firewall and IDS settings and configurations
- Types of possible connections
- Network mapping
- Response analysis
- Identify open ports
- Vulnerability assessment as well.
Nmap offers many diff types of scans that can be used to obtain various results about targets. Basically, Nmap can be divided into the following scanning techniques:
- Host disc
- Port scanning
- Service enumeration and detection
- OS detection
- Scriptable interaction w the target service (Nmap Scripting Engine)
```syntax
$ nmap <scan-types> <options> <target>
```
The cmd `nmap --help` will display all the scanning techniques Nmap offers.
# Host Enumeration
## Host Discovery
When conducting an internal pentest for the entire network of a co, the first thing to do is to get an overview of which systems are online that can be worked w. To actively discover such systems on the network, utilize the various `nmap` host discovery options, the most effective of which is the **ICMP echo requests**.

It is always recommended to store every single scan. This can later be used for comparison, documentation, and reporting. After all, diff tools may produce diff results. Therefore, it can be beneficial to distinguish which tool produces which results.
`$ sudo nmap 10.129.2.0/24 -sn -oA tnet | grep for | cut -d" " -f5`

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.0/24`|Target network range.|
|`-sn`|Disables port scanning.|
|`-oA tnet`|Stores the results in all formats starting with the name 'tnet'.|
>[!Note]
>This scanning method only works if the firewalls of the hosts allow it. Otherwise, there are other scanning techniques to find out if the hosts are active or not. This is covered in [[nmap#Firewall and IDS Evasion]]
### Scan IP List
During an internal pentest, it is not uncommon to be provided w an IP list w the hosts needed to be tested. `Nmap` also gives the option of working w lists and reading the hosts from this list instead of manually defining or typing them in.
```example-ip-list
$ cat hosts.lst

10.129.2.4
10.129.2.10
10.129.2.11
10.129.2.18
10.129.2.19
10.129.2.20
10.129.2.28
```
The cmd to use the same scanning technique on the predefined list would look like: `$ sudo nmap -sn -oA tnet -iL hosts.lst | grep for | cut -d" " -f5` Any IP addr that are displayed are the active hosts. Remember, this may mean that the other hosts ignore the default **ICMP echo requests** b/c of their firewall configs. Since `Nmap` does not receive a response, it marks those hosts as inactive.

|**Scanning Options**|**Description**|
|---|---|
|`-sn`|Disables port scanning.|
|`-oA tnet`|Stores the results in all formats starting with the name 'tnet'.|
|`-iL`|Performs defined scans against targets in provided 'hosts.lst' list.|
#### Scan Multiple IPs
It's also common to only need to scan a small part of a network. An alternative to the method used last time is to specify multiple IP addrs:
`$ sudo nmap -sn -oA tnet 10.129.2.18 10.129.2.19 10.129.2.20 | grep for | cut -d" " -f5`
Fun note: if any IP addrs are next to each other, define the range in the respective octet:
`$ sudo nmap -sn -oA tnet 10.129.2.18-20 | grep for | cut -d" " -f5`
#### Scan Single IP
Before scanning a single host for open ports and its services, first determine if it is alive or not w the following cmd that we've used before:
`$ sudo nmap 10.129.2.18 -sn -oA host`

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.18`|Performs defined scans against the target.|
|`-sn`|Disables port scanning.|
|`-oA host`|Stores the results in all formats starting with the name 'host'.|
By disabling port scan (`-sn`), Nmap automatically ping scans w `ICMP Echo Requests` (`-PE`). Once such a request is sent, it is common to expect an `ICMP reply` if the pinging host is alive. The more interesting fact is that the previous scans in this section did not do that b/c before Nmap could send an ICMP echo request, it would send an `ARP ping` resulting in an `ARP reply`, which can be confirmed w the "`--packet-trace`" option.
`$ sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace`

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.18`|Performs defined scans against the target.|
|`-sn`|Disables port scanning.|
|`-oA host`|Stores the results in all formats starting with the name 'host'.|
|`-PE`|Performs the ping scan by using 'ICMP Echo requests' against the target.|
|`--packet-trace`|Shows all packets sent and received|
Another way to determine why Nmap has a target marked as "alive" is w the "`--reason`" option.
`$ sudo nmap 10.129.2.18 -sn -oA host -PE --reason`
```which-returns
Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:10 CEST
SENT (0.0074s) ARP who-has 10.129.2.18 tell 10.10.14.2
RCVD (0.0309s) ARP reply 10.129.2.18 is-at DE:AD:00:00:BE:EF
Nmap scan report for 10.129.2.18
Host is up, received arp-response (0.028s latency).
MAC Address: DE:AD:00:00:BE:EF
Nmap done: 1 IP address (1 host up) scanned in 0.03 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.18`|Performs defined scans against the target.|
|`-sn`|Disables port scanning.|
|`-oA host`|Stores the results in all formats starting with the name 'host'.|
|`-PE`|Performs the ping scan by using 'ICMP Echo requests' against the target.|
|`--reason`|Displays the reason for specific result.|
W this cmd, `nmap` detects whether to host is alive or not through the `ARP request` and `ARP reply` alone. To disable ARP requests and scan a target w the desired `ICMP echo requests`, set the "`--disable-arp-ping`" option. Then scan the target again and look at the packets sent and received
```arp-ping-disabled
$ sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace --disable-arp-ping 

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:12 CEST
SENT (0.0107s) ICMP [10.10.14.2 > 10.129.2.18 Echo request (type=8/code=0) id=13607 seq=0] IP [ttl=255 id=23541 iplen=28 ]
RCVD (0.0152s) ICMP [10.129.2.18 > 10.10.14.2 Echo reply (type=0/code=0) id=13607 seq=0] IP [ttl=128 id=40622 iplen=28 ]
Nmap scan report for 10.129.2.18
Host is up (0.086s latency).
MAC Address: DE:AD:00:00:BE:EF
Nmap done: 1 IP address (1 host up) scanned in 0.11 seconds
```
This is where paying attention to detail comes into play. An `ICMP echo request` helps determine if a target is alive and IDs its system. More strategies about host discovery can be found [here](https://nmap.org/book/host-discovery-strategies.html). Notice that using `ICMP` instead of `ARP` displays the target's ttl values, which tells us the OS, in this case, is Windows.
## Host and Port Scanning
After confirming a target is alive, it's time to get a more accurate picture of the system. The necessary info includes:
- Open ports and its services
- Service versions
- Information that the services provided
- Operating system
There are a total of 6 different states for a scanned port:

| **State**          | **Description**                                                                                                                                                                                         |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `open`             | This indicates that the connection to the scanned port has been established. These connections can be **TCP connections**, **UDP datagrams** as well as **SCTP associations**.                          |
| `closed`           | When the port is shown as closed, the TCP protocol indicates that the packet we received back contains an `RST` flag. This scanning method can also be used to determine if our target is alive or not. |
| `filtered`         | Nmap cannot correctly identify whether the scanned port is open or closed because either no response is returned from the target for the port or we get an error code from the target.                  |
| `unfiltered`       | This state of a port only occurs during the **TCP-ACK** scan and means that the port is accessible, but it cannot be determined whether it is open or closed.                                           |
| `open\|filtered`   | If we do not get a response for a specific port, `Nmap` will set it to that state. This indicates that a firewall or packet filter may protect the port.                                                |
| `closed\|filtered` | This state only occurs in the **IP ID idle** scans and indicates that it was impossible to determine if the scanned port is closed or filtered by a firewall.                                           |
### Discovering Open TCP Ports
By default, `Nmap` scans the top 1,000 TCP ports w the SYN scan (`-sS`). This SYN scan is set only to default when run as root b/c of the socket perms req'd to create raw TCP packets. Otherwise, the TCP scan (`-sT`) is performed by default. This means that parameters are set automatically when ports and scanning methods are not defined. Define the ports one by one (`-p 22,25,80,139,445`), by range (`-p 22-445`), by top ports (`--top-ports=10`) from the `Nmap` db that have been signed as most freq, by scanning all ports (`-p-`), and by defining a fast port scans (`-F`), which contains the top 100 ports.
```scanning-top-10-tcp-ports
$ sudo nmap 10.129.2.28 --top-ports=10 

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 15:36 CEST
Nmap scan report for 10.129.2.28
Host is up (0.021s latency).

PORT     STATE    SERVICE
21/tcp   closed   ftp
22/tcp   open     ssh
23/tcp   closed   telnet
25/tcp   open     smtp
80/tcp   open     http
110/tcp  open     pop3
139/tcp  filtered netbios-ssn
443/tcp  closed   https
445/tcp  filtered microsoft-ds
3389/tcp closed   ms-wbt-server
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 1.44 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`--top-ports=10`|Scans the specified top ports that have been defined as most frequent.|
`Nmap` scanned the top 10 TCP ports of the target and displayed their states accordingly. By tracing the packets `Nmap` sends, you will see the `RST` flag on `TCP port 21` that the target sends back. To have a clear view of the SYN scan, disable the `ICMP echo request` (`-Pn`), DNS resolution (`-n`), and ARP ping scan (`--disable-arp-ping`):
```nmap-packet-trace
$ sudo nmap 10.129.2.28 -p 21 --packet-trace -Pn -n --disable-arp-ping

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 15:39 CEST
SENT (0.0429s) TCP 10.10.14.2:63090 > 10.129.2.28:21 S ttl=56 id=57322 iplen=44  seq=1699105818 win=1024 <mss 1460>
RCVD (0.0573s) TCP 10.129.2.28:21 > 10.10.14.2:63090 RA ttl=64 id=0 iplen=40  seq=0 win=0
Nmap scan report for 10.11.1.28
Host is up (0.014s latency).

PORT   STATE  SERVICE
21/tcp closed ftp
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.07 seconds
```

| **Scanning Options** | **Description**                      |
| -------------------- | ------------------------------------ |
| `10.129.2.28`        | Scans the specified target.          |
| `-p 21`              | Scans only the specified port.       |
| `--packet-trace`     | Shows all packets sent and received. |
| `-n`                 | Disables DNS resolution.             |
| `--disable-arp-ping` | Disables ARP ping.                   |
Reading the `SENT` line that you (`10.10.14.2`) sent a TCP packet w the `SYN` flag (`S`) to the target (`10.129.2.28`). The next `RCVD` line shows that the target responds w a TCP packet containing the `RST` and `ACK` flags (`RA`). `RST` and `ACK` flags are used to acknowledge the receipt of the TCP packet (`ACK`) and to end the TCP session (`RST`).
#### Request

|**Message**|**Description**|
|---|---|
|`SENT (0.0429s)`|Indicates the SENT operation of Nmap, which sends a packet to the target.|
|`TCP`|Shows the protocol that is being used to interact with the target port.|
|`10.10.14.2:63090 >`|Represents our IPv4 address and the source port, which will be used by Nmap to send the packets.|
|`10.129.2.28:21`|Shows the target IPv4 address and the target port.|
|`S`|SYN flag of the sent TCP packet.|
|`ttl=56 id=57322 iplen=44 seq=1699105818 win=1024 mss 1460`|Additional TCP Header parameters.|
#### Response

|**Message**|**Description**|
|---|---|
|`RCVD (0.0573s)`|Indicates a received packet from the target.|
|`TCP`|Shows the protocol that is being used.|
|`10.129.2.28:21 >`|Represents targets IPv4 address and the source port, which will be used to reply.|
|`10.10.14.2:63090`|Shows our IPv4 address and the port that will be replied to.|
|`RA`|RST and ACK flags of the sent TCP packet.|
|`ttl=64 id=0 iplen=40 seq=0 win=0`|Additional TCP Header parameters.|
#### Connect Scan
 The Nmap [TCP Connect Scan](https://nmap.org/book/scan-methods-connect-scan.html) (`-sT`) uses the TCP three-way handshake to determine if a specific port on a target host is open or closed. The scan sends a `SYN` packet to the targget port and waits for a response. It is considered open if the target port responds w a `SYN-ACK` packet and closed it if responds w an `RST` packet.

The `Connect` scan is useful b/c it is the most accurate way to determine the state of a port, and is also the most stealthy. Unlike other types of scans, sych as the `SYN` scan, the `Connect` scan does not leave any unfinished connections or unsent packets on the target host, which makes it less likely to be detected by the target's IDS/IPS. It is useful in mapping the network w/o disturbing the services running behind it, thus causing minimal impact and sometimes considered a more polite scan method.

It is also useful when the target host has a personal firewall that drops incoming packets but allows outgoing packets. In this case, a `Connect` scan can bypass the firewall and accurately determine the target ports.
>[!Note] Important Note
>The `Connect` scan is slower than other types of scans b/c it req's the scanner to wait for a response from the target after each packet it sends, which could take some time if the target is busy or unresponsive.
### Filtered Ports
There are several reasons `Nmap` displays a port as filtered. In most cases, firewalls have certain rules set to handle specific connections. The packets can either be `dropped`, or `rejected`. When a packet gets dropped, `Nmap` receives no response from the target, and by default, the retry rate (`--max-retries`) is set to `1`. This means `Nmap` will resend the request to the target port to determine if the previous packet was not accidentally mishandled.

Looking back at the 'scanning-top-10-tcp-ports' example, notice that in the example, TCP port **139** is labeled as `filtered`. To track how sent packets are handled, deactivate the ICMP echo requests (`-Pn`), DNS resolution (`-n`), and ARP ping scan (`--disable-arp-ping`) again:
```dropped-packets
$ sudo nmap 10.129.2.28 -p 139 --packet-trace -n --disable-arp-ping -Pn

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 15:45 CEST
SENT (0.0381s) TCP 10.10.14.2:60277 > 10.129.2.28:139 S ttl=47 id=14523 iplen=44  seq=4175236769 win=1024 <mss 1460>
SENT (1.0411s) TCP 10.10.14.2:60278 > 10.129.2.28:139 S ttl=45 id=7372 iplen=44  seq=4175171232 win=1024 <mss 1460>
Nmap scan report for 10.129.2.28
Host is up.

PORT    STATE    SERVICE
139/tcp filtered netbios-ssn
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 2.06 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-p 139`|Scans only the specified port.|
|`--packet-trace`|Shows all packets sent and received.|
|`-n`|Disables DNS resolution.|
|`--disable-arp-ping`|Disables ARP ping.|
|`-Pn`|Disables ICMP Echo requests.|
This example shows that `Nmap` sent two TCP packets w the `SYN` flag. Notice that the duration (`2.06s`) of the scan took much longer than the previous ones (`~0.05s`). 
In cases where the firewall `rejects` the packets, the outcome might look as follows:
```rejected-packets
$ sudo nmap 10.129.2.28 -p 445 --packet-trace -n --disable-arp-ping -Pn

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 15:55 CEST
SENT (0.0388s) TCP 10.129.2.28:52472 > 10.129.2.28:445 S ttl=49 id=21763 iplen=44  seq=1418633433 win=1024 <mss 1460>
RCVD (0.0487s) ICMP [10.129.2.28 > 10.129.2.28 Port 445 unreachable (type=3/code=3) ] IP [ttl=64 id=20998 iplen=72 ]
Nmap scan report for 10.129.2.28
Host is up (0.0099s latency).

PORT    STATE    SERVICE
445/tcp filtered microsoft-ds
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.05 seconds
```

| **Scanning Options** | **Description**                      |
| -------------------- | ------------------------------------ |
| `10.129.2.28`        | Scans the specified target.          |
| `-p 445`             | Scans only the specified port.       |
| `--packet-trace`     | Shows all packets sent and received. |
| `-n`                 | Disables DNS resolution.             |
| `--disable-arp-ping` | Disables ARP ping.                   |
| `-Pn`                | Disables ICMP Echo requests.         |
This time, the target sends an `ICMP` response w `type 3` and `error code 3`, which indicates that the desired port is unreachable. Nevertheless, knowing that a host is alive means it is safe to assume that the firewall on a port is rejecting the packets, and to take a closer look at this port later.
### Discovering Open UDP Ports
Some sysadmins sometimes forget to filter the UDP ports in addition to the TCP ones. `UDP` is a `stateless protocol` and does not require a three-way handshake like TCP, meaning `Nmap` will not receive any acknowledgement. Consequently, the timeout is much longer, making the whole `UDP scan` (`-sU`) much slower than the `TCP scan` (`-sS`). An example of a UDP scan can look like the following:
```udp-port-scan
$ sudo nmap 10.129.2.28 -F -sU

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 16:01 CEST
Nmap scan report for 10.129.2.28
Host is up (0.059s latency).
Not shown: 95 closed ports
PORT     STATE         SERVICE
68/udp   open|filtered dhcpc
137/udp  open          netbios-ns
138/udp  open|filtered netbios-dgm
631/udp  open|filtered ipp
5353/udp open          zeroconf
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 98.07 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-F`|Scans top 100 ports.|
|`-sU`|Performs a UDP scan.|
Another disadv of this is that `Nmap` sends empty datagrams to the scanned UDP port, and thus will not receive any responses. Therefore, it's not possible to determine if the UDP packet has arrived at all or not. If the UDP port is `open`, `Nmap` only receives a response if the application is configured to do so.
```shell-session
$ sudo nmap 10.129.2.28 -sU -Pn -n --disable-arp-ping --packet-trace -p 137 --reason 

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 16:15 CEST
SENT (0.0367s) UDP 10.10.14.2:55478 > 10.129.2.28:137 ttl=57 id=9122 iplen=78
RCVD (0.0398s) UDP 10.129.2.28:137 > 10.10.14.2:55478 ttl=64 id=13222 iplen=257
Nmap scan report for 10.129.2.28
Host is up, received user-set (0.0031s latency).

PORT    STATE SERVICE    REASON
137/udp open  netbios-ns udp-response ttl 64
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.04 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-sU`|Performs a UDP scan.|
|`-Pn`|Disables ICMP Echo requests.|
|`-n`|Disables DNS resolution.|
|`--disable-arp-ping`|Disables ARP ping.|
|`--packet-trace`|Shows all packets sent and received.|
|`-p 137`|Scans only the specified port.|
|`--reason`|Displays the reason a port is in a particular state.|
If we get an ICMP response with `error code 3` (port unreachable), we know that the port is indeed `closed`.
```shell-session
$ sudo nmap 10.129.2.28 -sU -Pn -n --disable-arp-ping --packet-trace -p 100 --reason 

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 16:25 CEST
SENT (0.0445s) UDP 10.10.14.2:63825 > 10.129.2.28:100 ttl=57 id=29925 iplen=28
RCVD (0.1498s) ICMP [10.129.2.28 > 10.10.14.2 Port unreachable (type=3/code=3) ] IP [ttl=64 id=11903 iplen=56 ]
Nmap scan report for 10.129.2.28
Host is up, received user-set (0.11s latency).

PORT    STATE  SERVICE REASON
100/udp closed unknown port-unreach ttl 64
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in  0.15 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-sU`|Performs a UDP scan.|
|`-Pn`|Disables ICMP Echo requests.|
|`-n`|Disables DNS resolution.|
|`--disable-arp-ping`|Disables ARP ping.|
|`--packet-trace`|Shows all packets sent and received.|
|`-p 100`|Scans only the specified port.|
|`--reason`|Displays the reason a port is in a particular state.|
For all other ICMP responses, the scanned ports are marked as (`open|filtered`).

```shell-session
$ sudo nmap 10.129.2.28 -sU -Pn -n --disable-arp-ping --packet-trace -p 138 --reason 

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 16:32 CEST
SENT (0.0380s) UDP 10.10.14.2:52341 > 10.129.2.28:138 ttl=50 id=65159 iplen=28
SENT (1.0392s) UDP 10.10.14.2:52342 > 10.129.2.28:138 ttl=40 id=24444 iplen=28
Nmap scan report for 10.129.2.28
Host is up, received user-set.

PORT    STATE         SERVICE     REASON
138/udp open|filtered netbios-dgm no-response
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 2.06 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-sU`|Performs a UDP scan.|
|`-Pn`|Disables ICMP Echo requests.|
|`-n`|Disables DNS resolution.|
|`--disable-arp-ping`|Disables ARP ping.|
|`--packet-trace`|Shows all packets sent and received.|
|`-p 138`|Scans only the specified port.|
|`--reason`|Displays the reason a port is in a particular state.|
Another handy method for scanning ports is the `-sV` option which is used to get additional available information from the open ports. This method can identify versions, service names, and details about our target.
```version-scan
$ sudo nmap 10.129.2.28 -Pn -n --disable-arp-ping --packet-trace -p 445 --reason  -sV

Starting Nmap 7.80 ( https://nmap.org ) at 2022-11-04 11:10 GMT
SENT (0.3426s) TCP 10.10.14.2:44641 > 10.129.2.28:445 S ttl=55 id=43401 iplen=44  seq=3589068008 win=1024 <mss 1460>
RCVD (0.3556s) TCP 10.129.2.28:445 > 10.10.14.2:44641 SA ttl=63 id=0 iplen=44  seq=2881527699 win=29200 <mss 1337>
NSOCK INFO [0.4980s] nsock_iod_new2(): nsock_iod_new (IOD #1)
NSOCK INFO [0.4980s] nsock_connect_tcp(): TCP connection requested to 10.129.2.28:445 (IOD #1) EID 8
NSOCK INFO [0.5130s] nsock_trace_handler_callback(): Callback: CONNECT SUCCESS for EID 8 [10.129.2.28:445]
Service scan sending probe NULL to 10.129.2.28:445 (tcp)
NSOCK INFO [0.5130s] nsock_read(): Read request from IOD #1 [10.129.2.28:445] (timeout: 6000ms) EID 18
NSOCK INFO [6.5190s] nsock_trace_handler_callback(): Callback: READ TIMEOUT for EID 18 [10.129.2.28:445]
Service scan sending probe SMBProgNeg to 10.129.2.28:445 (tcp)
NSOCK INFO [6.5190s] nsock_write(): Write request for 168 bytes to IOD #1 EID 27 [10.129.2.28:445]
NSOCK INFO [6.5190s] nsock_read(): Read request from IOD #1 [10.129.2.28:445] (timeout: 5000ms) EID 34
NSOCK INFO [6.5190s] nsock_trace_handler_callback(): Callback: WRITE SUCCESS for EID 27 [10.129.2.28:445]
NSOCK INFO [6.5320s] nsock_trace_handler_callback(): Callback: READ SUCCESS for EID 34 [10.129.2.28:445] (135 bytes)
Service scan match (Probe SMBProgNeg matched with SMBProgNeg line 13836): 10.129.2.28:445 is netbios-ssn.  Version: |Samba smbd|3.X - 4.X|workgroup: WORKGROUP|
NSOCK INFO [6.5320s] nsock_iod_delete(): nsock_iod_delete (IOD #1)
Nmap scan report for 10.129.2.28
Host is up, received user-set (0.013s latency).

PORT    STATE SERVICE     REASON         VERSION
445/tcp open  netbios-ssn syn-ack ttl 63 Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
Service Info: Host: Ubuntu

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 6.55 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-Pn`|Disables ICMP Echo requests.|
|`-n`|Disables DNS resolution.|
|`--disable-arp-ping`|Disables ARP ping.|
|`--packet-trace`|Shows all packets sent and received.|
|`-p 445`|Scans only the specified port.|
|`--reason`|Displays the reason a port is in a particular state.|
|`-sV`|Performs a service scan.|
More information about port scanning techniques we can find [here](https://nmap.org/book/man-port-scanning-techniques.html)
## Saving the Results
While running various scans, it is best practice to save the results (side note, I answered one of the exercise questions by looking at a previous scan), which can be used later to examine the diffs b/w the diff scanning methods used. `Nmap` can save the results in 1 of 3 formats:
- Normal output (`-oN`) w the `.nmap` file extension
- Grepable output (`-oG`) w the `.gnmap` file extension
- XML output (`-oX`) w the `.xml` file extension
To save the results in all formats, use the "`-oA`" option. If no full path is given, the results will be stored in the current dir.
More information about the output formats can be found at: [https://nmap.org/book/output.html](https://nmap.org/book/output.html)
#### Style sheets
Use the following cmd to use the XML output to easily create HTML reports that are easy to read (even for non-technical people) and very useful for documentation:
`$ xsltproc <result>.xml -o <name>.html`
## Service Enumeration
For pentesters, it is essential to determine the app and its version as accurately as possible. This info can be used to scan for known vulns and analyze the source code for that version. An exact version num allows a pentester to search for a more precise exploit that fits the service and the OS of their target.
### Service Version Detection
It is recommended to perform a quick port scan first, which gives a small overview of the avail ports. This causes significantly less traf, which is advantageous b/c otherwise it is possible to be discovered and blocked by the sec mechanisms. So, deal with these first and run a port scan in the background that shows all open ports (`-p-`). Then, use the version scan to scan the specific ports for services and their versions (`-sV`).

A full port scan takes a v long time. To view the scan status, press the `[Space Bar]` during the scan.

Another option to use is defining the intervals at which the status should be shown w `--stats-every=5s`. Here, specify the num of sec (`s`) or min (`m`), after which to show the status.

Additionally, increasing the `verbosity level` (`-v`/`-vv`) will show the open ports whenever `Nmap` detects them.
### Banner Grabbing
Once the scan is complete, `Nmap` will show all TCP ports w the corresponding service and their versions that are active on the sys. Primarily, `Nmap` looks at the banners of the scanned ports and prints them out. If it cannot ID versions through the banners, `Nmap` attempts to ID them through a sig-based matching sys, but this significantly inc the scan's duration. One disadv to `Nmap`'s presented results is that the auto scan can miss some info b/c sometimes `Nmap` does not know how to handle it. Consider the following output:
```example
$ sudo nmap 10.129.2.28 -p- -sV -Pn -n --disable-arp-ping --packet-trace

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-16 20:10 CEST
<SNIP>
NSOCK INFO [0.4200s] nsock_trace_handler_callback(): Callback: READ SUCCESS for EID 18 [10.129.2.28:25] (35 bytes): 220 inlane ESMTP Postfix (Ubuntu)..
Service scan match (Probe NULL matched with NULL line 3104): 10.129.2.28:25 is smtp.  Version: |Postfix smtpd|||
NSOCK INFO [0.4200s] nsock_iod_delete(): nsock_iod_delete (IOD #1)
Nmap scan report for 10.129.2.28
Host is up (0.076s latency).

PORT   STATE SERVICE VERSION
25/tcp open  smtp    Postfix smtpd
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
Service Info: Host:  inlane

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.47 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-p-`|Scans all ports.|
|`-sV`|Performs service version detection on specified ports.|
|`-Pn`|Disables ICMP Echo requests.|
|`-n`|Disables DNS resolution.|
|`--disable-arp-ping`|Disables ARP ping.|
|`--packet-trace`|Shows all packets sent and received.|
Notice the line:
- `NSOCK INFO [0.4200s] nsock_trace_handler_callback(): Callback: READ SUCCESS for EID 18 [10.129.2.28:25] (35 bytes): 220 inlane ESMTP Postfix (Ubuntu)..`
Then, also notice the SMTP server on the target gives more info than `Nmap` showed. B/c of this, it is apparent that it is the `Ubuntu` Linux distro. After a successful three-way handshake, the server often sends a banner for ID. This serves to let the client know which service it is working w. At the network level, this happens w a `PSH` flag in the TCP header. However, it can happen that some services do not immediately provide such info. It is also possible to remove or manipulate the banners from the respective services. To see what `Nmap` didn't show, `manually` connect to the SMTP server using `nc`, grab the banner, and intercept the net traf using `tcpdump`:
```tcpdump
$ sudo tcpdump -i eth0 host 10.10.14.2 and 10.129.2.28

tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
```
```nc
$  nc -nv 10.129.2.28 25

Connection to 10.129.2.28 port 25 [tcp/*] succeeded!
220 inlane ESMTP Postfix (Ubuntu)
```
```tcpdump-intercepted-traffic
18:28:07.128564 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [S], seq 1798872233, win 65535, options [mss 1460,nop,wscale 6,nop,nop,TS val 331260178 ecr 0,sackOK,eol], length 0
18:28:07.255151 IP 10.129.2.28.smtp > 10.10.14.2.59618: Flags [S.], seq 1130574379, ack 1798872234, win 65160, options [mss 1460,sackOK,TS val 1800383922 ecr 331260178,nop,wscale 7], length 0
18:28:07.255281 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [.], ack 1, win 2058, options [nop,nop,TS val 331260304 ecr 1800383922], length 0
18:28:07.319306 IP 10.129.2.28.smtp > 10.10.14.2.59618: Flags [P.], seq 1:36, ack 1, win 510, options [nop,nop,TS val 1800383985 ecr 331260304], length 35: SMTP: 220 inlane ESMTP Postfix (Ubuntu)
18:28:07.319426 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [.], ack 36, win 2058, options [nop,nop,TS val 331260368 ecr 1800383985], length 0
```
The first three lines show us the three-way handshake.
1. `[SYN]` `18:28:07.128564 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [S], <SNIP>`
2. `[SYN-ACK]` `18:28:07.255151 IP 10.129.2.28.smtp > 10.10.14.2.59618: Flags [S.], <SNIP>`
3. `[ACK]` `18:28:07.255281 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [.], <SNIP>`
After that, the target SMTP server send a TCP pkt w the `PSH` and `ACK` flags, where `PSH` states that the target server is sending data back and w `ACK` simultaneously informs that all req data has been sent.
4. `[PSH-ACK]` `18:28:07.319306 IP 10.129.2.28.smtp > 10.10.14.2.59618: Flags [P.], <SNIP>`
The last TCP packet that we sent confirms the receipt of the data with an `ACK`.
5. `[ACK]` `18:28:07.319426 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [.], <SNIP>`
## Nmap Scripting Engine
Nmap Scripting Engine (`NSE`) provides the possibility to create scripts in Lua for interaction w/ certain services. There are a total of 14 categories into which these scripts can be divided:

| **Category** | **Description**                                                                                                                         |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| `auth`       | Determination of authentication credentials.                                                                                            |
| `broadcast`  | Scripts, which are used for host discovery by broadcasting and the discovered hosts, can be automatically added to the remaining scans. |
| `brute`      | Executes scripts that try to log in to the respective service by brute-forcing with credentials.                                        |
| `default`    | Default scripts executed by using the `-sC` option.                                                                                     |
| `discovery`  | Evaluation of accessible services.                                                                                                      |
| `dos`        | These scripts are used to check services for denial of service vulnerabilities and are used less as it harms the services.              |
| `exploit`    | This category of scripts tries to exploit known vulnerabilities for the scanned port.                                                   |
| `external`   | Scripts that use external services for further processing.                                                                              |
| `fuzzer`     | This uses scripts to identify vulnerabilities and unexpected packet handling by sending different fields, which can take much time.     |
| `intrusive`  | Intrusive scripts that could negatively affect the target system.                                                                       |
| `malware`    | Checks if some malware infects the target system.                                                                                       |
| `safe`       | Defensive scripts that do not perform intrusive and destructive access.                                                                 |
| `version`    | Extension for service detection.                                                                                                        |
| `vuln`       | Identification of specific vulnerabilities.                                                                                             |
There are several ways to call desired scripts:

| **Script**         | **Call**                                                            |
| ------------------ | ------------------------------------------------------------------- |
| Default            | `$sudo nmap <target> -sC`                                           |
| Specified Category | `$ sudo nmap <target> --script <category>`                          |
| Defined            | `$ sudo nmap <target> --script <script-name-1>,<script-name-2>,...` |
```nmap-example-specifying-scripts
$ sudo nmap 10.129.2.28 -p 25 --script banner,smtp-commands

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-16 23:21 CEST
Nmap scan report for 10.129.2.28
Host is up (0.050s latency).

PORT   STATE SERVICE
25/tcp open  smtp
|_banner: 220 inlane ESMTP Postfix (Ubuntu)
|_smtp-commands: inlane, PIPELINING, SIZE 10240000, VRFY, ETRN, STARTTLS, ENHANCEDSTATUSCODES, 8BITMIME, DSN, SMTPUTF8,
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
```

| **Scanning Options**            | **Description**                |
| ------------------------------- | ------------------------------ |
| `10.129.2.28`                   | Scans the specified target.    |
| `-p 25`                         | Scans only the specified port. |
| `--script banner,smtp-commands` | Uses specified NSE scripts.    |
Using the `banner` script shows the target sys is an Ubuntu Linux distro. The `smtp-commands` script shows which cmds can be used by interaction w the target SMTP server. In this example, such info may help to find out existing users on the target. `Nmap` also gives the ability to scan a target w the aggressive option (`-A`). This scans the target w multiple options as service detection (`-sV`), OS detection (`-O`), traceroute (`--traceroute`), and w the default NSE scripts (`-sC`).
```nmap-example-aggressive-scan
$ sudo nmap 10.129.2.28 -p 80 -A
Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-17 01:38 CEST
Nmap scan report for 10.129.2.28
Host is up (0.012s latency).

PORT   STATE SERVICE VERSION
80/tcp open  http    Apache httpd 2.4.29 ((Ubuntu))
|_http-generator: WordPress 5.3.4
|_http-server-header: Apache/2.4.29 (Ubuntu)
|_http-title: blog.inlanefreight.com
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Aggressive OS guesses: Linux 2.6.32 (96%), Linux 3.2 - 4.9 (96%), Linux 2.6.32 - 3.10 (96%), Linux 3.4 - 3.10 (95%), Linux 3.1 (95%), Linux 3.2 (95%), 
AXIS 210A or 211 Network Camera (Linux 2.6.17) (94%), Synology DiskStation Manager 5.2-5644 (94%), Netgear RAIDiator 4.2.28 (94%), 
Linux 2.6.32 - 2.6.35 (94%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 1 hop

TRACEROUTE
HOP RTT      ADDRESS
1   11.91 ms 10.129.2.28

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 11.36 seconds
```

| **Scanning Options** | **Description**                                                                                    |
| -------------------- | -------------------------------------------------------------------------------------------------- |
| `10.129.2.28`        | Scans the specified target.                                                                        |
| `-p 80`              | Scans only the specified port.                                                                     |
| `-A`                 | Performs service detection, OS detection, traceroute and uses defaults scripts to scan the target. |
Using the aggressive option (`-A`) shows the web server running on the target sys is `Apache 2.4.29`, the web app is `WordPress 5.3.4`, and the title of the web page is `blog.inlanefreight.com`. Additionally, `Nmap` shows that the target OS is likely `Linux` (`96%`).
### Vulnerability Assessment
Moving on to `HTTP` port `80`, use the `vuln` category from `NSE` to see what info and vulnerabilities can be found.
```nmap-example-vuln-category
$ sudo nmap 10.129.2.28 -p 80 -sV --script vuln 

Nmap scan report for 10.129.2.28
Host is up (0.036s latency).

PORT   STATE SERVICE VERSION
80/tcp open  http    Apache httpd 2.4.29 ((Ubuntu))
| http-enum:
|   /wp-login.php: Possible admin folder
|   /readme.html: Wordpress version: 2
|   /: WordPress version: 5.3.4
|   /wp-includes/images/rss.png: Wordpress version 2.2 found.
|   /wp-includes/js/jquery/suggest.js: Wordpress version 2.5 found.
|   /wp-includes/images/blank.gif: Wordpress version 2.6 found.
|   /wp-includes/js/comment-reply.js: Wordpress version 2.7 found.
|   /wp-login.php: Wordpress login page.
|   /wp-admin/upgrade.php: Wordpress login page.
|_  /readme.html: Interesting, a readme.
|_http-server-header: Apache/2.4.29 (Ubuntu)
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
| http-wordpress-users:
| Username found: admin
|_Search stopped at ID #25. Increase the upper limit if necessary with 'http-wordpress-users.limit'
| vulners:
|   cpe:/a:apache:http_server:2.4.29:
|     	CVE-2019-0211	7.2	https://vulners.com/cve/CVE-2019-0211
|     	CVE-2018-1312	6.8	https://vulners.com/cve/CVE-2018-1312
|     	CVE-2017-15715	6.8	https://vulners.com/cve/CVE-2017-15715
<SNIP>
```

| **Scanning Options** | **Description**                                        |
| -------------------- | ------------------------------------------------------ |
| `10.129.2.28`        | Scans the specified target.                            |
| `-p 80`              | Scans only the specified port.                         |
| `-sV`                | Performs service version detection on specified ports. |
| `--script vuln`      | Uses all related scripts from specified category.      |
These scripts interact w the webserver and its web app to find out more info about their versions and check various db's to see if there are known vulns. More info about `NSE` scripts and the corresponding categories can be found at: [https://nmap.org/nsedoc/index.html](https://nmap.org/nsedoc/index.html) 
## Performance
Optimizing scanning performance is crucial when scanning an extensive network or dealing w low network bandwidth. Various options exists w/i `Nmap` to tell it how fast (`-T <0-5>`), w/ which freq (`--min-parallelism <num>`), which timeouts (`--man-rtt-timeout <time>`) the test pkts should have, how many pkts should be sent simultaneously (`--min-rate <num>`), and what number of retries (`--max-retries <num>`) for the scanned ports the targets should be scanned.
### Timeouts
When `Nmap` sends a pkt, it take some time (`Round-Trip-Time` aka `RTT`) to receive a response from the scanned port. Generally, `Nmap` starts w a high timeout (`--min-RTT-timeout`) of 100ms. The following cmd scans the whole network w/ 256 hosts, including the top 100 ports:
#### Default scan:
`$ sudo nmap 10.129.2.9/24 -F` (scans 10 hosts up in 39.44 seconds)
#### Now w/ optimized RTT:
`$ sudo nmap 10.129.2.0/24 -F --initial-rtt-timeout 50ms --max-rtt-timeout 100ms` (scans 8 hosts up in 12.29 seconds)

| **Scanning Options**         | **Description**                                       |
| ---------------------------- | ----------------------------------------------------- |
| `10.129.2.0/24`              | Scans the specified target network.                   |
| `-F`                         | Scans top 100 ports.                                  |
| `--initial-rtt-timeout 50ms` | Sets the specified time value as initial RTT timeout. |
| `--max-rtt-timeout 100ms`    | Sets the specified time value as maximum RTT timeout. |
When comparing the two scans, notice that the two hosts hosts less w/ the optimize scan, but the scan only took a quarter of the time. From this, it is possible to conclude that setting the initial RTT timeout (`--initial-rtt-timeout`) to too short a time period may cause the scan to overlook hosts.
### Max Retries
Another way to inc the scans' speed is to specify the retry rate of the sent pkts (`--max-retries`). The default value for the retry rate is `10`, so if `Nmap` does not receive a response for a port, it will not send any more pkts to the port and will be skipped.
#### Default Scan:
`$ sudo nmap 10.129.2.0/24 -F | grep "/tcp" | wc -l`
returns `23`
#### Reduced Retries
`$ sudo nmap 10.129.2.0/24 -F --max-retries 0| grep "/tcp" | wc -l`
returns `21`

| **Scanning Options** | **Description**                                                    |
| -------------------- | ------------------------------------------------------------------ |
| `10.129.2.0/24`      | Scans the specified target network.                                |
| `-F`                 | Scans top 100 ports.                                               |
| `--max-retries 0`    | Sets the number of retries that will be performed during the scan. |
Notice again that accelerating a scan can produce a negative effect of the result, which, again, means important info can be overlooked.
### Rates
It's possible to be whitelisted for the sec sys during a white-box pentest to check the sys's in the network for vulns and not only test the prot measure. If you know the network bandwitdh, you can work w/ the rate of pkts sent, which significantly speeds up `Nmap` scans. The option that sets the minimum rate (`--min-rate <num>`) for sending pkts also tells `Nmap` to simulatneously send the specified num of pkts and `Nmap` will attempt to maintain the rate accordingly.
#### Default Scan
`$ sudo nmap 10.129.2.0/24 -F -oN tnet.default`
returns 10 hosts up in 29.83 seconds
#### Optimized Scan
`$ sudo nmap 10.129.2.0/24 -F -oN tnet.minrate300 --min-rate 300`
returns 10 hosts up in 8.67 seconds

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.0/24`|Scans the specified target network.|
|`-F`|Scans top 100 ports.|
|`-oN tnet.minrate300`|Saves the results in normal formats, starting the specified file name.|
|`--min-rate 300`|Sets the minimum number of packets to be sent per second.|
#### Default Scan - Found Open Ports
`$ cat tnet.default | grep "/tcp" | wc -l` returns `23`
#### Optimized Scan - Found Open Ports
`$ cat tnet.minrate300 | grep "/tcp" | wc -l` returns `23`
### Timing
B/c such a setting cannot always be optimized manually, as in a black-box pentest, `Nmap` offers six diff timing templates (`-T <0-5>`) to use. These values (`0-5`) determine the aggressiveness for scans. This can also have negative effects if the scan is too aggressive, and sec sys's may block you due to the produced net traf. The default timing template when nothing is defined is the normal (`-T 3`) template.
- `-T 0` / `-T paranoid`
- `-T 1` / `-T sneaky`
- `-T 2` / `-T polite`
- `-T 3` / `-T normal`
- `-T 4` / `-T aggressive`
- `-T 5` / `-T insane`
These templates contain options that can also be set manually. The developers determined the values set for these templates according to their best results, making it easier to adapt scans to the corresponding net env. The exact used options w their values can be found here: [https://nmap.org/book/performance-timing-templates.html](https://nmap.org/book/performance-timing-templates.html)
#### Default Scan
`$ sudo nmap 10.129.2.0/24 -F -oN tnet.default` returns 10 hosts up in 32.44 seconds
#### Insane Scan
`$ sudo nmap 10.129.2.0/24 -F -oN tnet.T5 -T5` returns 10 hosts up in 18.07 seconds
#### Default Scan - Found Open Ports
`$ cat tnet.default | grep "/tcp" | wc -l` returns `23`
#### Insane Scan - Found Open Ports
`$ cat tnet.T5 | grep "/tcp" | wc -l` returns `23`
More info about scan performance can be foundat [https://nmap.org/book/man-performance.html](https://nmap.org/book/man-performance.html)
# Bypass Security Measures
## Firewall and IDS/IPS Evasion
`Nmap` also offers many dif ways to bypass fw rules and IDS/IPS, including the frag of pkts, the use of decoys, and others that will be discussed in this section.
### Firewalls
A fw is a sec measure against unauth connection attempts from ext networks. Every fw sec sys is based on a software component that monitors net traf b/w the fw and incoming data connections and decides how to handle the connection based on the rules that have been set. It checks whether individual net pkts are being passed, ignored, or blocked. This mechanism is designed to prevent unwanted connections that could potentially be dangerous.
### IDS/IPS
Like the fw, the intrusion detection system (`IDS`) and the intrusion prevention system (`IPS`) are also software based components. `IDS` scans the network for potential atks, analyzes them, and reports any detected atks. `IPS` complements `IDS` by taking specific defensive measures if a potential atk was been detected. The analysis of such atks is based on pattern matching and sigs. If specific patterns are detected, such as a service detection scan, `IPS` may prevent the pending connection attempts.
### Determine Firewalls and Their Rules
It has already been shown here that there are several reasons why a port returns as filtered. In most cases, fw's have certain rules set to handle specific connections. The pkts can either be `dropped`, or `rejected`. The `dropped` pkts are ignored, and no response is returned from the host.

This is dif for `rejected` pkts that are returned w an `RST` flag. These pkts contain diff types of `ICMP` err codes or contain nothing at all.

Such errors can be:
* Net Unreachable
* Net Prohibited
* Host Unreachable
* Host Prohibited
* Port Unreachable
* Port Prohibited (lol incorrectly spelled 'Proto' on HtB)
`Nmap`'s `TCP ACK` scan (`-sA`) method is much harder to filter for fw's and IDS/IPS's than regular SYN (`-sS`) or Connect scans (`-sT`) b/c they only send a `TCP` pkt w only the `ACK` flag. When a port is closed or open, the host must respond w/ an `RST` flag. Unlike outgoing connections, all connection attempts (w the `SYN` flag) from ext net's are usually blocked by fw's. However, the pkts w the `ACK` flag are often passed by the fw b/c the fw cannot determine whether the connection was first est from the ext net or the int net.
```syn-scan
$ sudo nmap 10.129.2.28 -p 21,22,25 -sS -Pn -n --disable-arp-ping --packet-trace

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-21 14:56 CEST
SENT (0.0278s) TCP 10.10.14.2:57347 > 10.129.2.28:22 S ttl=53 id=22412 iplen=44  seq=4092255222 win=1024 <mss 1460>
SENT (0.0278s) TCP 10.10.14.2:57347 > 10.129.2.28:25 S ttl=50 id=62291 iplen=44  seq=4092255222 win=1024 <mss 1460>
SENT (0.0278s) TCP 10.10.14.2:57347 > 10.129.2.28:21 S ttl=58 id=38696 iplen=44  seq=4092255222 win=1024 <mss 1460>
RCVD (0.0329s) ICMP [10.129.2.28 > 10.10.14.2 Port 21 unreachable (type=3/code=3) ] IP [ttl=64 id=40884 iplen=72 ]
RCVD (0.0341s) TCP 10.129.2.28:22 > 10.10.14.2:57347 SA ttl=64 id=0 iplen=44  seq=1153454414 win=64240 <mss 1460>
RCVD (1.0386s) TCP 10.129.2.28:22 > 10.10.14.2:57347 SA ttl=64 id=0 iplen=44  seq=1153454414 win=64240 <mss 1460>
SENT (1.1366s) TCP 10.10.14.2:57348 > 10.129.2.28:25 S ttl=44 id=6796 iplen=44  seq=4092320759 win=1024 <mss 1460>
Nmap scan report for 10.129.2.28
Host is up (0.0053s latency).

PORT   STATE    SERVICE
21/tcp filtered ftp
22/tcp open     ssh
25/tcp filtered smtp
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.07 seconds
```
```ack-scan
$ sudo nmap 10.129.2.28 -p 21,22,25 -sA -Pn -n --disable-arp-ping --packet-trace

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-21 14:57 CEST
SENT (0.0422s) TCP 10.10.14.2:49343 > 10.129.2.28:21 A ttl=49 id=12381 iplen=40  seq=0 win=1024
SENT (0.0423s) TCP 10.10.14.2:49343 > 10.129.2.28:22 A ttl=41 id=5146 iplen=40  seq=0 win=1024
SENT (0.0423s) TCP 10.10.14.2:49343 > 10.129.2.28:25 A ttl=49 id=5800 iplen=40  seq=0 win=1024
RCVD (0.1252s) ICMP [10.129.2.28 > 10.10.14.2 Port 21 unreachable (type=3/code=3) ] IP [ttl=64 id=55628 iplen=68 ]
RCVD (0.1268s) TCP 10.129.2.28:22 > 10.10.14.2:49343 R ttl=64 id=0 iplen=40  seq=1660784500 win=0
SENT (1.3837s) TCP 10.10.14.2:49344 > 10.129.2.28:25 A ttl=59 id=21915 iplen=40  seq=0 win=1024
Nmap scan report for 10.129.2.28
Host is up (0.083s latency).

PORT   STATE      SERVICE
21/tcp filtered   ftp
22/tcp unfiltered ssh
25/tcp filtered   smtp
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.15 seconds
```

| **Scanning Options** | **Description**                       |
| -------------------- | ------------------------------------- |
| `10.129.2.28`        | Scans the specified target.           |
| `-p 21,22,25`        | Scans only the specified ports.       |
| `-sS`                | Performs SYN scan on specified ports. |
| `-sA`                | Performs ACK scan on specified ports. |
| `-Pn`                | Disables ICMP Echo requests.          |
| `-n`                 | Disables DNS resolution.              |
| `--disable-arp-ping` | Disables ARP ping.                    |
| `--packet-trace`     | Shows all packets sent and received.  |
Paying attention to the `RCVD` pkts and its flag received from the target, w the `SYN` scan (`-sS`), the target attempts to est the `TCP` connection by sending a pkt back w the `SYN-ACK` (`SA`) flags set and w the `ACK` scan (`-sA`) the target returns the `RST` (`R`) flag b/c `TCP` port `22` is open. For the `TCP` port `25`, no pkts are received, indicating that the pkts will be dropped.
### Detect IDS/IPS
Unlike fw's and their rules, detecting IDS/IPS's is much more dif b/c these are passive traf monitoring sys's. `IDS`'s examine all connections b/w hosts. If the `IDS` finds pkts containing the defined contents or specifications, the admin is notified and takes appropriate action in the worst case.

`IPS`'s take measures config'd by the admin independently to prevent potential atks automatically. It is essential to know that `IDS` and `IPS` are dif apps and the `ISP` serves as a compliment to `IDS`.

Several virtual private servers (`VPS`) w diff IP addrs are recommended to determine whether such sys's are on the target net during a pentest. If the admin detects such a potential atk on the target net, the first step is to block the IP addr from which the potential atk comes. As a result, the pentester will no longer be able to access the net using that IP addr, and their Internet Service Provider (`ISP`) will be contacted and blocked from all access to the Internet.
* `IDS`'s alone are usually there to help admins detect potential atks on their network. They can then decide how to handle such connections e.g. by triggering certain sec measures from an admin by aggressively scanning a single port and its service. Based on whether specific sec measure are taken is how to detect if the network has some monitoring apps or not.
* One method for `IPS` detection includes scanning a network from a single host (`VPS`). If at any time this host is blocked and has no access to the target network, it is b/c the admin has taken some sec measures. In this case, you would continue the pentest w/ another `VPS`.
Consequently, if `IDS`/`IPS` is detected, proceed w/ quieter scans and, in the best case, disguise all interactions w the target network and its services.
### Decoys
There are cases in which admins block specific subnets from diff regions in principle. This prevents any access to the target net. Another example is when `IPS` should block you. For the reason, the Decoy scanning method (`-D`)  is the right choice. W/ this method, `Nmap` generates various random IP addrs inserted into the IP header to disguise the origin of the pkt sent. W/ this method, you can generate random (`RND`) and specific number (e.g. `5`) of IP addrs separated by a colon (`:`). The real IP addr is then randomly placed b/w the generated IP addrs.

In the following example, your real IP addr is placed in the second position. Another crucial point is that the decoys must be alive. Otherwise, the service on the target may be unreachable due to `SYN`-flooding sec mechanisms
```scan-by-using-decoys
$ sudo nmap 10.129.2.28 -p 80 -sS -Pn -n --disable-arp-ping --packet-trace -D RND:5

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-21 16:14 CEST
SENT (0.0378s) TCP 102.52.161.59:59289 > 10.129.2.28:80 S ttl=42 id=29822 iplen=44  seq=3687542010 win=1024 <mss 1460>
SENT (0.0378s) TCP 10.10.14.2:59289 > 10.129.2.28:80 S ttl=59 id=29822 iplen=44  seq=3687542010 win=1024 <mss 1460>
SENT (0.0379s) TCP 210.120.38.29:59289 > 10.129.2.28:80 S ttl=37 id=29822 iplen=44  seq=3687542010 win=1024 <mss 1460>
SENT (0.0379s) TCP 191.6.64.171:59289 > 10.129.2.28:80 S ttl=38 id=29822 iplen=44  seq=3687542010 win=1024 <mss 1460>
SENT (0.0379s) TCP 184.178.194.209:59289 > 10.129.2.28:80 S ttl=39 id=29822 iplen=44  seq=3687542010 win=1024 <mss 1460>
SENT (0.0379s) TCP 43.21.121.33:59289 > 10.129.2.28:80 S ttl=55 id=29822 iplen=44  seq=3687542010 win=1024 <mss 1460>
RCVD (0.1370s) TCP 10.129.2.28:80 > 10.10.14.2:59289 SA ttl=64 id=0 iplen=44  seq=4056111701 win=64240 <mss 1460>
Nmap scan report for 10.129.2.28
Host is up (0.099s latency).

PORT   STATE SERVICE
80/tcp open  http
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.15 seconds
```

| **Scanning Options** | **Description**                                                                            |
| -------------------- | ------------------------------------------------------------------------------------------ |
| `10.129.2.28`        | Scans the specified target.                                                                |
| `-p 80`              | Scans only the specified ports.                                                            |
| `-sS`                | Performs SYN scan on specified ports.                                                      |
| `-Pn`                | Disables ICMP Echo requests.                                                               |
| `-n`                 | Disables DNS resolution.                                                                   |
| `--disable-arp-ping` | Disables ARP ping.                                                                         |
| `--packet-trace`     | Shows all packets sent and received.                                                       |
| `-D RND:5`           | Generates five random IP addresses that indicates the source IP the connection comes from. |
The spoofed pkts are often filtered out by ISPs and routers, even though they come from the same net range. Therefore, you can also specify your VPS servers' IP addrs and use them in combo w "`IP ID`" manipulation in the IP headers to scan the target.

Another scenario would be that only individual subnets would not have access to the server's specific services. So you can also manually specify the source IP addr (`-S`) to test if you get better results w this one. Decoys can be used for `SYN`, `ACK,` `ICMP` scans, and OS detection scans.

The following cmd determines which OS it is most likely to be:
```testing-firewall-rule
$ sudo nmap 10.129.2.28 -n -Pn -p445 -O

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-22 01:23 CEST
Nmap scan report for 10.129.2.28
Host is up (0.032s latency).

PORT    STATE    SERVICE
445/tcp filtered microsoft-ds
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 3.14 seconds
```
```scan-using-dif-source-ip
$ sudo nmap 10.129.2.28 -n -Pn -p 445 -O -S 10.129.2.200 -e tun0

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-22 01:16 CEST
Nmap scan report for 10.129.2.28
Host is up (0.010s latency).

PORT    STATE SERVICE
445/tcp open  microsoft-ds
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Aggressive OS guesses: Linux 2.6.32 (96%), Linux 3.2 - 4.9 (96%), Linux 2.6.32 - 3.10 (96%), Linux 3.4 - 3.10 (95%), Linux 3.1 (95%), Linux 3.2 (95%), AXIS 210A or 211 Network Camera (Linux 2.6.17) (94%), Synology DiskStation Manager 5.2-5644 (94%), Linux 2.6.32 - 2.6.35 (94%), Linux 2.6.32 - 3.5 (94%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 1 hop

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 4.11 seconds
```

|**Scanning Options**|**Description**|
|---|---|
|`10.129.2.28`|Scans the specified target.|
|`-n`|Disables DNS resolution.|
|`-Pn`|Disables ICMP Echo requests.|
|`-p 445`|Scans only the specified ports.|
|`-O`|Performs operation system detection scan.|
|`-S`|Scans the target by using different source IP address.|
|`10.129.2.200`|Specifies the source IP address.|
|`-e tun0`|Sends all requests through the specified interface.|
### DNS Proxying
By default, `Nmap` performs a reverse DNS resolution unless otherwise specified to find more important info about a target. These DNS queries are made o/ the `UDP port 53` and passed in most cases b/c the given web server is supposed to be found and visited. The `TCP port 53` was previously only used for the so-called "`Zone transfers`" b/w the DNS server or data transfer larger than 512 bytes. More and more, this is changing due to `IPv6` and `DNSSEC` expansions. These changes cause many DNS requests to be made via `TCP port 53`.

However, `Nmap` still gives a way to specify DNS servers manually (`--dns-server <ns>,<ns>`). This method could be fundamental if you are in a demilitarized zone (`DMZ`). The co's DNS servers are usually more trusted than those from the Internet e.g. they could be used to interact w/ the hosts of the internal network. Alternatively, you can use `TCP port 53` as a source port (`--source-port`) for scans. If the admin uses the fw to ctrl this port and does not filter IDS/IPS properly, any sent TCP pkts will be trusted and passed through.
```syn-scan-of-a-filtered-port
$ sudo nmap 10.129.2.28 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-21 22:50 CEST
SENT (0.0417s) TCP 10.10.14.2:33436 > 10.129.2.28:50000 S ttl=41 id=21939 iplen=44  seq=736533153 win=1024 <mss 1460>
SENT (1.0481s) TCP 10.10.14.2:33437 > 10.129.2.28:50000 S ttl=46 id=6446 iplen=44  seq=736598688 win=1024 <mss 1460>
Nmap scan report for 10.129.2.28
Host is up.

PORT      STATE    SERVICE
50000/tcp filtered ibm-db2

Nmap done: 1 IP address (1 host up) scanned in 2.06 seconds
```
```syn-scan-from-dns-port
$ sudo nmap 10.129.2.28 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace --source-port 53

SENT (0.0482s) TCP 10.10.14.2:53 > 10.129.2.28:50000 S ttl=58 id=27470 iplen=44  seq=4003923435 win=1024 <mss 1460>
RCVD (0.0608s) TCP 10.129.2.28:50000 > 10.10.14.2:53 SA ttl=64 id=0 iplen=44  seq=540635485 win=64240 <mss 1460>
Nmap scan report for 10.129.2.28
Host is up (0.013s latency).

PORT      STATE SERVICE
50000/tcp open  ibm-db2
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 0.08 seconds
```

| **Scanning Options** | **Description**                                |
| -------------------- | ---------------------------------------------- |
| `10.129.2.28`        | Scans the specified target.                    |
| `-p 50000`           | Scans only the specified ports.                |
| `-sS`                | Performs SYN scan on specified ports.          |
| `-Pn`                | Disables ICMP Echo requests.                   |
| `-n`                 | Disables DNS resolution.                       |
| `--disable-arp-ping` | Disables ARP ping.                             |
| `--packet-trace`     | Shows all packets sent and received.           |
| `--source-port 53`   | Performs the scans from specified source port. |
After finging out the the fw accepts `TCP port 53`, it is very likely that IDS/IPS filters might also be config'd much weaker than others. This can be tested by trying to connect to this port by using `Netcat`:
```connect-to-filtered-port
$ ncat -nv --source-port 53 10.129.2.28 50000

Ncat: Version 7.80 ( https://nmap.org/ncat )
Ncat: Connected to 10.129.2.28:50000.
220 ProFTPd
```
### Firewall and IDS/IPS Evasion Labs
The next three sections focus on practicing where to scan targets. Fw rules and IDS/IPS prot the systems in the three scenarios, so it is imperative to use these techniques to bypass the fw rules as quietly as possible, or be blocked by IPS.
## Easy Lab
A company hires you to test their IT security defenses, including their `IDS` and `IPS` systems. Your client wants to increase their IT sec and will, therefore, make specific improvements to their `IDS/IPS` systems after each successful test. You do not know, however, according to which guidelines these changes will be made. Your goal is to find out specific info from the given situations.

You are only ever provided w a machine protected by `IDS/IPS` systems and can be tested. For learning purposes and to get a feel for how `IDS/IPS` can behave, you have access to a status web page at:
`http://<target>/status.php`
This page shows you the number of alerts. You know that if you receive a specific amount of alerts, you will be `banned`. Therefore you have to test the target system as `quietly` as possible.
## Medium Lab
After conducting the first test and submitting the results to the client, the admins made some changes and improvements to the firewall and `IDS/IPS`. Additionally, you overhear that the admins were not satisfied w their previous configs during the meeting, and they could see that the network traffic could be filtered more strictly.
## Hard Lab
W the help of the second test, the client was able to gain new insights and sent on of its admins to a `training course` for `IDS/IPS`. According to the client, the training would last `one week`. Now the admin has taken all the necessary precautions and wants this tested again b/c specific services must be changed, and the comm for the provided software had to be modded.