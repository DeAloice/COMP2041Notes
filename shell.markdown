---

layout: home
title: Shell
permalink: /shell/
nav_order: 2

---
# [**1. Shell**](downloads/shell.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Processing a Shell Input Line**

<hr style="height: 3px; background-color: black; border: none;"><br>

## **`echo`: print args to stdout**
Useful Options:
![echoOptions](images/echoOptions.png)

```shell
echo Hello Andrew
Hello Andrew
$ echo '\n'
\n
$ echo -e '\n'
$ echo -n Hello Andrew
Hello Andrew
```

In Python:
```py
import sys
def main():
"""
print arguments to stdout
"""
print(' '.join(sys.argv[1:]))
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Shell Variables**
- no datatype, untyped: considers them strings
- not declared, do not need initialization (initial val is "")
- one scope: no local variables

```bash
# echo $dylan, initialised to empty
$ echo $dylan 

$ dylan=friend 
$ echo $dylan 
friend

# echo value into $who
who=Noone
$ echo Hello $who
Hello Noone
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **$ (command) - command expansion**
- `$(command)` evaluated by running command
- stdout captured from command
    - except trailing newlines not captured
- `$(command)` remember to add "" to prevent white-space from being lost (due to word-splitting)
- ``command`` (backticks) = `$(command)`


```bash
$ now="$(date)"
$ echo $now
Sun 23 Jun 1912 02:31:00 GMT

$ files="$(ls | tr a-z A-Z|cut -c2-5)"
$ echo "$files"
ARAN
CCES

# can use backticks
$ files="$`ls | tr a-z A-Z|cut -c2-5`"
```


<hr style="height: 3px; background-color: black; border: none;"><br>

## **'' - Single Quotes**
- `' '` group characters into a single word
    - no characters interpreted specially inside single quotes
    - variables, commands, arithmetic, word-splitting, single quote not processed inside `''`
    - can put double quote inside

e.g
```bash
$ echo '*** !@#$%^&*(){}[]:;"<>?,./` ***'
*** !@#$%^&*(){}[]:;"<>?,./` ***
$ echo 'this is "normal"'
this is "normal"
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **"" - Double Quotes**
- `""` group chars into a single word
- variables, commands and arithmetic are expanded inside `""`
- backslash can be used to escape $""\
- can put single quote between `""`

e.g
```bash
$ answer=42
$ echo "The answer is $answer."
The answer is 42.
$ echo 'The answer is $answer.'
The answer is $answer.
$ echo "time's up"
time's up
$ echo "* *"
* *
```

```bash
dylan=friend
$ echo '$dylan'
$dylan
$ echo "$dylan"
friend
$ echo $dylan
friend
# date gets expanded too
$ echo "$dylan $(date)"
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **<< - here documents**
- `<<word` called a here document
- following lines until `word` specify multi-line string as command input
- variables & commands expanded - same as double quotes
- `<<word` variables and commands not expanded - same as ''
- `<<-word` removes leading tabs from each line

```bash
$ name=Andrew
$ tr a-z A-Z <<END-MARKER
Hello $name
How are you
Good bye
END-MARKER
HELLO ANDREW
HOW ARE YOU
GOOD BYE
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Arithmetic**
- `$((expression))` is evaluated as an arithmetic expression
    - expression is evaluated as C-like integer arithmetic
    - and is replaced with the result
    - the $ on variables can be omitted in expressions
- shell arithmetic implementation slow compared to e.g. C
    - significant overhead converting to/from strings
- older scripts may use the separate program `expr` for arithmetic

E.g
```bash
$ x=8
$ answer=$((x*x - 3*x + 2))
$ echo $answer
42
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **word splitting**
![wordSplit](images/wordSplit.png)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **pathname globbing**
- `*?[]!` chars cause a word to be matched against pathnames
- confusingly similar to regexes - but much less powerful
- `*` matches 0 or more of any character - equivalent to regex `.*`
- `?` matches any one characters - equivalent to regex .
- `[characters]` matches 1 of characters - same as regex `[]`
- `[!characters]` matches 1 character not in characters - same as regex `[^]`
- if no pathname matches the word is unchanged


```bash
$ echo *.[ch]
echo.c false.c i.h main.c true.c
$ mkdir backup
$ cp *.[ch] backup
$ ls backup/
echo.c false.c i.h main.c true.c

$ echo *.[ch]
functions.c functions.h i.h main.c
$ ./print_argv.py *.[ch]
['./print_argv.py', 'functions.c', 'functions.h', 'i.h', 'main.c']
$ ./print_argv.py '*.[ch]'
['./print_argv.py', '*.[ch]']
$ ./print_argv.py "*.[ch]"
['./print_argv.py', '*.[ch]']
$ ./print_argv.py *.zzzzz
['./print_argv.py', '*.zzzzz']
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **I/O Redirection**
![ioRedirection](images/ioRedirection.png)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Pipelines**

