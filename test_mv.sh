#!/bin/bash

### Test script for the `mv` command


# Prep test files
if [ ! -d "test" ]; then
    mkdir "test"
fi

echo "test " > "test.dat"
echo "test1" > "test1.dat"
echo "test2" > "test2.dat"


# 1) Move file to another file in the same directory.
#    - mv file1 file2
#    - If file2 exists, move file2 to .trash/file2
function test1 {

    return 0
}

test1
if (( $? == 0 )); then
    echo "PASS"
else 
    echo "FAIL"
fi


# 2) Move file to another file in a different directory.
#    - mv file1 dir/file1
#    - If dir/file1 exists, move dir/file1 to dir/.trash/file1
function test2 {

    return 0
}

test2
if (( $? == 0 )); then
    echo "PASS"
else
    echo "FAIL"
fi


# 3) Move files to a directory.
#    - mv file* dir/
#    - If any of the files exist in dir/, move the 
#      duplicate file in dir/ to dir/.trash/
function test3 {

    return 0
}

test3
if (( $? == 0 )); then
    echo "PASS"
else
    echo "FAIL"
fi


