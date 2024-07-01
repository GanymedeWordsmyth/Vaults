# Introduction
`Web Reconnaissance` is the foundation of a thorough sec assessment which involves systematically and meticulously collecting info about a target website or web app. This can be thought of as the preparatory phase b4 delving into deeper analysis and potential exploitation. It forms a crit part of the `Information Gathering` phase of the pentesting proc.![[PT-process.webp]]The primary goals of web recon include:
- `Id'ing Assets`: Uncovering all publicly accessible components of the target, such as web pgs, subdomains, IP addrs, and techs used. This step provides a comprehensive overveiw of the target's online presence.
- `Discoverying Hidden Info`: Locating sensitive info that might be inadvertently exposed, including backup files, config files, or internal docs. These findings can reveal valuable insights and potential entry points for atks.
- `Analysing the Atk Surface`: Examining the target's atk surface to id potential vulns and weaknesses. This involves assessing the techs used, confs, and possible entry points for exploitation.
- `Gathering Int`: Collecting info that can be leveraged for further exploitation or social eng'ng atks. This includes id'ng key personnel, email addrs, or patterns of behavior that could be exploited.
Atkrs leverage this info to tailor their atks, allowing them to target specific weaknesses and bypass sec measures. Conversely, defenders use recon to proactively id and patch vulns b4 malicious actors can leverage them.
## Types of Reconnaissance
Web recon encompasses two fundamental methodologies: `active` and `passive` recon. Each approach offers distinct adv and challenges, and understanding their dif's is crucial for adequate info gathering.
### Active Reconnaissance
In active recon, the atkr `directly interacts w the target sys` to gather info. This interaction can take various forms:

| **Technique**       | **Description**                                                                            | **Example**                                                                                                             | **Tools**                                                  | **Risk of Detection**                                                                             |
| ------------------- | ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `Port Scanning`     | Id'ng open ports and services running on the target                                        | Using Nmap to scan a web server for open ports like 80 (HTTP) and 443 (HTTPS)                                           | Nmap, Masscan, Unicornscan                                 | High: Direct interaction w the target can trigger IDS and fw                                      |
| `Vuln Scanning`     | Probing the target for known vulns, such as outdated software or misconf's                 | Running Nessus against a web app to check for SQL inj flaws or XSS vulns                                                | Nessus, OpenVAS, Nikto                                     | High: Vuln scanners send exploit payloads that sec solutions can detect                           |
| `Network Mapping`   | Mapping the target's network topology, including connected devices and their relationships | Using traceroute to determine the path pkts take to reach the target server, revealing potential network hops and infra | Traceroute, Nmap                                           | Med to High: Excessive or unusual net traf can raise suspicion                                    |
| `Banner Grabbing`   | Retrieving info from banners displayed by services running on the target                   | Connecting to a web server on port 80 and examining the HTTP banner to id the web server software and version           | Netcat, curl                                               | Low: Banner grabbing typically involves min interaction but can still be logged                   |
| `OS Fingerprinting` | Id'ng the OS running on the target                                                         | Using Nmap's OS detection (`-O`): Windows, Linux, etc                                                                   | Nmap, Xprobe2                                              | Low: Os fingerprinting is usually passive, but some adv techniques can be detected                |
| `Service Enum`      | Determining the specific ver's of services running on open ports                           | Using Nmap's service version detection (`-sV`): Apache 2.4.50, NGINX 1.18.0, etc                                        | Nmap                                                       | Low: Similar to banner grabbing, service enum can be logged but is less likely to trigger alerts  |
| `Web Spidering`     | Crawling the target website to id web pgs, dirs, and files                                 | Running a web crawler to map out the structure of a website and discover hidden resources                               | Burp Suite Spider, OWASP ZAP Spider, Scrapy (customizable) | Low to Med: Can be detected if the crawler's behavior is not carefully conf'd to mimic legit traf |
Active recon provides a direct and often more comprehensive view of the target's infra and sec posture. However, it also carries a higher risk of detection, as the interactions w the target can trig alerts or raise suspicion.
### Passive Reconnaissance
In contrast, passive recon involves gathering info about the target `w/o directly interacting` w it. This relies on analyzing publicly avail info and resources, such as:

