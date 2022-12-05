# BRT   (Bash Readable Textfile)
An interpretive language to simplify bash terminal commands.
So far the 3 commands this code can run is (COMPILE|RUN|MOVE) and it can only compile .cpp or .c files

## Syntax: 
         compile [list of files] with [compiler] {secondary phrase} {executabale} 
         run [executable] {secondary phrase} {input files} {output file}
         move [file/executable] to [destination]
         show {details} [destination]
         delete {dir [destination]} {[files/executables]}

## User Input:
    Destination - Any string beginning with a letter and ending with a '/'. Includes "./" and "../"
    File - Any string beginning with a letter and ending in '.' and 1-3 letters. (brt.l, brt.py, brt.brt)
    Executable - Any string beginning with a letter
    
##  Commands: 
    Compile 
    Run 
    Move 
    Show
    Delete

##  Secondary Phrases:
    With 
    As
    To 

##  Compilers:
     g++ 
     gcc 

## User entered values:
     filename - Filenames will always end in .[a-z]{1,3}
     destination - Desinations will always end with a "/"
     executable - Executables will always end in just a letter

Supports using full filepath for destination and files/executables.

## BRT uses textfiles or .brt files to write in all of the commands needed and execute at once
### EX: Current Working Directory--
                         ./hello1
                         ./hello.cpp
                         ./hello2.cpp
                         ./helperfile/
                             ./helper.cpp
###                         
### input1.brt
     compile hello2.cpp ./helperfile/helper.cpp with g++ as hello2
     move helperfile/helper.cpp to ./
     run hello1
     show ./
###     
### 
## ~$ ./BRT < input1.txt
     Hello World!


##     Current Working Directory--
                         ./hello1
                         ./hello.cpp
                         ./hello2.cpp
                         ./helper.cpp
                         ./helperfile/
