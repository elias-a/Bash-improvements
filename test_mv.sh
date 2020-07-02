#!/bin/bash

### Test script for the `mv` command

t="  "

function prep {
    if [ -d "test" ]; then rm -r "test"; fi
    if [ -d "test1" ]; then rm -r "test1"; fi
    if [ -f "test.dat" ]; then rm "test.dat"; fi
    if [ -f "test1.dat" ]; then rm "test1.dat"; fi
    if [ -f "test2.dat" ]; then rm "test2.dat"; fi
    if [ -f "test/test.dat" ]; then rm "test/test.dat"; fi
    if [ -f "test/test1.dat" ]; then rm "test/test1.dat"; fi
    if [ -f "test/test2.dat" ]; then rm "test/test2.dat"; fi
    if [ -d ".trash" ]; then /bin/rm -r ".trash"; fi
    if [ -d "test/.trash" ]; then /bin/rm -r "test/.trash"; fi

    mkdir "test"
    mkdir "test1"
    echo "test" > "test.dat"
    echo "test1" > "test1.dat"
    echo "test2" > "test2.dat"
    echo "test" > "test/test.dat"
    echo "test1" > "test/test1.dat"
    echo "test2" > "test/test2.dat"
}

# 1) Move file to another file in the same directory.
#    - mv file1 file2
#    - If file2 exists, move file2 to .trash/file2
function test1 {

    echo "TEST 1"

    prep
    mv "test.dat" "test1.dat"

    # test.dat should no longer exist
    if [ -f "test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # .trash directory should have been created 
    if [ ! -d ".trash" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test1.dat should be in .trash directory
    if [ ! -f ".trash/test1.dat"  ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test1.dat should contain only the text from test.dat
    text=$(<"test1.dat")
    if [ ! "$text" = "test" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
}

test1


# 2) Move file to another file with the same name in a different directory.
#    - mv file1 dir/file1
#    - If dir/file1 exists, move dir/file1 to dir/.trash/file1
function test2 {

    echo "TEST 2"

    prep
    mv "test.dat" "test/test.dat"

    # test.dat should no longer exist
    if [ -f "test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test/test.dat should exist
    if [ ! -f "test/test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # .trash directory should have been created
    if [ ! -d "test/.trash" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test/test.dat should be in the test/.trash directory
    if [ ! -f "test/.trash/test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
}

test2


# 3) Move files to a directory.
#    - mv file* dir/
#    - If any of the files exist in dir/, move the 
#      duplicate file in dir/ to dir/.trash/
function test3 {

    echo "TEST 3"

    prep
    mv "test*.dat" "test/"

    # None of test*.dat should exist
    if [ -f "test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ -f "test1.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ -f "test2.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # All of test/test*.dat should exist
    if [ ! -f "test/test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ ! -f "test/test1.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ ! -f "test/test2.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test/.trash should exist
    if [ ! -d "test/.trash" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # All of test/.trash/test*.dat should exist
    if [ ! -f "test/.trash/test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ ! -f "test/.trash/test1.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ ! -f "test/.trash/test2.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
}

test3


# 4) Move a directory to another directory
#    - mv dir1/ dir2/
#    - if dir2/dir1/ exists, move dir2/dir1/ to
#      dir2/.trash/dir1/
function test4 {

    echo "TEST 4"

    prep
    mkdir "test1/test/"
    mv "test/" "test1/"

    # test/ should no longer exist
    if [ -d "test" ]; then echo "$t FAIL"; else echo "$t PASS"; fi 

    # test1/test/ should exist
    if [ ! -d "test1/test" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test1/.trash should exist
    if [ ! -d "test1/.trash" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test1/.trash/test/ should exist
    if [ ! -d "test1/.trash/test" ]; then echo "$t FAIL"; else echo "$t PASS"; fi

    # test1/test/test*.dat should exist
    if [ ! -f "test1/test/test.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ ! -f "test1/test/test1.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
    if [ ! -f "test1/test/test2.dat" ]; then echo "$t FAIL"; else echo "$t PASS"; fi
}

test4