| **Technique**           | **Description**                                                                                                 | **Example**                                                                                                                      | **Tools**                                                          | **Risk of Detection**                                                                   |
| ----------------------- | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------------------------------------------------------- |
| `Search Eng Queries`    | Util'ng search eng's to uncover info about the target, including websites, social media prof, and news articles | Searching Google for "`[Target Name] employees`" to find employee info or social media prof                                      | Google, DuckDuckGo, Bing, and specialized search eng (e.g. Shodan) | Very Low: Search eng queries are normal internet activity and unlikely to trig alerts.  |
| `WHOIS Lookups`         | Querying WHOIS dbs to retrieve domain reg details                                                               | Performing a WHOIS lookup on a target domain to find the registrant's name, contact info, and name servers                       | whois cmd-line tool, online WHOIS lookup services                  | Very Low: WHOIS queries are legit and do not raise sus                                  |
| `DNS`                   | Analyzing DNS records to id subdomains, mail servers, and other infra                                           | Using `dig` to enum subdomains of a target domain                                                                                | dig, nslookup, host, dnsenum, fierce, dnsrecon                     | Very Low: DNS queries are essential for internet browsing and are not typically flagged |
| `Web Archive Analysis`  | Examining historical snapshots of the target's website to is changes, vulns, or hidden info                     | Using the Wayback Machine to view past versions of a target website to see how it has changed o/ time                            | Wayback Machine                                                    | Very Low: Accessing archived versions of websites is a normal activity                  |
| `Social Media Analysis` | Gathering info from social media platforms like LinkedIn, Twitter, or Facebook                                  | Searching LinkedIn For employees of a target orgs to learn about their roles, responsibilities, and potential social eng targets | LinkedIn, Twitter, Facebook, specialized OSINT tools               | Very Low: Accessing public social media profs is not considered intrusive               |
| `Code Repos`            | Analyzing publicly accessible code repos like GitHub for exposed creds or vulns                                 | Searching GitHub for code snippets or repos related to the target that might contain sensitive info or code vulns                | GitHub, GitLab                                                     | Very Low: Code repos are meant for public access, and searching them is not sus         |
P recon is generally considered stealthier and less likely to trigg alarms than A recon at the cost of less comprehensive info, as it relies on what's already publicly accessible.

