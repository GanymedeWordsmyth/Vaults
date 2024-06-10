# Introduction
## Networking Overview
A network enables two comp to comm w each other. There is a wide array of `topologies` (mesh/tree/star), `mediums` (ethernet/fiber/coax/wireless), and `protocols` (TCP/UDP/IPX) that can be used to facilitate the network. It is important, as sec professionals, to understand networking as when the network fails, the err may be silent.

Setting up a large, flat network is not difficult, and it can be a reliable network. However, a flat network is like building a house on a land plot and considering it sec b/c it has a lock on the door. By creating lots of smaller networks and having them communicate, defense layers can be added. Pivoting around a network is also not difficult, but doing it quickly and silently is tough and will slow down atkrs.
#### Example 1
Building smaller networks and putting Access Control Lists around them is like putting a fence around the property's border that creates specific entry and exit points. Yes, an atkr *could* jump o/ the fence, but this looks sus and is not common, allowing it to be quickly detected as malicious activity. *Why is the printer network talking to the servers o/ HTTP?*
#### Example 2
Taking the time to map out and doc each network's purpose is like placing lights around the property, making sure all activity can be seen. *Why is the printer network talking to the internet at all?*
#### Example 3
Having bushes around windows is a deterrent to people attempting to open the window. Just like IDS's like Suricata or Snort are a deterrent to running network scans. *Why did a port scan originate from the printer network?*

These examples may sound silly, and it is common sense to block a printer from doing all of the above. However, if the printer is on a "flat `/24` network" and gets a `DHCP` addr, it can be challenging to place these types of restrictions on them.

### Basic Information
![[Pasted image 20240527152608.png]]
The entire internet is based on many subdivided networks, marked in the pic as "`Home Network`" and "`Comany Network`". `Networking` can be imagined as the delivery of mail or pkgs sent by one comp and received by the other.

In a scenario where it is desirable to visit a co's website from the "`Home Network`," data is exchanged w the co's website located in their "`Company Network`." As w sending mail (or in this case pkts), the addr is where the pkts should go. The website addr, or `Uniform Resource Locator` (`URL`) which is enterred in the browser is also called the `Fully Qualified Domain Name` (`FQDN`).

The difference between `URL`s and `FQDN`s is that:

- an `FQDN` (`www.hackthebox.eu`) only specifies the address of the "building" and
- an `URL` (`https://www.hackthebox.eu/example?floor=2&office=dev&employee=17`) also specifies the "`floor`," "`office`," "`mailbox`" and the corresponding "`employee`" for whom the package is intended.

There are more nuanced differences, but it's best to start simply. These differences will be expanded upon later in this module.

It's important to note that the addr is known, but not the exact geographical location of that addr, which is akin to sending a letter via the post office. You know and write the addr, but it is the post office that determines where that is and delivers the letter accordingly by way of first sending it to the main post processing center. The processing center, in this case, represents the `Internet Service Provider` or `ISP` and your local post office would be your `router` which is utilized to connect to the `Internet` in networking.

As soon as a pkt is sent through the your local post office (`router`), the pkt is forwarded to the main post office (`ISP`), which looks in the address register/phonebook (`Domain Name Service` or `DNS`) where this addr is located and returns the corresponding geographical coordinates (`IP address`). Then, once the addr's exact location is located, the pkt is sent directly there by a flight (`cables`) via the main post office (`ISP`).

After the web server receives the pkt w the request of what their website looks like, the webserver sends back the pkt w the data for the presentation of the website via the post office (`router`) of the "`Company Network`" to the specified return addr (`your IP addr`) in the exact reverse steps.
#### Extra Points

In that diagram, I would hope the company network shown consists of five separate networks!

1. The Web Server should be in a DMZ (Demilitarized Zone) because clients on the internet can initiate communications with the website, making it more likely to become compromised. Placing it in a separate network allows the administrators to put networking protections between the web server and other devices.
    
2. Workstations should be on their own network, and in a perfect world, each workstation should have a Host-Based Firewall rule preventing it from talking to other workstations. If a Workstation is on the same network as a Server, networking attacks like `spoofing` or `man in the middle` become much more of an issue.
    
3. The Switch and Router should be on an "Administration Network." This prevents workstations from snooping in on any communication between these devices. I have often performed a Penetration Test and saw `OSPF` (Open Shortest Path First) advertisements. Since the router did not have a `trusted network`, anyone on the internal network could have sent a malicious advertisement and performed a `man in the middle` attack against any network.
    
