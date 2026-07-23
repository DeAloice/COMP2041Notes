---

layout: home
title: Python Modules
permalink: /pythonmodules/
nav_order: 5

---

# [**1. Python Modules**](downloads/python_modules.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

```py
import math as m
from math import sin as sine
```

## **Finding Modules**

```py
import sys

for directory in sys.path:
    print(directory)
```

## **Namespaces**
- py modules can control what names exported by default *

```py
# math_utils.py
def add(a, b):
    return a + b

def multiply(a, b):
    return a * b

__all__ = ["add"]
_pi = 3.14

# test.py
from math_utils import *

add(1,2)
## 3
multiply(1,2)
## error, since __all__ doesn't count
```

- need to be careful to when change different modules vars, etc.

## **Standard Modules**

```py
import sys
for i, module in enumerate(sys.stdlib_module_names):
    print(i, module)
```

## **Non-Standard Modules & Packages**
- PyPI: Python Package Index
- package: collection of files
    - contain source code & installation isntructions of 1+ modules
    - common format: 'wheel' aka zip file
- pip standard package manager:
    - pyproject.toml: in root dir specifies build system t
    - `python3 -m build` : builds the package
        - creates dist dir: `pip3` whl file
        - installs package, can import package from there

```py
import http

# prints where it's in directory
print(http.__file__)
```

- `python3 -m venv venv_demo`: creates virtual envir
    - to activate `. bin/activate` inside venv_demo
    - can pip3 install numpy without worrying about it already being installed, interfering with your current system
    - to deactivate `deactivate`
    - to remove `rm -rf venv_demo`