<hr style="height: 3px; background-color: black; border: none;"><br>

## **searching PATH for the program**
- first word on line specifies command to be run
- if first word is not the full (absolute) pathname of a file the colon-separated list of directory specified by the
variable PATH is searched
- for example if `PATH=/bin/:/usr/bin/:/home/z1234567/bin`
and the command is `kitten` the shell will check (stat) these files in order:
    - `/bin/kitten /usr/bin/kitten /home/z1234567/bin`
    - the first that exists and is executable will be run
    - if none exist the shell will print an error message
- or `.` in PATH causes the current directory to be checked
    - this can be convenient - but make it last not first, e.g.:
    - `PATH=/bin/:/usr/bin/:/home/z1234567/bin:.`
    - definitely do not include the current directory in PATH if you are root
    - an empty entry in PATH is equivalent to .

```bash
$ echo $PATH
/home/andrewt/scripts:/sbin:/bin:/usr/local/bin
## append put own directory at end of current path
$ PATH=/sbin:/bin:/usr/local/bin:/home/andrewt/scripts
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **danger of having . in your PATH**
- if `.` is **not last** in PATH then programs in the current directory may be unexpectedly run
- this can also happen inside run shell scripts or other programs you run
- robust shell scripts often set PATH to ensure this doesn’t happen, 
    - e.g.: `PATH=/bin/:/usr/bin/:$PATH`

```bash
# equivalent to PATH=.:/bin:/usr/bin:/home/z1234567/bin
$ PATH=:/bin:/usr/bin:/home/z1234567/bin
## send stdout to file cat, append eof to cat file
$ cat >cat <<eof
#!/bin/dash
echo miaou
eof
$ chmod 755 cat
$ cat /home/cs2041/public_html/index.html
miaou
$
## Problem: ./cat is being run rather /bin/cat
```
<hr style="height: 3px; background-color: black; border: none;"><br>

## **Shell Scripts**

```bash
## execute shell commands in a file
$ cat hello
echo Hello, John Connor - the time is $(date)
$ dash hello
Hello, John Connor - the time is Fri 29 Aug 1997 02:14:00 EST


## use !/bin/bash for bash
$ cat hello
#!/usr/bin/env dash
echo Hello, John Connor - the time is $(date)
$ chmod 755 hello
$ ./hello
Hello, John Connor - the time is Fri 29 Aug 1997 02:14:00 EST
```

<hr style="height: 3px; background-color: black; border: none;"><br>

### **Shell Built-in Variables**
![shellBuiltInVars](images/builtInShellVars.png)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Debugging Shell Scripts**

<hr style="height: 3px; background-color: black; border: none;"><br>

### **Exit Status & Control**
- Unix-like programs fin: they give op system an **exit status**
    - ret val of main is exit status of C program
    - if exist called, arg is exit status
    - py: `sys.exit(0)`
- `/bin/true` does nothing, always exits with status 0
- `/bin/false` does nothing, always exits with status 1

<hr style="height: 3px; background-color: black; border: none;"><br>

### **`test` command**
![testCommand](images/test.png)

```bash
$ test 3 =3
$ echo $?
0
$ test 3 = 4 
$ echo $?
1
$ test -e file.txt
$ echo $?
1

# does the variable msg have the value "Hello"?
test "$msg" = "Hello"
# does x contain a numeric value larger than y?
test "$x" -gt "$y"
# Error: expands to "test hello there = Hello"?
msg="hello there"
test $msg = Hello
# is the value of x in range 10..20?
test "$x" -ge 10 -a "$x" -le 20
# is the file xyz a readable directory?
test -r xyz -a -d xyz
# alternative syntax; requires closing ]
[ -r xyz -a -d xyz ]
```
<hr style="height: 3px; background-color: black; border: none;"><br>

## **if Statements- syntax**
```bash
if command1
then
then-commands
elif command2
then
elif-commands
else
else-commands
fi
```

```bash
#!/bin/dash

if gcc main.c 2>/dev/null
then
    echo compiled
elif python3 main.c >/dev/null 2>/dev/null
then
    echo you wrote Python not C
else
    echo note compiled
fi

if gcc a.c
then
# you can not have an empty body
# use a : statement which does nothing
:
else
rm a.c
fi
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **while Statements- syntax**
```bash
while command
do
body-commands
done
```

```bash
#!/bin/dash

if test $# = 1
then
    start=1
    finish="$2"
elif
then
    start="$1"
    finish="$2"
else
    ## end: sends stdout to stderr
    echo "Usage $0 <last> or $0 <first> <last>" 1>&2
    exist 1
fi

i=$start
while test $i -le $finish
do
    echo $i
    i=$((i + 1))
done
```