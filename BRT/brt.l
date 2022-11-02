%option noyywrap
%option nodefault

%{
        #include<string>
        #include"brt.tab.h"
        #include<iostream>
        using std::stoi;
%}

%%
(as)      { return T_AS; }
(with)    { return T_WITH; }
(compile)  { return T_COMPILE;}
(run)     { return T_RUN; }
(move)    { return T_MOVE; }
(quit)    { return T_QUIT; }
(and)     { return T_AND; }
g\+{2} { return T_GPLUSPLUS; }
g\c{2} { return T_GMINMIN; }
[A-Za-z_][A-Za-z_0-9]*  { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_EXECUTABLE; }
[A-Za-z_][A-Za-z_0-9]*[\.][a-z][a-z][a-z]  { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_FILENAME; }
[\.\/A-Za-z]* { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_DESTINATION; }
[ \t\n] /* */
.
 /*



(output)     { return T_OUTPUT; }
(to)    { return T_TO; } */


%%
