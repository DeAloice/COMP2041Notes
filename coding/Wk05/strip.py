#!/usr/bin/env python3

import sys

n = int(sys.argv[1])

i = 0
s = "@"
while i < n:
    s = s + s
    i += 1
print(s)