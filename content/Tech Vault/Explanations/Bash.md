# Bourne Again Shell
[Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) is the scripting lang used to communicate w and give commands to Unix-based OS systems. The main dif b/w scripting and prog langs is that scripting doesn't req compiling code to execute.

Like prog langs, scripting langs can be divided into the following structures:
- `Input` & `Output`
- `Arguments`, `Variables` & `Arrays`
- `Conditional execution`
- `Arithmetic`
- `Loops`
- `Comparison operators`
- `Functions`
In general, a script does not create a process, but it is executed by the interpreter that executes the scripts, in this case, the `Bash`.
## Variables
In contrast to other prog langs, there is no direct differentiation and recognition b/w the types of vars in Bash like "`strings`", "`integers`", and "`booleans`". All contents of the vars are treated as string chars. Bash enables arithmetic funcs depending on whether only numbers are assigned or not. It is important to note when declaring vars that they do `not` contain a `space`. Otherwise, the actual variable name will be interpreted as an internal function or a command.
`$ variable = "this will result w an err."`
`$ variable="Declared w/o and err.`
### Special Variables
Special variables use the [Internal Field Separator](https://bash.cyberciti.biz/guide/$IFS) (`IFS`) to identify when an argument ends and the next begins. Bash provides various special variables that assist while scripting. Some of these variables are:

| **IFS** | **Description**                                                                                                                                                         |
| ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `$#`    | This variable holds the number of arguments passed to the script.                                                                                                       |
| `$@`    | This variable can be used to retrieve the list of command-line arguments.                                                                                               |
| `$n`    | Each command-line argument can be selectively retrieved using its position. For example, the first argument is found at `$1`.                                           |
| `$$`    | The process ID of the currently executing process.                                                                                                                      |
| `$?`    | The exit status of the script. This variable is useful to determine a command's success. The value 0 represents successful execution, while 1 is a result of a failure. |
## Arrays
It is also possible to assign several values to a single var in Bash, called `arrays`. `Arrays` identify each stored entry with an `index` starting with `0`. Declare an array like follows:
`$ array=(first second third)`
call elements thus:
`${array[0])` calls `first`
`${array[1])` calls `second`
`${array[2])` calls `third`
>[!Note] Important Note
>Single quotes (`'` ... `'`) and double quotes (`"` ... `"`) prevent the separation by a space of the individual values in the array. This means that all spaces between the single and double quotes are ignored and handled as a single value assigned to the array.
>`$ array=("first second" third)` has two values: 
>`first second` and `third`.

# Comparison Operators
To compare specific values with each other, use elements called [comparison operators](https://www.tldp.org/LDP/abs/html/comparison-ops.html), which are used to determine how the def'd values will be compared. They are differentiated as follows:
- `string` operators
- `integer` operators
- `file` operators
- `boolean` operators
## String Operators
If we compare strings, then we know what we would like to have in the corresponding value.

|**Operator**|**Description**|
|---|---|
|`==`|is equal to|
|`!=`|is not equal to|
|`<`|is less than in ASCII alphabetical order|
|`>`|is greater than in ASCII alphabetical order|
|`-z`|if the string is empty (null)|
|`-n`|if the string is not null|
>[!Note] Important Note:
>Put an arg (`$1`) in double-quotes (`"$1"`) to tell Bash that the content of the var should be handled as a string.
>Additionally, string comparison operators "`<`/`>`" only work w/i the double square brackets (`[[ <condition]]`). 
>Use `man ascii` to display the `American Standar Code for Information Interchange` (`ASCII`) table, or search it on the internet. The `ASCII` table reps a 7-bit char encoding. Each bit takes two values, totaling `128` different bit patterns, which can also be interpreted as the dec int `0`-`127` or in hex as `00`-`7F`. The first 32 ASCII char codes are reserved as so-called [control characters](https://en.wikipedia.org/wiki/Control_character).
## Integer Operators
Comparing integer numbers can be very useful for us if we know what values we want to compare. Accordingly, we define the next steps and commands how the script should handle the corresponding value.

|**Operator**|**Description**|
|---|---|
|`-eq`|is equal to|
|`-ne`|is not equal to|
|`-lt`|is less than|
|`-le`|is less than or equal to|
|`-gt`|is greater than|
|`-ge`|is greater than or equal to|
## File Operators
The file operators are useful if we want to find out specific permissions or if they exist.

| **Operator** | **Description**                                        |
| ------------ | ------------------------------------------------------ |
| `-e`         | if the file exist                                      |
| `-f`         | tests if it is a file                                  |
| `-d`         | tests if it is a directory                             |
| `-L`         | tests if it is if a symbolic link                      |
| `-N`         | checks if the file was modified after it was last read |
| `-O`         | if the current user owns the file                      |
| `-G`         | if the file’s group id matches the current user’s      |
| `-s`         | tests if the file has a size greater than 0            |
| `-r`         | tests if the file has read permission                  |
| `-w`         | tests if the file has write permission                 |
| `-x`         | tests if the file has execute permission               |
## Boolean Operators
We get a boolean value "`false`" or "`true`" as a result with logical operators. Bash gives us the possibility to compare strings by using double square brackets `[[ <condition> ]]`. To get these boolean values, we can use the string operators. Whether the comparison matches or not, we get the boolean value "`false`" or "`true`".
## Logical Operators
With logical operators, we can define several conditions within one. This means that all the conditions we define must match before the corresponding code can be executed.

| **Operator** | **Description**        |
| ------------ | ---------------------- |
| `!`          | logical negotation NOT |
| `&&`         | logical AND            |
| `\|`         | logical OR             |
# Arithmetic
In Bash, we have seven different `arithmetic operators` we can work with. These are used to perform different mathematical operations or to modify certain integers.

| **Operator** | **Description**                         |
| ------------ | --------------------------------------- |
| `+`          | Addition                                |
| `-`          | Substraction                            |
| `*`          | Multiplication                          |
| `/`          | Division                                |
| `%`          | Modulus                                 |
| `variable++` | Increase the value of the variable by 1 |
| `variable--` | Decrease the value of the variable by 1 |
It's also possible to calc the length of a var using the func `${#var}`. Using this, every char get counted, and outputs the total num of chars in the var.
# Input and Output
## Input Control
It's common to get results from sent requests and executed cmds, which then you have to manually decide on how to proceed. 
## Output Control
The issue with redirections is that they do not give any output from the respective cmd. It will be redirected to the appropriate file. In more complicated scripts, they can take much more time than just a few seconds. To avoid sitting inactively and waiting for the script's results, use the [tee](https://man7.org/linux/man-pages/man1/tee.1.html) utility to ensure that scripts output results immediately *and* that they are stored in the corresponding files.
# Flow Control - Loops
The control of script flow is crucial to ensure they work quickly and efficiently. `if-else` conditions are a part of flow control, as well as other components to inc efficiency and allow err-free processing. Each control structure is either a `branch` or a `loop`. Logical expressions of boolen values usually control the execution of a control structure, which include:
- Branches:
    - `If-Else` Conditions
    - `Case` Statements
- Loops:
    - `For` Loops
    - `While` Loops
    - `Until` Loops
## For Loops
`For` loops are executed on each pass for precisely one parameter, which the shell takes from a list, calcs from an increment, or takes from another data source. the `for` loop runs as long as it finds corresponding data. This type of loop can be strucftured and def'd in diff ways e.g. the `for` loops are often used when needing to work with many diff values from an array. This can be used to scan diff hosts or ports. `For` loops can also be used to execute specific cmds for known ports and their services to speed up the enumeration process.
```syntax
[SNIP]
for var in 1 2 3 4
do
	echo $var
done
[SNIP]
```
```eg1
[SNIP]
for var in file1 file2 file3
do
	echo $var
done
[SNIP]
```
```ag2
[SNIP]
for ip in "10.10.10.170 10.10.10.172 10.10.10.175"
do
	ping -c 1 $ip
done
[SNIP]
```
It's also possible to write these cmds in a single line thusly:
`$ for ip in 10.10.10.170 10.10.10.174;do ping -c 1 $ip;done`
## While Loops
The `while` loop is conceptually simple and follows the following principle:
- A statement is executed as long as a condition is fulfilled (`true`).
It's also possible to combine loops and merge their execution w diff values.
>[!Note] Important Note
>The excessive combination of several loops in each other can make the code very unclear and lead to errs that can be hard to find and follow.
## Until Loops
The `until` loop, while it does exist, is relatively rare. Nevertheless, the `until` loop works precisely like the `while` loop, but w the following diff:
- The code inside an `until` loop is executed as long as the particular condition is `false`.
# Flow Control - Branches
`Case` statements are also known as `switch-case` statements in other languages, such as C/C++ and C#. The main diff b/w `if-else` and `switch-case` is that `if-else` constructs allow checking *any* boolean expression, while `switch-case` always compares only the var w the exact val. Therefore, the same conditions as for `if-else`, e.g. `greater-than`, are not allowed in `switch-case`.
```syntax
case <expression> in
	pattern_1 ) statements ;;
	pattern_2 ) statements ;;
	pattern_3 ) statements ;;
esac
```
The def of `switch-case` starts with `case`, followed by the var or val as an expression, which is then compared in the pattern. If the var or val matches the expression, then the statements are executed after the parentesis and ended with a double semicolon (`;;`).
# Functions
As script become bigger, they can also become far more chaotic. It's possible to utilize `functions` to prevent using the same routines several times w/i a script, causing it to inc exponentially. `functions` invaluably improve both the size and the clarity of the script. Combine several cmds in a block b/w curly brackets (`{`...`}`) and call them w a def'd func name. Once a `function` has been def'd, it can be called and used as many times as needed throughout the script.
>[!Note] Important Note:
>Scripts are processed from top to bottom. Therefore, `functions` must always be defined logically *before* the first call. A good practice to get into is defining `functions` at the beginning of a script, even if you have to stop where you are in the script to go back to the top to do so.

There are two methods to def a `function`:
```method-1
function <name> {
	<commands>
}
```
```method-2
<name>() {
	<commands>
}
```
Which one to choose mostly comes down to personal preference.
## Passing Parameters
`functions` should be designed so that they can be used w a fixes structure of the val's or at least only with a fixed format so they do not collide w those of other func's or the parameters of the shell script. These are `$1`-`$9` (`${n}`), ot `$var`. Each `function` has its own set of parameters.
>[!Note] Interesting Note:
>An important diff b/w bash scripts and other prog langs is that all def'd vars are always processed `globally` unless otherwise declared by "[local](https://www.tldp.org/LDP/abs/html/localvar.html)." This means that the first time a var is def'd in a `function`, it will be called in the main script (outside the `function`).
## Return Values
When starting a new process, each `child process`, e.g. a `function` in the executed script, returns a `return code` to the `parent process` (`bash shell` through which the script was executed) at its termination, informing it of the status of the execution. This info is used to determine whether the process ran successfully or whether specific errs occurred. Based on this info, the `parent process` can decide on further prog flow.

|**Return Code**|**Description**|
|---|---|
|`1`|General errors|
|`2`|Misuse of shell builtins|
|`126`|Command invoked cannot execute|
|`127`|Command not found|
|`128`|Invalid argument to exit|
|`128+n`|Fatal error signal "`n`"|
|`130`|Script terminated by Control-C|
|`255\*`|Exit status out of range|
To get the val of a `function` back, use one of several methods such as `return`, `echo`, or a `variable`.
# Debugging
Bash provides an excellent opportunity to find, track, and fix errors in code. The term `debugging` can have many diff meanings. Nevertheless, [bash debugging](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_02_03.html) is the process of removing errors (bugs) from code. Debugging can be performed in many diff ways. This process is also used to find vulns in progs. The `bash` cmd also allows debugging code by passing the "`-x`" (`xtrace`) and "`-v`" options: `bash -x`, which will show which func or cmd was execute with which values, indicated by the plus sign (`+`) at the beginning of a line, or `bash -x -v`, which will give even more detail.