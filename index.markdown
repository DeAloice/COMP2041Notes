---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<br>

<hr style="height: 3px; background-color: black; border: none;"><br>
<br>

# [**1. Unix Filters**](downloads/filters.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Using Filters**
Shell I/O redirection can be used to specifiy filter source and destination files:
```bash 
$ filter < input.txt > output.txt
$ < input.txt filter > output.txt
$ < input.txt > output.txt filter
```

Alternatively, most filters allow input files to be specified as arguments:
```bash
$ filter input1.txt input2.txt input3.txt > output.txt
```

Filters normally used in combination via pipeline
```bash
filter1 | filter2 | ... | filterN
```
![Filter Combination](images/FilterCombination.png)

## **More about Process Substitution (AKA pipes)**

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Filters: Options**

<hr style="height: 3px; background-color: black; border: none;"><br>
## **Simplest Filter: `cat`**
- cat command copies its input to output unchanged (identity filter).
- cat - given filenames, concatenates them onto stdout.
- cat - given no filenames, copies stdin to stdout unchanged

### **`cat` Options**
Write `cat --help` to see options \
Useful Options:
![UsefulCatOptions](images/UsefulCatOptions.png)
- See also: the `tac` command - which reverses the order of lines.
```bash
$ tac
hello
hi
there
there
hi
hello
```
- See also: the `rev` command - which reverses the order of characters in lines.
```bash
hello
olleh
```

In C:
```c
// write bytes of stream to stdout
void process_stream(FILE *stream) {
    int byte;
    while ((byte = fgetc(stream)) != EOF) {
        if (fputc(byte, stdout) == EOF) {
            perror("cat:");
            exit(EXIT_SUCCESS);
        }
    }
}

// process files given as arguments
// if no arguments process stdin
int main(int argc, char *argv[]) {
    if (argc == 1) {
        process_stream(stdin);
    } else {
        for (int i = 1; i < argc; i++) {
            if (!strcmp(argv[i], "-")) {
                process_stream(stdin);
            } else {
                FILE *in = fopen(argv[i], "r");
                if (in == NULL) {
                    fprintf(stderr, "%s: %s: ", argv[0], argv[i]);
                    perror("");
                    return EXIT_FAILURE;
                }
                process_stream(in);
                fclose(in);
            }
        }
    }

    return EXIT_SUCCESS;
}
```
<hr style="height: 3px; background-color: black; border: none;"><br>
## **Selecting Lines Containing a String `grep`**
### **`grep` Options**
![GrepOption1](images/GrepOptions1.png)
![GrepOption2](images/GrepOption2.png)

Tip: Add in '' (Use double quotes instead "") so don't run shell command before union |
```bash
$ grep -E -c 'Eliza|Lizzie' pride_and_prejudice.txt
$ grep --colour=auto -E -c 'Eliza|Lizzie' pride_and_prejudice.txt
```

In Python:
```py
import sys

def process_stream(f, name, substring):
    """
    print lines containing substring
    equivalent to `grep -FHn`
    """
    for (line_number, line) in enumerate(f, start=1):
        if substring in line:
            print(f'{name}:{line_number}:{line}', end='')


def main():
    """
    process files given as arguments, if no arguments process stdin
    """
    if len(sys.argv) == 1:
        # Only one CLI arg, need something to look through
        sys.exit(f"Usage: {sys.argv[0]} <NEEDLE> [FILE]...")
    elif len(sys.argv) == 2:
        # Two CLI args, take in sys.argv[1] to match, stdin is file to look through
        process_stream(sys.stdin, "<stdin>", sys.argv[1])
    elif len(sys.argv) > 2:
        # more than 2: take in sys.argv[1] to match, rest are files to look through for matches
        for pathname in sys.argv[2:]:
            with open(pathname, 'r') as f:
                process_stream(f, pathname, sys.argv[1])


if __name__ == '__main__':
    main()
```
<hr style="height: 3px; background-color: black; border: none;"><br>
## **Regular Expressions**
### **Basics**
![Basics](images/RegularExpBasics.png)

