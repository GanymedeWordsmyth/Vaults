Used to gen words matching a specific pattern.
Particularly useful when the pw length or format is known.
A mask can be created using static chars, ranges of chars (e.g. [a-z] or [A-Z0-9]), or placeholders.
The following lists important placeholders:

|**Placeholder**|**Meaning**|
|---|---|
|?l|lower-case ASCII letters (a-z)|
|?u|upper-case ASCII letters (A-Z)|
|?d|digits (0-9)|
|?h|0123456789abcdef|
|?H|0123456789ABCDEF|
|?s|special characters («space»!"#$%&'()*+,-./:;<=>?@[]^_`{|
|?a|?l?u?d?s|
|?b|0x00 - 0xff|
These placeholders can be combined with options `-1` to `-4` which can be used for custom placeholders. See the _Custom charsets_ section [here](https://hashcat.net/wiki/doku.php?id=mask_attack) for a detailed breakdown of each of these four command-line parameters that can be used to configure four custom charsets.