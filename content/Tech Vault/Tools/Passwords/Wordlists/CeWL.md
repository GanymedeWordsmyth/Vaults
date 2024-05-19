[Another tool](https://github.com/digininja/CeWL) that can be used to create custom wordlists. It spiders and scrapes a website and creates a list of the words that are present.
Especially effective as people tend to use pws associated with the content they write or operate on. e.g. a blogger who blogs about nature, etc. could have a pw associated with their favorite plants or animals.
This is again due to humans simplifying things
Orgs often have pws associated with their branding and industry-specific vocab, e.g. users of a networking co may have pws consisting of words like `router`,`switch`,`server`, and so on.
Such words can be found on their websites under blogs, testimonials, and product descriptions.
```CeWL-syntax
$ cewl -d <depth to spider> -m <minimum word length> -w <output wordlist> <url of website>
```
CeWL can spider multiple pages present on a given website. The length of the outputted words can be altered using the `-m` parameter, depending on the pw reqs
CeWL also supports the extraction of emails from websites with the `-e` option. It's helpful to get this info when [[phishing]], [[pw spraying]], or [[brute-forcing]] pws later.
```example
$ cewl -d 5 -m 8 -e http://inlanefreight.com/blog -w wordlist.txt
```
The command above scrapes up to a depth of five pages from `http://inlanefreight.com/blog`, and includes only words greater than 8 in length.