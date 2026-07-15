---

layout: home
title: Python
permalink: /python/
nav_order: 4

---

# [**1. Python Intro**](downloads/python_intro.pdf)

**Docs:**\\
[Library Link](https://docs.python.org/3.11/tutorial/) \\
[Tutorial Link](https://docs.python.org/3.11/tutorial/)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Running Python-**
- giving filename of python program as command line arg
```bash
$ python3 code.py
```
- giving python prigram itself as command line arg
```bash
$ python3 -c 'print("Hello, world")'
```
- using the #! notation and making the program file executable
```bash
$ head -n1 code.py
#! /usr/bin/env python3
$ chmod 755 code.py
$ ./code.py
```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Variables**
- numeric types: int, float (64 bit IEEE754)
- text seq type: str
- sequence types: list, tuple, range
- mapping types: dict
- more: boolean, None, functions, class
- more: complex, iterator, bytes, byte array, memoryview, etc.

![Arithmetic Operators](images/arithmeticOp.png)
![Logical Operators](images/logicalOp.png)
![More Operators](images/moreOp.png)

```py
# Debugging:
type(x)
x
# will say what value x is 
```

```py
#!/usr/bin/env python3

import math

print("enter x: ", end="")
x = input()
x = int(x)
print("enter y: ", end="")
y = input() 
y = int(y)
pythagoras = math.sqrt(x ** 2 + y ** 2)

print(f"Square root of (x) squared + (y) squared is {pythagoras}")
```
<hr style="height: 3px; background-color: black; border: none;"><br>

## **What is True/False?**
- `False` is false
- `None` is false
- numeric zero is false
- empty seq, mappings, collections are false
- "0" [0] (None,) [[]] are all true

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Examples**

```py
#!/usr/bin/env python3

import math
import sys

total = 0
for line in sys.stdin:
    try:
        total += int(line)
    except ValueError as e:
        print(e)

print(total)
```

```py
# line.rstrip: removes char from end
# line.lstrip: removes char from front
# line.strip: removes chars from both ends of the string

#!/usr/bin/env python3

import math
import sys

total = 0
for line in sys.stdin:
    line = line.rstrip("\n")
    n_chars = len(line)
    print(f"that line has {n_chars} characters")
    f = line[0]
    print(f"The first character is {f}")
    last = line[-1]
    print(f"The last character is {last}")
```

```py
#!/usr/bin/env python3

import sys

last_line = None
for line in sys.stdin:
    line = line.rstrip()
    if line == last_line:
        print("Snap!")
        break 
    last_line = line
```

```py
#!/usr/bin/env python3

import sys

i = 1
while i < len(sys.argv):
    if i > 1:
        print(' ', end='')
    print(sys.argv[i], end=' ')
    i+=1
print()
```

```py
#!/usr/bin/env python3

import sys

n = int(sys.argv[1])

i = 0
s = "@"
while i < n:
    s = s + s
    i += 1
print(s)
```

<hr style="height: 3px; background-color: black; border: none;"><br>

# [**1. Python More**](downloads/python_more.pdf)


```py
#!/usr/bin/env python3

import sys

i = 1
while i < len(sys.argv):
    if i > 1:
        print(' ', end='')
    print(sys.argv[i], end='')
    i += 1
print()

#################
# using for range 
#################
#!/usr/bin/env python3

import sys

for i in range(1, len(sys.argv)):
    if i > 1:
        print(' ', end='')
    print(sys.argv[i], end='')

print()


#################
print(' '.join(sys.argv[1:]))

# takes a list, unpacks args into print
print(*sys.argv[1:])

```

```py
#!/usr/bin/env python3

import sys

total = 0

for arg in sys.argv[1:]:
    try:
        total += int(arg)
    except ValueError:
        # print(f"error: '{arg}' is not an integer", file=sys.stderr)
        # sys.exit(1)
        sys.exit(f"error: '{arg}' is not an integer")

print(total)
```

```py
#!/usr/bin/env python3

import sys

line_count = 0
for line in sys.stdin:
    line_count +=1

print(line_count)

################ OR
#!/usr/bin/env python3

import sys

line_count = sys.stdin.readlines()
line_count = len(lines)
print(line_count)
```

```py
#!/usr/bin/env python3
# cp command

import sys

if len (sys.argv) != 3:
    sys.exit(f"Usage: {sys.argv[0]} <from-file> <to-file>")

in_file = sys.argv[1]
out_file = sys.argv[2]

if in_file == out_file:
    sys.exit("the same file")

try:
    # subprocess.run(['cp', in_file, out_file])
    with open(in_file, "r") as f:
        with open(out_file, "w") as g:
            lines = f.readlines()
            g.writelines(lines)

except OSError as e:
    sys.exit(f"{e}")

```

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Types**
- types associated with value of variable, not variable itself
    - `type(a)`

## **Python Sequences**
- mutable: can be changed
- immutable: cannot be changed
- python does not have arrays
- 3 seq types: 
    - lists: mutable
    - tuples: similar to lists but immutable
    - ranges: immutable seq of nums

```py
>>> l = [1,2,3,4,5]
>>> t = (1,2,3,4,5)
>>> r = range(1, 6)
>>> l[2]
3
>>> t[2]
3
>>> r[2]
3
>>> l[2] = 42
>>> l
[1, 2, 42, 4, 5]
>>> t[2] = 42
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
```

![Useful Python Sequence Op](images/usefulPySeqOp.png)
![List Operators](images/listOp.png)
### **Lists**
```py
a = [1, 1, 2, 2]
a*2
[1, 1, 2, 2, 1, 1, 2, 2]
c = a*2

# slicing
a[1:4]
[1, 2, 2]
a[:4]
[1, 1, 2, 2]
a[1:]
[1, 2, 2]
a[:]
[1, 1, 2, 2]

a[1:3]=[10]
a
[1, 10, 2]
```
### **Shallow Copies**
```py
# shallow copy
import copy

a=[[1,2],[3,4]]
shallow = a.copy()

a[0].append(10)
# also adds 10 to shallow
# shallow copy doesn't copy over vals just knows there's two lists inside the one
# in shallow copy, any nested objects are shared with original

# deepcopy
deep = copy.deepcopy(a)
deep[0].append(100)
deep
[[1,2,100],[3,4]]
# doesn't change a
```
### **Tuples & Ranges**
```py
# tuples & ranges
t = (1,2,4)
t[0]
1
# cannot do t[0]=9 since tuples are immutable

# ranges
list(range(1,10))
[1,2,3,4,5,6,7,8,9]

# lazy evaluation: range doesn't create vals immediately, only when needed so efficient
# range(start, stop, step)
for i in range(1,10):
    print("hello")
```


## **sys module**
```py
import sys
print(sys.argv)
print(sys.version)
print(str(sys.maxsize))
print(str(sys.path))

###################
import sys

sys.stdout.write("Enter your age: ")
sys.stdout.flush() # flush out output buffer

age = sys.stdin.readline().strip() # removes line break

if not age.isdigit():
    sys.stderr.write("Error: Age must be a number. \n")
else:
    print(f"your age is {age}")
    # sys.stdout.write need to manually add newline
    sys.stdout.write(f"your age is {age}. \n")
    sys.stdout.writelines(f"your age is {age}.")
```

## **File operators**
```py
# don't need to specify close at end, does it for you
# if don't close, uses up rscs and runs risk of losing data, since buffer isn't closed
with open('data.txt', 'r') as inputfile:
    with open('output.txt', 'w') as outputfile:
            data = inputfile.read()
            outputfile.write(data)
```

## **Python Dicts**
![Python Dict Operators](images/dictOp.png)

```py
student = {
    'ID': '21110000',
    'age': 20,
    'major': 'Computer Science'
} 

# key must be unique
student['ID'] = 'z5678478"
student['grade'] = "A"
student['grade'] = [80, 90]

for key in student.keys():
    print(key)

for val in student.values():
    print(val)

del student['grade']
student.pop('major')
# returns value and pops off key val pair

### Shallow vs deep copy
student['score'] = [81, 92]
shallow = student.copy()
deep = copy.deepcopy(student)

# age in orig student dict, won't change because it's not a nested object
shallow['age'] = 21
# will append 96 to orig student dict
shallow['score'].append(96)

```

## **Using a set**
```py
fruits = {"apple", "banana", "orange"}
```
```py
lines_seen = set()

for line in sys.stdin:
    if line in lines_seen:
        print("Snap!")
        break
    lines_seen.add(line)
```

## **subprocess module**
```py
import subprocess

p = subprocess.run(["date", "-u"], capture_output=True, text=True)

if p.returncode != 0:
    print(p.stderr)
    exit(1)

weekday, day, month, year, time, timezone = p.stdout.split()
print(f"{year} {month} {day}")

# command injection

# watch website
import re
import subprocess
import sys
import time

REPEAT_SECONDS = 300  # check every 5 minutes

if len(sys.argv) == 4:
    url = sys.argv[1]
    regexp = sys.argv[2]
    email_address = sys.argv[3]
else:
    print(f"Usage: {sys.argv[0]} <url> <regex> <email-address>", file=sys.stderr)
    sys.exit(1)

while True:
    p = subprocess.run(
        ["curl", "--silent", url], text=True, capture_output=True
    )
    webpage = p.stdout
    # searching for regexp appear in webpage i.e p stdout
    if not re.search(regexp, webpage):
        time.sleep(REPEAT_SECONDS)
        continue

    mail_body = f"Generated by {sys.argv[0]}"
    subject = f"website '{url}' now matches regex '{regexp}'"
    # the echo is for testing, remove to really send email
    subprocess.run(["echo", "mail", "-s", subject], text=True, input=mail_body)
    sys.exit(0)
```

<hr style="height: 3px; background-color: black; border: none;"><br>

# [**1. Python Regex**](downloads/python_regex.pdf)

## **re package**
### **re.search**
```py
import re

text = "I study COMP2041 at UNSW, COMP2041 introduces python"

m = re.search('COMP2041', text)

print(m)
# <re.Match object; span=(8, 16), match='COMP2041'>
# m.group()
## 'COMP2041'
# m.start()
## 8
# m.span()
## (8, 16)
```
### **re.match**
```py
import re

text = "I study COMP2041 at UNSW, COMP2041 introduces python"

m = re.match('I', text)
# same as re.search starting with ^
```
### **re.fullmatch**
```py
import re

text = "COMP2041"

m = re.match('COMP2041', text)
```

![PyCharClass](images/PyCharClass.png)

### **Raw Strings**
```py
import re

text = "hello\\nworld"
# raw string: \ treated as literal backslash, no special meaning
text2 = r"hello\nworld"
# hello\nworld

text3 = r"I study \"COMP2041\""
# I study \"COMP2041\"

text4 = r"I study COMP2041\"
# unterminated string literal, escaped backquote

m = re.match('COMP2041', text)
```
```py
import re

text = r"The email account for COMP2041|9044 is cscomp2041@cse.unsw.edu.au."

# \S no whitespace
m = re.search(r'\S+@\S+', text)
# \. for just dot
m = re.search(r'[\w.-]+@\w+(\.\w+)+', text)

m = re.search(r'(\w+)\s+(\w+)', text)
# m.groups()
## ('haibo', 'zhang')
# m.groups(1)
## 'haibo'
# m.groups(0)
## 'haibo zhang'

# non capturing group
m = re.search(r'(?:\w+)\s+(\w+)\s+(\w+)', text)
# m.groups()
## ('haibo', 'zhang')
```

#### **Back referencing**
```py
import re

text = r"The email account for COMP2041|9044 is cscomp2041@cse.unsw.edu.au."

m = re.search(r'(\d+) (\1)', '42 42')
# matches
m = re.search(r'(\d+) (\1)', '42 43')
# up to 99 back references
```

### **re.sub**
```py
import re

text = r"Python \t programming      is fun"

m = re.sub(r'\s+', ' ', text)
```

### **Greedy VS Non-Greedy Pattern Matching: re.findall**
```py
import re

# ? changes to non-greedy
# only matches the first place it can succeed
# match small as possible
re.sub(r'ab+?', 'X', s)

text = "89++d3423kdslfj"

m = re.findall(r'\d+', text)
```

### **re.split**
```py
import re

text = "hello, world  COMP2041"

m = re.split(r'[\s,]+', text)
```

### **Other examples**
```py
# Print the last number (real or integer) on every line
# Note: regexp to match number: -?\d+\.?\d*
# Note use of findall to find all numbers
import re, sys
for line in sys.stdin:
    numbers = re.findall(r'(-?\d+\.?\d*)', line)
    if numbers:
        print(numbers[-1])
```
**count_enrollments using re**
```py
import re

COURSE_CODES_FILE = "course_codes.tsv"
ENROLLMENTS_FILE = "enrollments.txt"

# course_codes.tsv contains tab separated UNSW course and names, e..g
# ACCT1501  Accounting & Financial Mgt 1A
course_names = {}
with open(COURSE_CODES_FILE, encoding="utf-8") as f:
    for line in f:
        if m := re.match(r"(\S+)\s+(.*\S)", line):
            course_names[m.group(1)] = m.group(2)
enrollments_count = {}
with open(ENROLLMENTS_FILE, encoding="utf-8") as f:
    for line in f:
        course_code = re.sub(r"\|.*\n", "", line)
        if course_code not in enrollments_count:
            enrollments_count[course_code] = 0
        enrollments_count[course_code] += 1
for (course_code, enrollment) in sorted (enrollments_count.items(), key=lambda item: item[1], reverse=True):
    # if no name for course_code use ???
    name = course_names.get(course_code, "???")
    print(f"{enrollment:4} {course_code} {name}")
```
**Example-counting enrollments with split & counters**
```py
course_names = {}
with open(COURSE_CODES_FILE, encoding="utf-8") as f:
    for line in f:
        course_code, course_name = line.strip().split("\t", maxsplit=1)
        course_names[course_code] = course_name
enrollments_count = collections.Counter()
with open(ENROLLMENTS_FILE, encoding="utf-8") as f:
    for line in f:
        course_code = line.split("|")[0]
        enrollments_count[course_code] += 1
for (course_code, enrollment) in sorted(enrollments_count.items()):
    # if no name for course_code use ???
    name = course_names.get(course_code, "???")
    print(f"{enrollment:4} {course_code} {name}")
```