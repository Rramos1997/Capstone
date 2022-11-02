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
g\+{2}|g\-{2} { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_STRING_CONSTANT; }
[A-Za-z_][A-Za-z_0-9]*  { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_STRING_CONSTANT; }
[A-Za-z_][A-Za-z_0-9]*[\.][a-z][a-z][a-z]  { std::string val = std::string(yytext); val = val.substr(0,val.size()); yylval.union_string = new std::string(val); return T_STRING_CONSTANT; }
[ \t\n] /* */
.
 /*(and)     { return T_AND; }

(run)     { return T_RUN; }
(move)    { return T_MOVE; }
(output)     { return T_OUTPUT; }
(to)    { return T_TO; } */


%%
