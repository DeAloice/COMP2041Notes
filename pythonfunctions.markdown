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
- positional args have to go before keyword

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

## **List Comprehensions**
- expression for value in iterable
- expression for value in iterable if expression

```py
[x**3 for x in range(10)]
# [0, 1, 8, 27, ...]

[x**3 for x in range(10) if x % 2 == 1]
# [1, 27, 125, ...]
```

## **Lambda Functions**
- function without a name
- variable binding: 
    - variables in lambda exp are bound when lambda is evaluated not created

```py
f = lambda x: x + 42
f(10)
# 52
```

```py
answer = 42
f = lambda x: x+answer
f(10)
# 52

answer = 100
f(10)
# 110

################
answer = 10
f = lambda x, y=answer: x+y
f(10)
# 20
answer = 1000
f(10)
# 20
# still 20
```

## **`enumerate`: builtin function**
- used to iterate over iterable while keeping track of index of each element

```py
languages = ['C', 'Python', 'Java', 'Rust']

e = enumerate(languages)
next(e)
# (0, 'C')
next(e)
# (1, 'Python') etc
list(e)
# [(0, 'C'), (1, 'Python'), (2, 'Java'), (3, 'Rust')]

e_2 = enumerate(languages, start=40)
list(e)
# [(40, 'C'), (41, 'Python'), (42, 'Java'), (43, 'Rust')]
```

## **`zip`: builtin function**
- combines 2+ iterables by pairing their corresponding elements

```py
languages = ['C', 'Python', 'Java', 'Rust']
editors = ['vi', 'emacs', 'nano', 'vscode', 'atom']

e = list(zip(languages, editors))

# [('C', 'vi'), ('Python', 'emacs'), ('Java', 'nano'), ('Rust', 'vscode')]
# always uses shortest length between iterables
```

## **`map`: builtin function**
- applies a function to every item in an iterable (list, tuple or string)
- returns map object (an iterator) with results

```py
>>> list(map(str, range(10)))
['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
>>> list(map(lambda x: x**3, range(10)))
[0, 1, 8, 27, 64, 125, 216, 343, 512, 729]
>>> list(map(lambda x, y: x**y, range(10), range(10)))
[1, 1, 4, 27, 256, 3125, 46656, 823543, 16777216, 387420489]
```

## **`filter`: builtin function**
- returns elements of an iterable(s) such as list for which supplied func returns true

```py
list(filter(lambda x: x % 2 == 0, range(10)))
# [0, 2, 4, 6, 8]
```

## **`sorted`: builtin function**
```py
DAY_LIST = "Sunday Monday Tuesday Wednesday Thursday Friday Saturday".split()
DAY_NUMBER = dict((day, number) for number, day in enumerate(DAY_LIST))

def random_day_of_week():
    return random.choice(DAY_LIST)
def sort_days0(day_list):
    return sorted(day_list, key=lambda day: DAY_NUMBER[day])
def sort_days1(day_list):
    return sorted(day_list, key=DAY_NUMBER.get)
```

## **`functools` module**
```py
>>> # sum first 10 positive integers
>>> functools.reduce(operator.add, range(1, 10))
45
>>> # multiply first 10 positive integers
>>> functools.reduce(operator.mul, range(1, 10))
362880
```