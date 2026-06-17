#!/bin/dash

echo -n "Do you like learning Shell? "

read response

response_char1=$(echo "$response" | tr "A-Z" "a-z" | cut -c1)

case "$response_char1" in 
y)
    echo "Yay"
    ;;
n) 
    echo ":("
    ;;
*) 
    eccho "???"
esac