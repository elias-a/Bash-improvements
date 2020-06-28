#!/bin/bash

### Test script for the `mv` command

function prep {
    if [ -d "test" ]; then rm -r "test"; fi
    if [ -f "test.dat" ]; then rm "test.dat"; fi
    if [ -f "test1.dat" ]; then rm "test1.dat"; fi
    if [ -f "test2.dat" ]; then rm "test2.dat"; fi
    if [ -d ".trash" ]; then /bin/rm -r .trash; fi

    mkdir "test"
    echo "test" > "test.dat"
    echo "test1" > "test1.dat"
    echo "test2" > "test2.dat"
}

# 1) Move file to another file in the same directory.
#    - mv file1 file2
#    - If file2 exists, move file2 to .trash/file2
function test1 {

    pass=0

    prep
    mv "test.dat" "test1.dat"

    # test.dat should no longer exist
    if [ -f "test.dat" ]; then
        echo "1"
        pass=1
    fi

    # .trash directory should have been created 
    if [ ! -d ".trash" ]; then 
        echo "2"
        pass=1
    fi

    # test1.dat should be in .trash directory
    if [ ! -f ".trash/test1.dat"  ]; then 
        echo "3"
        pass=1
    fi

    # test1.dat should contain only the text from test.dat
    text=$(<test1.dat)
    if [ ! "$text" = "test" ]; then 
        echo "4"
        pass=1
    fi

    if (( $pass == 0 )); then
        echo "PASS"
    else
        echo "FAIL"
    fi

    return $pass
}

test1


# 2) Move file to another file in a different directory.
#    - mv file1 dir/file1
#    - If dir/file1 exists, move dir/file1 to dir/.trash/file1
function test2 {

    return 0
}

# 3) Move files to a directory.
#    - mv file* dir/
#    - If any of the files exist in dir/, move the 
#      duplicate file in dir/ to dir/.trash/
function test3 {

    return 0
}


