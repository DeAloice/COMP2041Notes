#!/bin/dash

parallel gcc -c '()' ::: *.c
gcc *.o -o binary