---

layout: home
title: Shell
permalink: /shell/
nav_order: 2

---
# [**1. Shell**](downloads/shell.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Processing a Shell Input Line**
![processShellInput](images/processShellInput.png)

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
- in if condition we only care about the return value, `test` can return 0 or 1, commands like `grep` can return 0 or 1 if successful'
- checking whether a variable is an integer e.g 
```shell
# sending stderr to bin (i.e /dev/null)
if ! [$integer -eq $integer] 2 > /dev/null; then
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
<hr style="height: 3px; background-color: black; border: none;"><br>

## **seq** 
seq 45 90
prints 45...90 incremented by 1 \\
seq 45 3 90
prints 45...90 incremented by 3

<hr style="height: 3px; background-color: black; border: none;"><br>

## **style: need to set numbered anonymous params to named params**
- first=$1 
- last=$2
- refer to as $first, $last

### **Errors:** 
$0: program name \\
1>&2: sends err message to stderr, exit 1 

### **Syntax**
using [] instead of test 

Running python server:
python3 -m http.server 2041
- using 2041 as port

### **Putting `""`**
- for vars, command, etc. put `""` around it

### **Curl: command line program that fetches url**
- curl https://www.unsw.edu.au/ >out
- transfers url to out file
- curl --silent https://www.unsw.edu.au/ >out same as 
- curl --silent https://www.unsw.edu.au/ >out 2>/dev/null

- using grep in ifs and whiles, if don't want to print line from grep command
    - can send to /dev/null
- put echo in to check if command if run in shell script

```shell
#!/bin/dash
website="$1"
regex="$2"
email="$3"

if test "$#" != 3
then
    echo "Usage: $0 <website> <regex> <email>" 1>&2
fi

while true 
do
    if curl --silent "$website" | grep -E "$regex" >/dev/null
    then
        echo "Generated by $0"| echo mail -s "$website now matches $regex" "$email"
        exit 0
    else 
        echo -n .
    fi
    sleep 3
done 
```

<hr style="height: 3px; background-color: black; border: none;"><br>

**For Statements**
- break, continue can be used inside

```shell
for var in word1 word2 word3
do
    body-commands
    ...
done

# executes once for each command line arg
for a in "$@"
do
    echo "$@"
done
```

e.g
 
```shell
#!/bin/dash

# converts filenames in command line arg to lowercase

for old_filename in "$@"
do
    new_filename="$(
    echo "$old_filename"|
    tr A-Z a-z
    )"

    # checks if already lowercase
    test "$new_filename" = "$old_filename" &&
        continue

    # checks if new file name already exists so don't remove
    if test -e "$new_filename"
    then
        echo "$new_filename already exists" 1>&2
        continue
    fi

    # -- covers options for mv
    mv -- "$old_filename" "$new_filename"
done
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Using Exit Status for Conditional Execution:**
- all commands are executed if separated by `;` or newline
- commands separated by `&&`, execution stops if command has not 0 exit status
- commands separated by `||`, execution stops if a comand has a 0 exit status
- {} can be used to group commands
- () can be used to group commands but executes them in subshell (changes to vars and current working dir have no effect outside of subshell)

e.g
```shell
# run a.out if it exists and is executable
test -x a.out && ./a.out
# if directory tmp doesn't exist create it
test -d tmp || mkdir tmp
# if directory tmp doesn't exist create it
{test -d tmp || mkdir tmp;} && chmod 755 tmp
# but simpler is
mkdir -p tmp && chmod 755 tmp
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **`read`: shell builtin - Shell Input**
- reads line of input into variables

```shell
#!/bin/dash

echo -n "Do you like learning Shell? "

read response

response_char1=$(echo "$response" | tr "A-Z" "a-z" | cut -c1)

if [ "$response_char1" = y ]; then
    echo "Yay"
elif [ "$response_char1" = n]; then 
    echo ":("
else 
    echo "???"
fi
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **`case` statements - syntax**
```shell
case word in
pattern1)
    commands1
    ;;
pattern2)
    commands2
    ;;
patternn)
    commandsN
esac


#!/bin/dash

echo -n "Do you like learning Shell? "

read response

response_char1=$(echo "$response" | tr "A-Z" "a-z" | cut -c1)

case "$response_char1" in 
y)
    echo "Yay"
    ;;
n) 
    echo ":("
    ;;
*) 
    echo "???"
esac
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **shell functions**
- more so just named blocks of code

```shell
#!/bin/dash

favourite() {
    local name command
    name=$1
    command=$2
    echo "My name is $name, my favourite command is $command" 
}

favourite Andrew rm
favourite Rosemary jq
favourite Dylan rsync
```

- create_1001_file_C_program

```shell
create_file() {
    local n
    n=$1

    # create file$n.c containing function f$n
    printf "int f%d(void) {\n\treturn %d;\n}\n" "$n" "$n" >"file$n.c"

    # add declation of function f$n to i.h
    echo "    int f$n(void);" >>i.h

    # add call to function f$n to main.c
    echo "    v += f$n();" >>main.c

    # add file$n.c to list of files to compile
    c_files="$c_files file$n.c"
}

start_main() {
    cat >main.c <<eof
#include <stdio.h>
#include "i.h"

int main(void) {
    int v = 0 ;
eof

    c_files="main.c"
}

finish_main() {
    cat >>main.c <<eof
    printf("%d\n", v);
    return 0;
}
eof
}

start_main

i=0
while test $i -lt 1000
do
    create_file $i
    i=$((i + 1))
done

finish_main

time clang -o thousand_file_program $c_files &&
./thousand_file_program
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **`diff`**
```shell
#!/bin/dash

# check if any set of C programs are the same
# return 0 if two files contain the same code

same() {
    local file1 file2
    file1="$1"
    file2="$2"

    diff -wBi "$file1" "$file2" >/dev/null
    return $? 
}

for file1 in "$@"
do
    for file1 in "$@"
    do
        test "$file1" = "$file2" &&
            break
        same "$file1" "$file2" &&
            echo "$file1" "$file2" "contain the same code"
    done
done
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Temp Files**
- to get unique, can use `$$` at end but hard to access, can use `$(mktemp)`
- execute something on exit for cleanup:
    `trap 'rm $TMP1 $TMP2' EXIT`

```shell
#!/bin/dash

temporary_dir=$(mktemp -d)
# shellcheck disable=SC2064
trap "rm -r $temporary_dir" EXIT

cd "$temporary_dir" || exit 1

## xargs passes seq 1 1000 as args to command following after xargs
## touch creates file if doesn't exist 
# seq 1 1000|xargs touch

echo "$temporary_dir"

echo -n "ready to rm?"

read -r answer
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Concurrency**

```shell
#!/bin/dash

(sleep 1;echo hello) &

for i in $(seq 1 20)
do
   echo $i 
done
```

- `wait`: waits for all processes to finish to continue

```shell
#!/bin/dash

n_process="$(getconf _NPROCESSORS_ONLN)"

ls *.c|xargs --max-procs="$n_process" -n 1 gcc -c
gcc *.o -o binary
```

```shell
#!/bin/dash

parallel gcc -c '()' ::: *.c
gcc *.o -o binary
```

```shell
#hashes
sha2hash() {
    sed '
        s/\/\/.*//
        s/"[^"]"/s/g
        s/[a-zA-Z_][a-zA-Z0-9_]*/v/g
        ' $1|
    sort|
    sha256sum
}

for file in "$@"
do
    echo "$(sha2hash $file) $file"
done|
sort|
uniq -w32 -d --all-repeated=separate

```

<hr style="height: 3px; background-color: black; border: none;"><br>

