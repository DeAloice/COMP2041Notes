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

## **Python Dicts**
![Python Dict Operators](images/dictOp.png)

### **Using a set**
```py
lines_seen = set()

for line in sys.stdin:
    if line in lines_seen:
        print("Snap!")
        break
    lines_seen.add(line)
```

