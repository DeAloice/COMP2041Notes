#!/bin/dash

n_process="$(getconf _NPROCESSORS_ONLN)"

ls *.c|xargs --max-procs="$n_process" -n 1 gcc -c
gcc *.o -o binary
