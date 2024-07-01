# Intro to YARA & Signma
[YARA](https://virustotal.github.io/yara/) and [Sigma](https://github.com/SigmaHQ/sigma) are two essential tools used by SOC analysts to enhance their threat detection and incident response capabilities. They empower analysts w improved threat detection capabilities, malware detection and classification, IOC id, collaboration, customization, and integration w existing sec tools.

YARA excels in file and mem analysis, as well as pattern matching, whereas Sigma is particularly adept at log analysis and SIEM sys's.

These detection rules util conditional logic applied to logs or files. Analysts craft these rules to pinpoint sus activities in logs or match patterns in files. These rules are pivotal in making detections more straightforward to compose, and thus, they constitute a crucial element of an effective threat detection strategy. Both YARA and Sigma adhere to std formats that facilitate the creation and sharing of detection rules w/i the cybersec community.
## Importance of YARA and Sigma rules for SOC Analysts
The following lists key reasons why YARA and Sigma are invaluable for SOC analysts:
- `Enhanced Threat Detection`: YARA and Sigma rules allow SOC analysts to dev customized detection rules tailored to their unique enc and sec needs. These rules empower analysts to discern patterns, behaviors, or indicators linked to sec threats, thus enabling them to proactively detect and and addr potential incidents. Various GitHub repos provide a wealth of examples of YARA and Sigma rules:
	- - `YARA rules`: [https://github.com/Yara-Rules/rules/tree/master/malware](https://github.com/Yara-Rules/rules/tree/master/malware), [https://github.com/mikesxrs/Open-Source-YARA-rules/tree/master](https://github.com/mikesxrs/Open-Source-YARA-rules/tree/master)
	- `Sigma rules` [https://github.com/SigmaHQ/sigma/tree/master/rules](https://github.com/SigmaHQ/sigma/tree/master/rules), [https://github.com/joesecurity/sigma-rules](https://github.com/joesecurity/sigma-rules), [https://github.com/mdecrevoisier/SIGMA-detection-rules](https://github.com/mdecrevoisier/SIGMA-detection-rules)
- `Efficient Log Analysis`: Sigma rules are essential for log analysis in a SOC setting. Util'g Sigma rules, analysts can filter and correlate log data from disparate sources, concentrating on events pertinent to sec monitoring. This min's irrelevant data and enables analysts to prioritize their investigative efforts, leading to more efficient and effective incident response. A foss tool called [Chainsaw](https://github.com/WithSecureLabs/chainsaw) can be used to apply Signma rules to even log files.
- `Collaboration and Standardization`: YARA and Sigma offer std'ized formats and rule structures, fostering collab among SOC analysts an tapping into the collective expertise of the broader csec community. This encourages knowledge sharing, the formulation of best practices, and keeps analysts abreast of cutting-edge threat intelligence and detection methodologies. E.g. "The [DFIR Report](https://thedfirreport.com/)" shares YARA and Sigma rules derived from their investigations.
	- - [https://github.com/The-DFIR-Report/Yara-Rules](https://github.com/The-DFIR-Report/Yara-Rules)
	- [https://github.com/The-DFIR-Report/Sigma-Rules](https://github.com/The-DFIR-Report/Sigma-Rules)
- `Integration with Security Tools`: YARA and Sigma rules can be integrated seamlessly w the plethora of sec tools, including SIEM platforms, log analysis systems, and incident response platforms. This integration enables automation, correlation, and enrichment of sec events, allowing SOC analysts to incorporate the rules into their existing sec infra. E.g. [Uncoder.io](https://uncoder.io/) facilitates the conversion of Sigma rules into tailor-made, performance-optimized queries ready for deployment in the chosen SIEM and XDR systems.
- `Malware Detection and Classification`: YARA rules are particularly useful for SOC analysts in pinpointing and classifying malware. Leveraging YARA rules, analysts can create specific patterns or signatures that correspond to known malware traits or behaviors. This aids in the prompt detection and mitigation of malware threats, bolstering the org's overall sec posture.
- `Indicator of Compromise (IoC) Identification`: Both YARA and Sigma rules empower SOC analysts to locate and id IoCs, which are distinct artifacts or behaviors linked to sec incidents or breaches. By embedding IoCs into their rules, analysts can swiftly detect and counter potential threats, thus mitigating the consequences of sec incidents and curtailing the duration of atkrs' presence w/i the network.
# Leveraging YARA
## YARA and YARA Rules
`YARA` is a powerful pattern-matching tool and rule format used for id'ng and classifying files based on specific patterns, char'istics, or content. SOC analysts commonly use YARA rules to detect and classify malware samples, sus files, or indicators of compromise (IoCs).

YARA rules are typically written in a rule syntax that defines the conditions and patterns to be matched w/i files. These rules can include various elements, such as str's, regexes, and Boolean logic operators, allowing analysts to create complex and precise detection rules. It's important to note that YARA rules can recognize both textual and bin patterns, and they can be applied to mem forensics activities as well.

When applied, YARA scans files or dirs and matches them against the defined rules. If a file matches a specific pattern or condition, it can trigger and alert or warrant further examination as a potential sec threat.![[Pasted image 20240624153932.png]]YARA rules are especially useful for SOC analysts when analyzing malware samples, conducting forensic investigations, or performing threat hunting activities. The flexibility and extensibility of YARA make it a valuable tool in the csec community.
### Usages of YARA
- `Malware Detection and Classification`: YARA is commonly used for detecting and id'ng malware samples based on specific patterns, char'stic, or indicators. YARA rules can be created to match against known malware sig's, behaviors, or file properties, aiding in the id'tion of malicious files and potentially preventing further compromise. W/i the scope of digital forensics, YARA can also id sus or malicious patterns in captured mem imgs.
- `File Analysis and Classification`: YARA is valuable for analyzing and classifying files based on specific patterns or attr's. Analysts can create YARA rules to categorize files by dif file formats or file type, ver, metadata, packers, or other char'stics. This capability is useful in forensic analysis, malware research, or id'ng specific file types w/i large datasets.
- `Indicator of Compromise (IoC) Detection`: YARA can be employed to search for specific IoCs w/i files or dirs. By defining YARA rules that target specific IoC patterns, e.g. file names, reg keys, or network artifacts, sec teams can id potential sec breaches or ongoing atks.
- `Community-driven Rule Sharing`: YARA provides the ability to tap into a community that regularly contributes and shares their detection rules. This ensures that detection mechanisms are constantly updated and refined.
- `Create Custom Security Solutions`: By combining YARA rules w other techniques like static and dynamic analysis, sandboxing, and behavior monitoring, effective sec solutions can be created.
- `Custom YARA Signatures/Rules`: YARA allows users to create custom rules tailored to an org's specific needs and env. By deploying these custom rules in the sec infra, e.g. AV or endpoint detection and response (EDR) solutions, defense capabilities can be enhanced. Custom YARA rules can help id unique or targeted threats that are specific to an org's assets, apps, or industry.
- `Incident Response`: YARA aids in incident response by enabling analysts to quickly search and analyze files or mem imgs for specific patterns or indicators. By applying YARA rules during the investigation proc, analysts can id relevant artifacts, determine the scope of an incident, and gather critical info to aid in remediation efforts.
- `Proactive Threat Hunting`: Instead of waiting for an alert, YARA can be leveraged to perform proactive searches across env's, searching for potential threats or remnants of past infections.
### How Does YARA Work?
In summary, the YARA scan eng, equipped w YARA modules, scans a set of files by comparing their content against the patterns defined in a set of rules. When a file matches the patterns and conditions specified in a YARA rule, it is considered a detected file. This proc allows analysts to efficiently id files that exhibit specific behaviors or char'stics, aiding in malware detection, IoC id, and threat hunting. This flow is demonstrated in the following diagram:![[Pasted image 20240625121423.png]]The YARA scan eng, using YARA modules, matches patterns defined in a set of rules against a set of files, resulting in the detection of files that meet the specified patterns and conditions. This is how YARA rules are helpful to id threats. The following list explains this in more detail:
- `Set of Rules (containing suspicious patterns)`: First of all, security analysts create one or more YARA rules. These rules define specific patterns, char'stics, or indicators that need to be matched w/i the files. Rules can include str's, regexes, byte sentences, and other indicators of interest. The rules are typically stored in a YARA rule file format (e.g. `.yara` or `.yar` file ext's) for easy mngment and reuse.
- `Set of Files (for scanning)`: A set of files, such as executables, docs, or other bin or text-based files, are provided as input to the YARA scan eng. The files can be stored on a local disk, w/i a dir, or even w/i mem imgs or net-traf captures.
- `YARA Scan Engine`: The YARA scan eng is the core component responsible for performing the actual scanning and matching of files against the defined YARA rules. It util's YARA modules, which are sets of algs and techniques, to efficiently compare the content of files against the patterns specified in the rules.
- `Scanning and Matching`: The YARA scan eng iterates through each file in the set, one at a time. For each file, it analyzes the content byte be byte, looking for matches against the patterns defined in the YARA rules. The YARA scan eng uses various matching techniques, including str matching, regexes, and bin matching, the id patterns and indicators w/i the files.
- `Detection of Files`: When a file matches the patterns and conditions specified in a YARA rule, it is considered a detected fule. The YARA scan eng records info about the match, such as the matched rule, the file path, and the offset w/i the file where the match occurred and provides output indicating the detection, which can be further proc'd, logged, or used for subsequent actions.
### YARA Rule Structure
YARA rule structures consist of several components that define the conditions and patterns to be matched w/i files. As example of a YARA rule is as follows:
```yara
rule my_rule {

    meta:
        author = "Author Name"
        description = "example rule"
        hash = ""
    
    strings: 
        $string1 = "test"
        $string2 = "rule"
        $string3 = "htb"

    condition: 
        all of them
} 
```
Each rule in YARA starts w the keyword `rule` followed by a `rule identifier` (my_rule). Rule identifiers are cs sensitive where the first char cannot be a digit, cannot exceed 128 chars, and cannot be one of the following keywords:![[Pasted image 20240625123601.png]]The following rule structure uses a rule that id's str's associated w the [WannaCry](https://www.mandiant.com/resources/blog/wannacry-malware-profile) ransomware, instructing YARA to flag any file containing all three specified str's as `Ransomware_WannaCry`.
```yara
rule Ransomware_WannaCry {

    meta:
        author = "Madhukar Raina"
        version = "1.0"
        description = "Simple rule to detect strings from WannaCry ransomware"
        reference = "https://www.virustotal.com/gui/file/ed01ebfbc9eb5bbea545af4d01bf5f1071661840480439c6e5babe8e080e41aa/behavior" 
    
    strings:
        $wannacry_payload_str1 = "tasksche.exe" fullword ascii
        $wannacry_payload_str2 = "www.iuqerfsodp9ifjaposdfjhgosurijfaewrwergwea.com" ascii
        $wannacry_payload_str3 = "mssecsvc.exe" fullword ascii
    
    condition:
        all of them
}
```
That's a basic structure of a YARA rule. It starts w a `header` containing `metadata`, followed by `conditions` that define the context of the files to be matched, and a `body` that specifies the patterns or indicators to be found. The use of metadata and `tags` helps in org'ng and doc'ng the rules effectively.

**YARA Rule Breakdown**:
1. `Rule Header`: The rule header provides metadata and id's the rule. It typically includes:
	* `Rule name`: A descriptive name for the rule
	* `Rule tags`: Optional tags or labels to categorize the rule
	* `Rule metadata`: Additional info such as author, desc, and creation date
**Example**:
```yara
rule Ransomware_WannaCry{
	meta:
...SNIP...
}
```
2. `Rule Meta`: The rule meta section allows for the def of additional metadata for the rule. This metadata can include info about the rule's author, references, version, etc.
**Example**:
```yara
rule Ransomware_WannaCry{
	meta:
		author = "Madhukar Raina"
		version = "1.0"
		description = "Simple rule to detect strings from WannaCry ransomware"
		reference = "https://www.virustotal.com/gui/file/ed01ebfbc9eb5bbea545af4d01bf5f1071661840480439c6e5babe8e080e41aa/behavior"
...SNIP...
}
```
3. `Rule Body`: The rule body contains the patterns or indicators to be matched w/i the files. This is where the actual detection logic is defined.
**Example**:
```yara
rule Ransomware_WannaCry {
...SNIP...
    strings:
        $wannacry_payload_str1 = "tasksche.exe" fullword ascii
        $wannacry_payload_str2 = "www.iuqerfsodp9ifjaposdfjhgosurijfaewrwergwea.com" ascii
        $wannacry_payload_str3 = "mssecsvc.exe" fullword ascii
...SNIP...
}
```
4. `Rule Conditions`: Rule conditions define the context or char'istics of the files to be matched. Conditions can be based on file properties, str's, and other indicators. Conditions are specified w/i the condition section.
**Example**:
```yara
rule Ransomware_WannaCry{
...SNIP...
	condition:
		all of them
}
```
In this YARA rule, the condition section simply states `all of them`, which means that all the str's defined in the rule must be present for the rule to trig a match.

The following is an additional example of a condition which specifies that the file size of the analyzed file must be less than `100` kilobytes (KB).
```yara
	condition:
		filesize < 100KB and (uint16(0) == 0x5A4D or uint16(0) == 0x4D5A)
```
This condition also specifies that the first 2 bytes of the file must be either `0x5A4D` (ASCII `MZ`) or `0x4D5A` (ASCII `ZM`), by using `uint16(0)`:
```yara
uint16(<offset>)
```
Here's how `uint16(0)` works:
- `uint16`: This indicates the data type to be extracted, which is a `16`-bit unsigned integer (`2` bytes).
- `(0)`: The val inside the parentheses reps the offset from where the extraction should start. In this case, `0` means the fn will extract the 16-bit cal starting from the beginning of the data being scanned. The condition uses `uint16(0)` to compare the first 2 bytes of the file w specific vals.
It's important to note that YARA provides a flexible and extensible syntax, allowing for more advanced feature and techniques such as modifiers, logical operators, and external modules. These feats can enhance the expressiveness and effectiveness of YARA rules for specific detection scenarios.

Remember that YARA rules can be customized to suit specific use cases and detection needs. Regular practice and experimentation will further enhance your understanding and prof w YARA rule creation. [YARA doc'tion](https://yara.readthedocs.io/en/latest/) contain more details in depth.
## Developing YARA Rules
This section will cover manual and automated YARA rule dev't.