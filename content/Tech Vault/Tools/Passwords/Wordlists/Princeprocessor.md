`PRINCE` or `PRobability INfinite Chained Elements` is an efficient passwd guessing alg to improve passwd cracked rates. 
Takes in a wordlist and creates chains of words taken from this wordlist. For example, consider the following wordlist
```example-wordlist
dog
cat
ball
```
The generated wordlist would look like the following
```generated-wordlist
dog
cat
ball
dogdog
catdog
dogcat
catcat
dogball
catball
balldog
ballcat
ballball
dogdogdog
catdogdog
dogcatdog
catcatdog
dogdogcat
<SNIP>
```
The `--keyspace` option can be used to find the num of combos produced from a the input wordlist:
```number-of-combinations
$ ./pp64.bin --keyspace < words

232
```
According to pp64, 232 unique words can be formed from the above three word wordlist.
```forming-wordlists
$ ./pp64.bin -o wordlist.txt < words
```
The above command writes the output words to a file named `wordlist.txt`. 
pp64 defaults to outputting up to 16 words in length. This can be changed using the `--pw-min` and `--pw-max` args:
```pw-length-limits
$ ./pp64.bin --pw-min=10 --pw-max=25 -o wordlist.txt < words
```
The command above will output words between 10 and 25 in length.
The num of elements per word can be ctrl'd using `--elem-cnt-min` and `--elem-cnt-max`. These values ensure that num of elem's in an output word is above or below the given value:
```specifying-elements
$ ./pp64.bin --elem-cnt-min=3 -o wordlist.txt < words
```
The command above will output words with three elements or more, i.e., "dogdogdog"