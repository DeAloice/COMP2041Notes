#!/bin/dash

# converts filenames in command line arg to lowercase

for old_filename in "$@"
do
    new_filename="$(
    echo "$old_filename"|
    tr A-Z a-z
    )"

    # checks if already lowercase
    test "$new_filename" = "$old_filename" &&
        continue

    # checks if new file name already exists so don't remove
    if test -e "$new_filename"
    then
        echo "$new_filename already exists" 1>&2
        continue
    fi

    # -- covers options for mv
    mv -- "$old_filename" "$new_filename"
done