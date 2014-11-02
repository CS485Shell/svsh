main(){
	yylex();  	//the scanner
	yyparse();	//the parser
	return 0;
}