4. IP Phones should be on their own network. Security-wise this is to prevent computers from being able to eavesdrop on communication. In addition to security, phones are unique in the sense that latency/lag is significant. Placing them on their own network can allow network administrators to prioritize their traffic to prevent high latency more easily.
    
5. Printers should be on their own network. This may sound weird, but it is next to impossible to secure a printer. Due to how Windows works, if a printer tells a computer authentication is required during a print job, that computer will attempt an `NTLMv2` authentication, which can lead to passwords being stolen. Additionally, these devices are great for persistence and, in general, have tons of sensitive information sent to them.
#### Fun Story

During COVID, I was tasked to perform a `Physical Penetration Test` across state lines, and my state was under a `stay at home` order. The company I was testing had minimal staff in the office. I decided to purchase an expensive printer and exploited it to put a reverse shell in it, so when it connected to the network, it would send me a shell (remote access). Then I shipped the printer to the company and sent a phishing email thanking the staff for coming in and explaining that the printer should allow them to print or scan things more quickly if they want to bring some stuff home to WFH for a few days. The printer was hooked up almost instantly, and their domain administrator's computer was kind enough to send the printer his credentials!

If the client had designed a secure network, this attack probably would not have been possible for many reasons:

- Printer should not have been able to talk to the internet
- Workstation should not have been able to communicate to the printer over port 445
- Printer should not be able to initiate connections to workstations. In some cases, printer/scanner combinations should be able to communicate to a mail server to email scanned documents.
# Networking Structure
## Network Types
Each network is structured differently and can be set up individually. For this reason, so-called `types` and `topologies` have been dev'd that can be used to categorize these networks. When reading about all the types of networks, it can be a bit of information overload as some net types include geographical range. It is rare to hear some of the terminologies in practice, so this section will be broken up into `Common Terms` and `Book Terms`. Book terms are good to know, as there has been a single doc'd case of an email server failing to deliver emails longer than 500 miles but don't be expected to be able to recite them on demand unless studying for a networking exam.
### Common Terminology

|**Network Type**|**Definition**|
|---|---|
|Wide Area Network (WAN)|Internet|
|Local Area Network (LAN)|Internal Networks (Ex: Home or Office)|
|Wireless Local Area Network (WLAN)|Internal Networks accessible over Wi-Fi|
|Virtual Private Network (VPN)|Connects multiple network sites to one `LAN`|
#### WAN
The `Wide Area Network` (`WAN`) is commonly referred to as `The Internet`. When dealing w networking equipment, it's common to have a WAN addr and a LAN addr. The WAN is the addr that is generally accessed by the Internet. That being said, it is not inclusive to the Internet; a WAN is just a large num of LANs joined together. Many large co's or gov agencies will have an "Internal WAN" (aka Intranet, Airgap Network, etc.). Generally speaking, the primary way to ID if the network is a WAN is to use a WAN Specific routing protocol, such as BGP, and if the IP Schema in use is not w/i RFC 1918 (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16).
#### LAN/WLAN
`Local Area Networks` (`LANs`) and `Wireless Local Area Networks` (`WLANs`) will typically assign IP Addrs designated for local use (RFC 1918, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16). In some cases, like some colleges or hotels, you may be assigned a routable (internet) IP addr from joining their LAN, but that is much less common. There's nothing different b/w a LAN or WLAN, other than WLANs introduce the ability to transmit data w/o cables. It is mainly a security designation.
#### VPN
There are three types of `Virtual Private Networks` (`VPNs`), all of which have the same goal of making a user feel as if they were plugged into a different network:
##### Site-to-Site VPN
Both the client and server are Network Devices, typically either `Routers` or `Firewalls`, and share entire network ranges. This is most commonly used to join company networks together o/ the Internet, allowing multiple locations to comm o/ the Internet as if they were local.
##### Remote Access VPN
This involves the client's comp creating a virtual interface that behaves as if it is on a client's network. HtB utilizes `OpenVPN`, which makes a `TUN Adapter` allowing access to labs. When analyzing these VPNs, an important piece to consider is the routing table that is created when joining the VPN. If the VPN only creates routes for specific networks (e.g. 10.10.10.0/24), this is called a `Split-Tunnel VPN`, meaning the Internet connection is not going out of the VPN. This is great for HtB b/c it provides access to the Lab w/o the privacy concern of monitoring your internet connection. However, for a company, `split-tunnel` VPNs are typically not ideal b/c if the machine is infected w malware, network-based detection methods will most likely not work as the traffic goes out to Internet.
##### SSL VPN
This is essentially a VPN that is done w/i the web browser and is becoming inc common as web browsers are becoming capable of doing anything. Typically these will stream apps or entire desktop sessions to your web browser, e.g. HackTheBox Pwnbox.
### Book Terms