This module will delve into the essential tools and techniques used in web recon, starting with WHOIS. Understanding the WHOIS protocol provides a gateway to accessing vital info about domain reg's, ownership details, and the digital infra of targets. This foundational knowledge sets the stage for more advanced recon methods that will be explored later.
# WHOIS
WHOIS is a widely used query and response protocol designed to access db's that store info about reg'd internet resources. Primarily associated w domain names, WHOIS can also prov details about IP addr blocks and autonomous sys's. It's sort of like an internet wide phonebook that let's someone look up who owns or is responsible for various online assets.
```shell
$ whois inlanefreight.com

[...]
Domain Name: inlanefreight.com
Registry Domain ID: 2420436757_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.registrar.amazon
Registrar URL: https://registrar.amazon.com
Updated Date: 2023-07-03T01:11:15Z
Creation Date: 2019-08-05T22:43:09Z
[...]
```
Each WHOIS record typically contains the following info:
- `Domain Name`: The domain name itself
- `Registrar`: The company where the domain was reg'd (e.g. GoDaddy, Namecheap,etc)
- `Registrant Contact`: The person or org that registered the domain
- `Admin Contact`: The person responsible for managing the domain
- `Technical Contact`: The person handling the technical issues related to the domain
- `Creation and Expiration Dates`: When the domain was reg'd and when it's set to expire
- `Name Servers`: Servers that translate the domain name into an IP addr
<details>
<summary> Click to expand for history of WHOIS</summary>
The history of WHOIS is intrinsically linked to the vision and dedication of [Elizabeth Feinler](https://en.wikipedia.org/wiki/Elizabeth_J._Feinler), a computer scientist who played a pivotal role in shaping the early internet.

In the 1970s, Feinler and her team at the Stanford Research Institute's Network Information Center (NIC) recognised the need for a system to track and manage the growing number of network resources on the ARPANET, the precursor to the modern internet. Their solution was the creation of the WHOIS directory, a rudimentary yet groundbreaking database that stored information about network users, hostnames, and domain names.

### Formalisation and Standardization

As the internet expanded beyond its academic origins, the WHOIS protocol was formalised and standardized in `RFC 812`, published in 1982. This laid the groundwork for a more structured and scalable system to manage domain registration and technical details. Ken Harrenstien and Vic White, also at the NIC, played a crucial role in defining the WHOIS protocol and its query-response mechanisms.

### The Rise of Distributed WHOIS and RIRs

With the internet's exponential growth, the centralised WHOIS model proved inadequate. The establishment of Regional Internet Registries (RIRs) in the 1990s marked a shift towards a distributed WHOIS system.

Key figures like Randy Bush and John Postel contributed to the development of the RIR system, which divided the responsibility of managing internet resources into regional zones. This decentralisation improved scalability and resilience, allowing WHOIS to keep pace with the internet's rapid expansion.

### ICANN and the Modernization of WHOIS

The formation of the `Internet Corporation for Assigned Names and Numbers` (`ICANN`) in 1998 ushered in a new era for WHOIS. Vint Cerf, often referred to as one of the "fathers of the internet," played a crucial role in establishing ICANN, which assumed responsibility for global DNS management and WHOIS policy development.

This centralized oversight helped to standardize WHOIS data formats, improve accuracy, and resolve domain disputes arising from issues like cybersquatting, trademark infringement, or conflicts over unused domains. ICANN's Uniform Domain-Name Dispute-Resolution Policy (UDRP) provides a framework for resolving such conflicts through arbitration.

### Privacy Concerns and the GDPR Era

The 21st century brought heightened awareness of privacy concerns related to WHOIS data. The public availability of personal information like names, addresses, and phone numbers became a growing concern. This led to the rise of privacy services that allowed domain owners to mask their personal information.

The implementation of the `General Data Protection Regulation` (`GDPR`) in 2018 further accelerated this trend, requiring WHOIS operators to comply with strict data protection rules.

Today, WHOIS continues to evolve in response to the ever-changing landscape of the internet. The tension between transparency and privacy remains a central theme. Efforts are underway to strike a balance through initiatives like the `Registration Data Access Protocol` (`RDAP`), which offers a more granular and privacy-conscious approach to accessing domain registration data.
</details>
### Why WHOIS Matters for Web Recon
WHOIS data serves as a treasure trove of info for pentesters during the recon phase of an assessment. It offers valuable insights into the target org's digital footprint and potential vulns:
- `ID'ng Key Personnel`: WHOIS records often reveal the names, email addrs, and phone nums of individuals responsible for managing the domain. This info can be leveraged for social eng atks or to id potential targets for phishing campaigns.
- `Discovering Network Infra`: Technical details like name servers and IP addrs provide clues about the target's network infra. This can help pentesters id potential entry points or misconfs
- `Historical Data Analysis`: Accessing historical WHOIS records through services like [WhoisFreaks](https://whoisfreaks.com/) can reveal changes in ownership, contact info, or technical details o/ time. This can be useful for tracking the evol of the target's digital presence.
## Utilizing WHOIS
Consider the following three scenarios that will help illustrate the value of WHOIS data:
### Scenario 1: Phishing Investigation
An email sec gateway flags a sus email sent to multiple employees w/i a co. The email claims to be from the co's bank and urges recipients to click on a link to update their acct info. A sec analyst investigates the email and begins by performing a WHOIS lookup on the domain linked in the email, which reveals the following info:
- `Reg Date`: The domain was reg'd just a few days prior
- `Registrant`: The registrant's info is hidden behind a privacy service
- `Name servers`: The name servers are associated w a known bulletproof hosting provider often used for malicious activities
This combo of factors raises significant red flags for the analyst. The recent reg date, hidden reg info, and sus hosting strongly suggest a phishing campaign. The analyst promptly alerts the co's IT department to block the domain and warns employees about the scam.

Further investigation into the hosting provider and associated IP addr's may uncover additional phishing domains or infra the threat actor uses.
