CXX = g++
CPPFLAGS = -std=c++17 -g
DEPDIR = deps
OBJDIR = objs
	
BRT: lex.yy.c brt.tab.c
	g++ -g -std=c++17 lex.yy.c brt.tab.c -o BRT

lex.yy.c: brt.l brt.tab.h
	flex brt.l # generates lex.yy.c which includes brt.tab.h

brt.tab.c brt.tab.h: brt.y
	bison -vd brt.y

hellorun: runtest.cpp 
	g++ runtest.cpp -o hellorun

clean:
	rm -f BRT lex.yy.c brt.tab.h brt.tab.c helloexecs/hello* a.out
