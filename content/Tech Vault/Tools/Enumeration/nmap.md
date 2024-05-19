*Enumeration, enumeration, enumeration. If you can't figure something out, it's because you haven't enumerated enough.*

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
# Introduction to Nmap
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
# Host Discovery
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
## Scan IP List
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
### Scan Multiple IPs
It's also common to only need to scan a small part of a network. An alternative to the method used last time is to specify multiple IP addrs:
`$ sudo nmap -sn -oA tnet 10.129.2.18 10.129.2.19 10.129.2.20 | grep for | cut -d" " -f5`
Fun note: if any IP addrs are next to each other, define the range in the respective octet:
`$ sudo nmap -sn -oA tnet 10.129.2.18-20 | grep for | cut -d" " -f5`
### Scan Single IP
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
# Host and Port Scanning
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
## Discovering Open TCP Ports
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
### Request

|**Message**|**Description**|
|---|---|
|`SENT (0.0429s)`|Indicates the SENT operation of Nmap, which sends a packet to the target.|
|`TCP`|Shows the protocol that is being used to interact with the target port.|
|`10.10.14.2:63090 >`|Represents our IPv4 address and the source port, which will be used by Nmap to send the packets.|
|`10.129.2.28:21`|Shows the target IPv4 address and the target port.|
|`S`|SYN flag of the sent TCP packet.|
|`ttl=56 id=57322 iplen=44 seq=1699105818 win=1024 mss 1460`|Additional TCP Header parameters.|
### Response

|**Message**|**Description**|
|---|---|
|`RCVD (0.0573s)`|Indicates a received packet from the target.|
|`TCP`|Shows the protocol that is being used.|
|`10.129.2.28:21 >`|Represents targets IPv4 address and the source port, which will be used to reply.|
|`10.10.14.2:63090`|Shows our IPv4 address and the port that will be replied to.|
|`RA`|RST and ACK flags of the sent TCP packet.|
|`ttl=64 id=0 iplen=40 seq=0 win=0`|Additional TCP Header parameters.|
### Connect Scan
 The Nmap [TCP Connect Scan](https://nmap.org/book/scan-methods-connect-scan.html) (`-sT`) uses the TCP three-way handshake to determine if a specific port on a target host is open or closed. The scan sends a `SYN` packet to the targget port and waits for a response. It is considered open if the target port responds w a `SYN-ACK` packet and closed it if responds w an `RST` packet.

The `Connect` scan is useful b/c it is the most accurate way to determine the state of a port, and is also the most stealthy. Unlike other types of scans, sych as the `SYN` scan, the `Connect` scan does not leave any unfinished connections or unsent packets on the target host, which makes it less likely to be detected by the target's IDS/IPS. It is useful in mapping the network w/o disturbing the services running behind it, thus causing minimal impact and sometimes considered a more polite scan method.

It is also useful when the target host has a personal firewall that drops incoming packets but allows outgoing packets. In this case, a `Connect` scan can bypass the firewall and accurately determine the target ports.
>[!Note] Important Note
>The `Connect` scan is slower than other types of scans b/c it req's the scanner to wait for a response from the target after each packet it sends, which could take some time if the target is busy or unresponsive.
## Filtered Ports
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
## Discovering Open UDP Ports
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
# Saving the Results
While running various scans, it is best practice to save the results (side note, I answered one of the exercise questions by looking at a previous scan), which can be used later to examine the diffs b/w the diff scanning methods used. `Nmap` can save the results in 1 of 3 formats:
- Normal output (`-oN`) w the `.nmap` file extension
- Grepable output (`-oG`) w the `.gnmap` file extension
- XML output (`-oX`) w the `.xml` file extension
To save the results in all formats, use the "`-oA`" option. If no full path is given, the results will be stored in the current dir.
More information about the output formats can be found at: [https://nmap.org/book/output.html](https://nmap.org/book/output.html)
#### Style sheets
Use the following cmd to use the XML output to easily create HTML reports that are easy to read (even for non-technical people) and very useful for documentation:
`$ xsltproc <result>.xml -o <name>.html`