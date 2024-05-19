# Overview
A `Penetration Test (Pentest)` is an organized, targeted, and *authorized* attempt to test IT infrastructure and its defenders to determine their susceptibility to IT security vulnerabilities. Pentesters use methods and techniques that real attackers use to gauge the impact that a particular vuln or chain of vulns may have on the confidentiality, integrity, and availability of an org's IT systems and data. *A pentest aims to uncover and ID ALL vulnerabilities in the systems under investigation and improve the security for the tested systems.*

Other assessments, such as a [[Red Team Assessment]], may be a scenario-based and focus on only the vulns leveraged to reach a specific end goal (i.e. accessing the CEO's email inbox or obtaining a flag planted on a critical server).

Because we, as penetration testers, can find personal data, such as names, addresses, salaries, and much more. The best thing we can do to uphold the [Data Protection Act](https://www.gov.uk/data-protection) is to keep this information private. Another example would be that we get access to a database with credit card numbers, names, and CVV codes. Accordingly, we recommend that our customers improve and change the passwords as soon as possible and encrypt the data on the database.
## Testing Methods
An essential part of the process is the starting point from which pentesters perform tests. Each pentest can be performed from two different perspectives:
### External Penetration Test
Posing as an anonymous user on the internet to ensure that clients are as protected as possible against attacks on their external perimeter. You can perform testing from your own host (using a VPN connection to avoid your ISP blocking the test) or from a VPS. Some clients care more than others regarding stealth. Others may ask for a hybrid approach where the pentester becomes more "noisy" to test their IDS/IPS capabilities. Ultimately, the goal is to access external-facing hosts, obtain sensitive data, or gain access to the internal network.
### Internal Penetration Test
This is where pentesters perform testing from within the corp network. This stage may be executed after successfully penetrating the corp network via the external pentest or starting from an assumed breach scenario. Internal pentests may also access isolated systems with no internet access whatsoever, which usually req's physical presence at the client's facility.
## Types of Penetration Testing
The type of pentest plays a key role and determines how much info is made available to the pentester at the beginning:

| **Type**         | **Information Provided**                                                                                                                                                                                                                                              |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Blackbox`       | `Minimal`. Only the essential information, such as IP addresses and domains, is provided.                                                                                                                                                                             |
| `Greybox`        | `Extended`. In this case, we are provided with additional information, such as specific URLs, hostnames, subnets, and similar.                                                                                                                                        |
| `Whitebox`       | `Maximum`. Here everything is disclosed to us. This gives us an internal view of the entire structure, which allows us to prepare an attack using internal information. We may be given detailed configurations, admin credentials, web application source code, etc. |
| `Red-Teaming`    | May include physical testing and social engineering, among other things. Can be combined with any of the above types.                                                                                                                                                 |
| `Purple-Teaming` | It can be combined with any of the above types. However, it focuses on working closely with the defenders.                                                                                                                                                            |
The less info a pentester is provided with, the longer the approach will take and more complex it will be.
## Types of Testing Environments
Apart from the test method and the type of test, another consideration is what is to be tested, which can be summarized in the following categories:

| doot    | doot    | doot              | doot              | doot          |
| ------- | ------- | ----------------- | ----------------- | ------------- |
| Network | Web App | Mobile            | API               | Thick Clients |
| IoT     | Cloud   | Source Code       | Physical Security | Employees     |
| Hosts   | Server  | Security Policies | Firewalls         | IDS/IPS       |

It is important to note that these categories can often be mixed. All listed test components may be included depending on the type of test to be performed. Now we'll shift gears and cover the Penetration Process in-depth to see how each phase is broken down and depends on the previous one.

# Process
