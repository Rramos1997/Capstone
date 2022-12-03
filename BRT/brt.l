%option noyywrap
%option nodefault

%{
        #include<string>
        #include"brt.tab.h"
        #include<iostream>
        using std::stoi;
%}

%%

(DETAILS)|(Details)|(details)|(-v)|(verbose)  { return T_DETAILS; }
(show)|(Show)|(SHOW)    {return T_SHOW; }
(to)|(TO)     {return T_TO; }
(as)|(AS)|(As)|(aS)  { return T_AS; }
(with)|(WITH)|(With)    { return T_WITH; }
(compile)|(COMPILE)|(Compile)  { return T_COMPILE;}
(run)|(RUN)|(Run)|(RUn)|(rUN)|(ruN)     { return T_RUN; }
(move)|(MOVE)|(Move)|(MOve)|(MOVe)    { return T_MOVE; }
(quit)    { return T_QUIT; }
(and)|(AND)|(And)    { return T_AND; }
[gG]\+{2} { return T_GPLUSPLUS; }
[gG]\c{2} { return T_GMINMIN; }
(\.{1,2}\/|[a-zA-Z]+\/)*([a-zA-z]+[a-zA-Z0-9]*\.[a-zA-Z]{1,3})  { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_FILENAME; }
(\.{1,2}\/|[a-zA-Z]+\/)*[a-zA-z]+[a-zA-Z0-9]*\/(\/[a-zA-Z0-9]*)*|(\.{1,2}\/)|(\/[a-zA-Z]+)\/+ { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_DESTINATION; }
(\.{1,2}\/|[a-zA-Z0-9]+\/)*([a-zA-z]+[a-zA-Z0-9]*)  { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_EXECUTABLE; }
[ \t\n] /* */
.
 /*



(output)     { return T_OUTPUT; }
(to)    { return T_TO; } */


%%
