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