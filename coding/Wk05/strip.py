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

