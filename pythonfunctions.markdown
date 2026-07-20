---

layout: home
title: Python Functions
permalink: /pythonfunctions/
nav_order: 5

---

# [**1. Python Functions**](downloads/python_functions.pdf)

<hr style="height: 3px; background-color: black; border: none;"><br>

## **Defining Python Functions**
Functions can be called using:
- positional args: `polly(5, 0.1, 0.2, 0.3)`
- keyword args: `polly(x=2, a=5, b=-3, c=3)`
- can use mix of positional or keyword args

```py
def polly(x, a, b, c):
    return a * x ** 2 + b * x + c
```

Functions can also restrict how they are called using `/` and `*
```py
def polly(x, /, a, *, b, c):
    return a * x ** 2 + b * x + c

# calling
# polly(5, 0.1, b=0.3, c=0.5)

# before / must be positional
# between / and * except either
# after * must be keyword 
```

### **Default Vals for Function Args**
- need to include default vals after non default ones
```py
def polly(x, a=1, b=2, c=3):
    return a * x ** 2 + b * x + c

# calling 
# polly(5)
```

### **Mutable Args are Dangerous**
- using lists or dicts unexpected results 

```py
def append_one(x=[]):
    x.append(1)
    return x

# calling
# append_one()
## [1]
# append_one()
## [1, 1]
# append_one()
## [1, 1, 1]

# can be used deliberately
```

```py
def append_one(x=None):
    if x is None:
        x = []
    x.append(1)
    return x

# calling
# append_one()
## [1]
# append_one()
## [1]
# append_one()
## [1]
```

### **Variable Numbers of Function Args**
- use * to pack positional args into tuple
- use ** to pack positional args into dicts

```py
def f(*args, **kwargs):
    print('positional arguments:', args)
    print('keyword arguments:', kwargs)

args = ['comp2041', 1, 0.5]
kwargs = { 'answer': 42, 'option': False }

# calling 
# f(0.1, 'a', 'hello', val=23, option=False)
## positional arguments: (0.1, 'a', 'hello')
## keyword arguments: { 'val': 23, 'option': False }


# f(args, kwargs)
## positional arguments: ({ 'answer': 42, 'option': False })
## keyword arguments: {}

# f(*args, **kwargs)
## positional arguments: ('comp2041', 1, 0.5)
## keyword arguments: { 'answer': 42, 'option': False }
```

### **No Main Function**

```py
def main():

if __name__=='__main__':
    main()
```

```py
square.py
def square(x)
    return x*x

print(square(5))
print(__name__)


test.py
import square
print(square.square(10))

# assigns module name to __name__ in another file
# run test
## 25 
## square
## 100

# run square
## 25 
## __main__
```

### **docstrings**
- used to document modules and function
- difference with comments
    - comments used to help dev
    - docstrings used to document behaviour for users of code

```py
square.py
"""
This is a module that defines square
"""
def square(x)
    """ calculate the square of a value """
    return x*x

print(square.__doc__)

help(square)
```
