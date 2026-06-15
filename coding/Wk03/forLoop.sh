#!/bin/sh

for script in *.sh
do 
    shellcheck "$script"
done