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