|Network Type|Definition|
|---|---|
|Global Area Network (GAN)|Global network (the Internet)|
|Metropolitan Area Network (MAN)|Regional network (multiple LANs)|
|Wireless Personal Area Network (WPAN)|Personal network (Bluetooth)|
#### GAN
A worldwide network, such as the `Internet`, is known as a `Global Area Network` (`GAN`). However, the Internet is not the only computer network of this kind. Internationally active companies also maintain isolated networks that span several `WANs` and connect company computers worldwide. `GANs` use the glass fiber infrastructure of wide-area networks and interconnect them by international undersea cables or satellite transmission.
#### MAN
`Metropolitan Area Network` (`MAN`) is a broadband telecommunications network that connects several `LANs` in geographical proximity. As a rule, these are individual branches of a company connected to a `MAN` via leased lines. High-performance routers and high-performance connections based on glass fibers are used, which enable a significantly higher data throughput than the Internet. The transmission speed b/w two remote nodes is comparable to communication w/i a `LAN`.
Internationally operating network operators provide the infrastructure for `MANs`. Cities wired as `Metropolitan Area Networks` can be integrated supra-regionally in `WANs` and internationally in `GANs`.
#### PAN/WPAN
Modern end devices, such as smartphones, tablets, laptops, or desktop computers, can be connected ad hoc to form a network to enable data exchange. This can be done by cable in the form of a `Personal Area Network` (`PAN`).
The wireless variant, `Wireless Personal Area Network` (`WPAN`), is based on Bluetooth or Wireless USB technologies. A `WPAN` that is est'd via Bluetooth is called `Piconet`. `PANs` and `WPANs` usually only extend a few meters and are therefore note suitable for connecting devices in separate rooms or even buildings.
In the context of the `Internet of Things` (`IoT`), `WPANs` are used to communicate ctrl and monitor apps w low data rates. Protocols such as Insteon, Z-Wave, and ZigBee were explicitly designed for smart homes and home automation.
## Networking Topologies
A `network topology` is a typical arrangement and `physical` or `logical` connection of devices in a network. Computers are `hosts`, such as `clients` and `servers`, that actively use the network. They also include `network components` such as `switches`, `bridges`, and `routers`, which will be discussed in more details later in this module, which have a distribution function and ensure that all network hosts can est a logical connection w each other. The network topology determines the components to be used and the access methods to the transmission media.
The `transmission medium layout` used to connect devices is the `physical topology` of the network. For conductive or glass fiber media, this refers to the cabling pan, the positions of the `nodes`, and the connections b/w the nodes and the cabling. In contrast, the `logical topology` is how the signals act on the network media or how the data will be transmitted across the network from one device to the devices' physical connection.
The entire network topology can be divided into three areas:
1. Connections

|`Wired connections`|`Wireless connections`|
|---|---|
|Coaxial cabling|Wi-Fi|
|Glass fiber cabling|Cellular|
|Twisted-pair cabling|Satellite|
|and others|and others|
2. Nodes - Network Interface Controllers (NICs)
	- Repeaters
	- Hubs
	- Bridges
	- Switches
	- Router/Modem
	- Gateways
	- Firewalls
Network nodes are the `transmission medium's connection points` to transmitters and receivers of electrical, optical, or radio signals in the medium. A node may be connected to a computer, but certain types may have only one microcontroller on a node or may have no programmable device at all.
3. Classifications
A topology can be imagined as a virtual form or `structure of a network`. This form does not necessarily correspond to the actual physical arrangement of the devices in the network. Therefore, these topologies can be either `physical` or `logical`, e.g. the computers on a `LAN` may be arranged in a circle in a bedroom, but it is very unlikely to have an actual ring topology.

