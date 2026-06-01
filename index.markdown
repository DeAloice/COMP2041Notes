---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<br>

---
<br>

# [**1. Unix Filters**](downloads/filters.pdf)

---

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

---

## **Filters: Options**

---
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
---
## **Selecting Lines Containing a String `grep`**
### **`grep` Options**
![GrepOption1](images/GrepOptions1.png)
![GrepOption2](images/GrepOption2.png)

Tip: Add in `` so don't run shell command before union |
```bash
$ grep -E -c 'Eliza|Lizzie` pride_and_prejudice.txt
$ grep --colour=auto -E -c 'Eliza|Lizzie` pride_and_prejudice.txt
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
---
## **Regular Expressions**
### **Basics**
![Basics](images/RegularExpBasics.png)

### **Matching Single Chars**
![Matching Single Chars](images/RegExp2.png)

### **Anchoring Matches**
![Anchoring Matches](images/AnchoringMatch.png)

### **Repetition**
![Repetition](images/RegExpRep.png)

Websites:
[Regex101](https://regex101.com)
[RegexR](https://regexr.com)

---

## **`wc`: word counter**
- default: prints number of line, words, bytes in input <br><br>
Useful Options: 
![wcOptions](images/wcOptions.png)

e.g
```bash
$ wc /etc/passwd
49 79 2793 /etc/passwd
```
