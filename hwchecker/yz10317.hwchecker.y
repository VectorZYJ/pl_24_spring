%{
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <vector>
using namespace std;
int yylex();
bool div_zero;
vector<int> val;
vector<char> opt;
void yyerror(const char *p);
void reset();
void checkResult(vector<int> &val, vector<char> &opt);
%}

%union {
    int val;
};

%start prog
%token EOL SEP
%token LPAREN RPAREN
%token LESS GREATER EQUAL
%token PLUS MINUS MUL DIV
%token <val> NUM
%type <val> expr
%left PLUS MINUS
%left MUL DIV
%nonassoc UMINUS

%%
prog :
     | prog line EOL
     ;

line : NUM SEP cmp                  {
                                            cout << $1 << ": ";
                                            if (div_zero == false) {
                                                checkResult(val, opt);
                                            }
                                            else {
                                                yyerror("Division By Zero");
                                            }
                                            reset();
                                        }
     ;

cmp  : expr                             { val.push_back($1); }
     | cmp LESS expr                    { val.push_back($3); opt.push_back('<'); }
     | cmp GREATER expr                 { val.push_back($3); opt.push_back('>'); }
     | cmp EQUAL expr                   { val.push_back($3); opt.push_back('='); }
     ;

expr : NUM
     | expr PLUS expr                   { $$ = $1 + $3; }
     | expr MINUS expr                  { $$ = $1 - $3; }
     | expr MUL expr                    { $$ = $1 * $3; }
     | expr DIV expr                    {
                                            if ($3 == 0)
                                                div_zero = true;
                                            else
                                                $$ = $1 / $3;
                                        }
     | MINUS expr %prec UMINUS          { $$ = -$2; }
     | LPAREN expr RPAREN               { $$ = $2; }
     ;
%%

void yyerror(const char *p) {
    cerr << "Error: " << p << endl;
}

void reset() {
    val = vector<int>(0);
    opt = vector<char>(0);
    div_zero = false;
}

void checkResult(vector<int> &val, vector<char> &opt) {
    bool is_correct = true;
    int equal_count = 0;
    for (int i=0; i<opt.size(); i++)
        if (opt[i] == '=')
            equal_count++;
    if (opt.size() == 0 || equal_count > 0 && equal_count < opt.size()) {
        yyerror("syntax error");
        exit(1);
    }
    for (int i=0; i<opt.size(); i++) {
        if (opt[i] == '<') {
            if (val[i] >= val[i+1])
                is_correct = false;
        }
        else if (opt[i] == '=') {
            if (val[i] != val[i+1])
                is_correct = false;
        }
        else if (opt[i] == '>') {
            if (val[i] <= val[i+1])
                is_correct = false;
        }
    }
    if (is_correct)
        cout << "Yes" << endl;
    else
        cout << "No" << endl;
}

int main(int argc, char* argv[])
{
    if (argc != 2 || argv[1] == NULL) {
        printf("Missing filename, command line input applied.\nOr use: './calc filename' to import file.\n");
    }
    else {
        string filename = argv[1];
        freopen(filename.c_str(), "r", stdin);
    }
    yyparse();
    return 0;
}
