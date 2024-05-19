Creates wordlists based on parameters such as words of a specific length, limited char set, or a certain pattern.. Can gen both [[Permutations]] and [[Combinations]].

## Syntax
```syntax
$ crunch <min-length> <max-length> <charset> -t <pattern> -o <output-file>
```
The `-t` option is used to specify the pattern for gen'd pws.
	`@` will insert lower case chars
	`,` will insert upper case chars
	`%` will insert numbers
	`^` will insert symbols
## Generate Word List
```example
$ crunch 4 8 -o wordlist
```
The above command will generate a wordlist consisting of words with a length of 4 to 8 chars, using the default char set.
Let's assume that Inlane Freight user pws are of the form `ILFREIGHTYYYYXXXX` where `XXXX` is the employee ID containing letters, and `YYYY` is the year. Using `crunch` to create a list of such pws would look like the following:
```create-wordlist-using-pattern
$ crunch 17 17 -t ILFREIGHT201%@@@@ -o wordlist
```
The pattern `ILFREIGHT201%@@@@` will create words with the years 2010-2019 followed by four letters. The length here is 17, which is constant for all words in this given example.

If we know a user's birthday is 10/03/1988, you can include this in their pw, followed by a string of letters. Crunch can be used to create a wordlist of such words. The `-d` option is used to specify the amount of repetition: `$ crunch 12 12 -t 10031998@@@@ -d 1 -o wordlist`.