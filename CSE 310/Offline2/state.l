%option noyywrap


%{

#include<stdio.h>
#include<stdlib.h>
	



%}


%%
		}

%%
int main(int argc,char *argv[]){
	
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");

	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	

	yyin= fin;
	yylex();

	fclose(yyin);
	return 0;
}
