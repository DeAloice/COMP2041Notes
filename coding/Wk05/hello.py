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