Network topologies are divided into the following either basic types:
1. Point-to-Point
2. Bus
3. Star
4. Ring
5. Mesh
6. Tree
7. Hybrid
8. Daisey Chain
More complex networks can be built as hybrids of two or more of the basic topologies mentioned above.
### Point-to-Point
The simplest network topology w a dedicated connection b/w two hosts is the `point-to-point` topology. In this topology, a direct and straightforward physical link exists only b/w `two hosts`. These two devices can use these connections for mutual comms.
`Point-to-point` topologies are the basic model of traditions telepohony and must no be confused w `Peer-to-Peer` (`P2P`) architecture.
![[Pasted image 20240527205447.png]]
### Bus
All hosts are connected via a transmission medium in the bus topology. Every host has access to the transmission medium and the signals that are transmitted o/ it. There is no central network component that ctrls the processes on it. The `coaxial cable` is an example transmission medium for this.
Since the medium is shared w all the others, only `one host can send`, and all the others can only receive and eval the data and see whether it is intended for itself.![[Pasted image 20240527205750.png]]
### Star
The star topology is a network component that maintains a connection to all hosts. Each host is connected to the `central network component` via a separate link, usually a router, a hub, or a switch. These handle the `forwarding function` for the data pkts. To do this, the data pkts are received and forwarded to the destination. The data traffic on the central network component can be very high since all data and connections go through it.![[Pasted image 20240527210034.png]]
### Ring
The `physical` ring topology is such that each host or node is connected to the ring w two cables:
- One for the `incoming` signals
- The other for the `outgoing` signals
This means that one cable arrives at each host and one cable leaves. The ring topology typically does not req an active network component. The ctrl and access to the transmission medium are regulated by a protocol to which all stations adhere.
A `logical` ring topology is based on a physical star topology, where a distributor at the node simulates the ring by forwarding from one port to the next.
The info is transmitted in a predetermined transmission direction. Typically, the transmission medium is accessed sequentially from station to station using a retrieval system from the central station or a `token`. A token is a bit pattern that continually passes through a ring network in one direction, which works according to the `claim token process`.![[Pasted image 20240527210623.png]]
### Mesh
Many nodes decide about the connections on a `physical` level and the routing on a `logical` level in meshed networks. Therefore, meshed structures have no fixed topology. There are two basic structures from the basic concept: the `fully meshed` and the `partially meshed` structure.
Each host is connected to every other host in the network in a `fully meshed structure`. This means that the hosts are meshed w each other. This technique is primarily used in `WAN` or `MAN` to ensure high reliability and bandwidth.
In this setup, important network nodes, such as routers, could be networked together. If one router fails, the others can continue to work w/o problems, and the network can absorb the failure due to the many connections.
Each node of a fully meshed topology has the same routing functions and knows the neighboring nodes it can communicate w proximity to the network gateway and traffic loads.
In the `partially meshed structure`, the endpoints are connected by only one connection. In this type of network topology, specific nodes are connected to exactly one other node, and some other nodes are connected to two or more other nodes w a point-to-point connection.![[Pasted image 20240527211354.png]]
### Tree
The tree topology is an extended star topology that more extensive local networks have in this structure. This is esp useful when several topologies are combined. This topology is often used, for example, in larger company buildings.
There are both logical tree structures according to the `spanning tree` and physical ones. Modular modern networks, based on structured cabling w a hub hierarchy, also have atree structure. Tree topologies are also used for `broadband networks` and `city networks` (`MANs`).![[Pasted image 20240527211656.png]]
### Hybrid
Hybrid networks combine two or more topologies so that the resulting network does not present any std topologies e.g. a tree network can represent a hybrid topology in which star networks are connected via interconnected bus networks. However, a tree network that is linked to another tree network is still topologically a tree network. A hybrid topology is always created when two `different` basic network topologies are interconnected.
![[Pasted image 20240527212000.png]]
### Daisy Chain
In the daisy chain topology, multiple hosts are connected by placing a cable from one node to another.
Since this creates a chain of connections, it is also known as a daisy-chain configuration in which multiple hardware components are connected in a series. This type of networking is often found in automation technology (`CAN`).
Daisy chaining is based on the physical arrangement of the nodes, in contrast to token procedures, which are structural but can be made independent of the physical layout. The signal is sent to and from a component via its previous nodes to the computer system.![[Pasted image 20240527212330.png]]
## Proxies
Many people have different opinions on what a proxy is:
- Security Professionals jump to `HTTP Proxies` (BurpSuite) or pivoting with a `SOCKS/SSH Proxy` (`Chisel`, `ptunnel`, `sshuttle`).
- Web Developers use proxies like Cloudflare or ModSecurity to block malicious traffic.
- Average people may think a proxy is used to obfuscate your location and access another country's Netflix catalog. (This is actually a VPN)
- Law Enforcement often attributes proxies to illegal activity.
Not all of the above examples are correct, however. A proxy is when a device or service sits in the middle of a connection and acts as a mediator. The `mediator` is the critical piece of info b/c it means the device in the middle must be able to inspect the contents of the traffic. W/o the ability to be a `mediator`, the device is technically a `gateway`, not a proxy.
Remember: proxies will almost always operate at Layer 7 of the OSI Model. There are many types of proxy services, but the key ones are:
- `Dedicated Proxy` / `Forward Proxy`
- `Reverse Proxy`
- `Transparent Proxy`