### **Matching Single Chars**
![Matching Single Chars](images/RegExp2.png)

### **Anchoring Matches**
![Anchoring Matches](images/AnchoringMatch.png)

### **Repetition**
![Repetition](images/RegExpRep.png)

### **Tips**
- To get lines with nothing: ^$
- Whitespace, including tab characters: \s or ([ \t])
- 

Websites:
[Regex101](https://regex101.com)
[RegexR](https://regexr.com)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **`wc`: word counter**
- default: prints number of line, words, bytes in input <br><br>
Useful Options: 
![wcOptions](images/wcOptions.png)

e.g
```bash
$ wc /etc/passwd
49 79 2793 /etc/passwd

$ wc pride_and_prejudice.txt
14533 127377 751479 
# lines words bytes
```

```py
    def process_stream(pathname, stream):
    """
    count lines, words, chars in stream
    """
    lines = 0
    words = 0
    characters = 0
    for line in stream:
        lines += line.endswith(os.linesep)
        words += len(line.split())
        characters += len(line)
    print(f"{lines:>6} {words:>6} {characters:>6} {pathname}")
```

<hr style="height: 3px; background-color: black; border: none;"><br>
## **`tr`: transliterate chars**
- old: reads & writes chars, mapping (replacing) some chars with others
- `tr sourceChars destChars`
- each char in `sourceChars` is mapped to corresponding char in `destChars`
- can't give files to `tr` only stdin but can pass via stdin
- not line based, works with individ chars

e.g 
```bash
$ tr aeiou 12345
Hello comp2041 how are you doing
H2ll4 c4mp2041 h4w 1r2 y45 d43ng

$ cat pride_and_prejudice.txt | tr aeiou 12345
# can reverse
$ cat pride_and_prejudice.txt | tr aeiou 12345 | tr 12345 aeiou
# can use shortcuts
$ tr a-zA-Z b-zB-ZA
cat
dbu
DOG
EPH

$ tr a-zA-Z b-zB-ZA < pride_and_prejudice.txt | more
```

Useful Options:
![trOptions](images/trOptions.png)

<hr style="height: 3px; background-color: black; border: none;"><br>
## **`head/tail`: select first/last lines**
- head: prints first `n` (default 10) lines of input
- tail prints last `n` lines of input

```bash
$ head -n 100 pride_and_prejudice.txt
$ tail -n 100 pride_and_prejudice.txt
# get range
$ head -n 100 pride_and_prejudice.txt | tail -n 200 pride_and_prejudice.txt
```

<hr style="height: 3px; background-color: black; border: none;"><br>
## **`cut`: vertical slice**
Useful Options:
![cutOptions](images/cutOptions.png)

- Remember to add '' around delimiter char
- `cut -d'|' -f-3 data` 
- cannot refer to last column without counting columns
- cannot reorder columns

```bash
# gets chars 20-40 and 60-80 per line
$ cut -c20-40,60-80 pride_and_prejudice.txt
# gets chars 24 and 42 per line
$ cut -c24,42 pride_and_prejudice.txt

# print the first column
$ cut -f1 data
# print the first three columns
$ cut -f1-3 data
# print the first and fourth columns
$ cut -f1,4 data
# print all columns after the third
$ cut -f4- data
# print the first three columns, if '|'-separated
$ cut -d'|' -f-3 data
# print the first five chars on each line
$ cut -c1-5 data

$ cut -d'|' -f1,3 enrollments.psv |grep -E '^COMP(2041|9044)'|cut -d'|' -f2 |grep Anna
# can always |head to double check pipes
```

<hr style="height: 3px; background-color: black; border: none;"><br>
## **`sort`: sort lines**
Useful Options:
![sortOptions](images/sortOptions.png)

```bash
# sort numbers in 3rd column in descending order
sort -nr -k3 data
# sort the password file based on user name
sort -t: -k5 /etc/passwd
```

Python
```py
def process_stream(f):
    """
    print lines of stream in sorted order
    """
    print("".join(sorted(f)), end="")
def main():
    """
    process files given as arguments, if no arguments process stdin
    """
    if len(sys.argv) == 1:
        process_stream(sys.stdin)
    else:
        with open(sys.argv[1], 'r') as f:
            process_stream(f)


if __name__ == '__main__':
    main()
```

<hr style="height: 3px; background-color: black; border: none;"><br>
## **`uniq`: remove or count duplicates**
- remove all but one copy of **adjacent** identical lines
- often preceded by `cut` and `sort`
- e.g can remove all but 1 instance of one given name

Useful Options:
![uniqOptions](images/uniqOptions.png)

```bash
# extract first field, sort, and tally
$ cut -f1 data | sort | uniq -c
$ cut -d' ' -f1 access_log.txt|cut -d. -f1-3|sort|uniq -c| sort -nr|head
```

Python: no memory management
```py
def process_stream(stream):
    """
    copy stream to stdout except for repeated lines
    """
    last_line = None
    for line in stream:
        if last_line is None or line != last_line:
            print(line, end='')
        last_line = line

def main():
    """
    process files given as arguments, if no arguments process stdin
    """
    if not sys.argv[1:]:
        process_stream(sys.stdin)
    else:
        for pathname in sys.argv[1:]:
            with open(pathname, 'r') as f:
                process_stream(f)


if __name__ == '__main__':
    main()
```

<hr style="height: 3px; background-color: black; border: none;"><br>
## **`sed`: stream editor**
- works with streams of chars
- How it works:
    - reads each line of input
    - check if matches any patterns or line-ranges
    - apply related editing commands to the line
    - write the transformed line to output
- partition lines based on patterns rather than cols
- extract ranges of lines based on patterns or line numbers

e.g
```bash
$ sed -E 's/cat|dog/eel/'
$ sed -E -n '/eel/p'
$ sed -E '1,10s/eel/cat/'

# print all lines
$ sed -n 'p' < file
# print the first 10 lines
$ sed '10q' < file
$ sed -n '1,10p' < file
#print lines 81 to 100
$ sed -n '81,100p' < file
#print the last 10 lines of the file?
$ sed -n '$-10,$p' < file # does NOT work

# print only lines containing 'xyz'
$ sed -n '/xyz/p' < file
# print only lines NOT containing 'xyz'
$ sed '/xyz/d' < file
# show the passwd file, displaying only the
# lines from "root" up to "nobody" (i.e. system accounts)
$ sed -n '/^root/,/^nobody/p' /etc/passwd
# remove first column from ':'-separated file
$ sed 's/[^:]*://' datafile
# reverse the order of the first two columns
$ sed -E 's/([^:]*):([^:]*):(.*)$/\2:\1:\3/'
```

### **Useful Options:**
![sedOptions](images/sedOptions.png)

### **Editing Commands:**
![sedEditComm](images/sedEditingComm.png)
- most of the time use `s`
- to use multiple add /
    - e.g `$ sed -E '/Darcy|Elizabeth/d' pride_and_prejudice.txt`

### **Line Addresses/Line Selector Patterns**
![sedLines](images/sedLines.png)

### **Change a file with `sed`**
![changeFileSed](images/changeFileSed.png)


<hr style="height: 3px; background-color: black; border: none;"><br>
## **`find`: search for files**



<hr style="height: 3px; background-color: black; border: none;"><br>
## **`join`: database operator**



<hr style="height: 3px; background-color: black; border: none;"><br>
## **`paste`: combine files**



<hr style="height: 3px; background-color: black; border: none;"><br>
## **`tee`: send copy of pipeline to file**


<hr style="height: 3px; background-color: black; border: none;"><br>
## **`xargs`: run commands with arguments from standard input**