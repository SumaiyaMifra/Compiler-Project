%{
    //Required files
	#include<stdio.h>
    #include<string.h>
	#include<stdlib.h>
	#include "final.tab.h"

	extern char* strdup(const char*);
	void yyerror(char *s);
%}


HEADER	"putin"[ ]+[^\n]+[.h][ ]*
VARIABLE	[a-zA-Z][a-zA-Z0-9]*
NUMBER	[-]?[0-9][0-9]*[.]?[0-9]*
singleLineComment		[ ]*[#][#][a-zA-Z0-9@$%^&*(){}_+-,.:\|?>< ]*
multiLineComment		[ ]*[#][@][a-zA-Z0-9@$*(){}_+-,.:\|?><\n\t ]*[@][#]	

%%


[ \t]+
"start()" return(START);
"int"	return(INT);
"char"	return(CHAR);
"float"	return(FLOAT);
"double"	return(DOUBLE);
"step"	return(SWITCH);
"stair"	return(CASE);
"base"	return(DEFAULT);
"sort" return(SORT);
"alternate" return(SWAP);
"combination" return(COMBINATION);
"permutation" return(PERMUTATION);
"power"	return(POW);
"rand" return(RANDOM);
"take"	return(SCAN);
"continue" return(WHILE);
"sin" return(SIN);
"backs" return(BACKS);
"cos" return(COS);
"backc" return(BACKC);
"tan" return(TAN);
"backt" return(BACKT);
"log10" return(LOG10);
"factorial"	 return(FACTOR);
"prime"	return(ISPRIME);
"show"	return(OUTPUT);

"check"	return(IF);
"checkagain"	return(ELIF);
"otherwise"	return(ELSE);
"repeat"	return(REPEAT);
"to"	return(TO);
"+"	return(INC);
"-"	return(DEC);
"maxdetect"	return(MAX);
"mindetect"	return(MIN);
">"		return(GT);
">="	return(GOE);
"<"		return(LT);
"<="	return(LOE);
"add"		return(PLUS);
"sub"		return(MINUS);
"mul"		return(MULTI);
"div"		return(DIVI);
"=="	return(EQUALS);
"!="	return(NOTEQUAL);

{singleLineComment} 	{printf("\n A single line comment\n");}

{multiLineComment} 	{printf("\n A multi line comment\n");}

{HEADER}	printf("Header file has been included.\n");
{VARIABLE}	{yylval.varString = strdup(yytext); return(ID);}
{NUMBER}	{	int len = strlen(yytext);
			int i = 0;
			while(i<len){
				if(yytext[i]=='.'){
					yylval.var = atof(yytext); 
					return(NUM);
				}
				i++;
			}
			yylval.var = atoi(yytext); 
			return(NUM);
		}

[=,;{}()_^]	{yylval.varString = strdup(yytext); return *yytext;}

.		yyerror("Error! Invalid character inserted");

[\n]	{}

%% 

int yywrap(void){
	return 1;
}