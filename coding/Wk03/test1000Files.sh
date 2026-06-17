create_file() {
    local n
    n=$1

    # create file$n.c containing function f$n
    printf "int f%d(void) {\n\treturn %d;\n}\n" "$n" "$n" >"file$n.c"

    # add declation of function f$n to i.h
    echo "    int f$n(void);" >>i.h

    # add call to function f$n to main.c
    echo "    v += f$n();" >>main.c

    # add file$n.c to list of files to compile
    c_files="$c_files file$n.c"
}

start_main() {
    cat >main.c <<eof
#include <stdio.h>
#include "i.h"

int main(void) {
    int v = 0 ;
eof

    c_files="main.c"
}

finish_main() {
    cat >>main.c <<eof
    printf("%d\n", v);
    return 0;
}
eof
}

start_main

i=0
while test $i -lt 1000
do
    create_file $i
    i=$((i + 1))
done

finish_main

time clang -o thousand_file_program $c_files &&
./thousand_file_program