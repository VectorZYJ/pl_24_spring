%{
#include <iostream>
#include<stdlib.h>
using namespace std;
#include "yz10317.hwchecker.tab.h"
%}

%option noyywrap

%%
[0-9]+                  { yylval.val = atoi(yytext); return NUM; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
":"                     { return SEP; }
\n                      { return EOL; }
"<"                     { return LESS; }
">"                     { return GREATER; }
"="                     { return EQUAL; }
[ \t\r]                 { }
.                       { cerr << "Error: syntax error" << endl; exit(1); }
%%
