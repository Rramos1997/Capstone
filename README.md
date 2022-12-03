# BRT   (Bash Readable Textfile)
An interpretive language to simplify bash terminal commands
So far the 3 commands this code can run is (COMPILE|RUN|MOVE)

## Syntax: 
         compile [list of files] with [compiler] {secondary phrase} {executbale} 
         run [executable] {secondary phrase} {input files} {output file}
         move [file/executable] to [destination]


##  Commands: <br />
      Compile <br />
    Run <br />
    Move <br />

##  Secondary Phrases:
   With <br />
   As <br />
   To <br />

##  Compilers:
     ^g++ <br />
     ^gcc <br />

Supports using full filepath for destination and files/executables.

## BRT uses textfiles or .brt files to write in all of the commands needed and execute at once
### EX: Current Working Directory--
#####                         ./hello1
#####                         ./hello.cpp
#####                         ./hello2.cpp
#####                         ./helperfile/
#####                             ./helper.cpp
###                         
### input1.brt
#####     compile hello2.cpp ./helperfile/helper.cpp with g++ as hello2
#####     move helperfile/helper.cpp to ./
#####     run hello1
###     
### 
## ~$ ./BRT < input1.txt
###     Hello World!
###
###
##     Current Working Directory--
###                          ./hello1
###                         ./hello.cpp
###                         ./hello2.cpp
###                         ./helper.cpp
###                         ./helperfile/
