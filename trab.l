
Autor: Antônio Andson da Silva - Ciência da Computação - Campus Quixadá

%{

#include<iostream>
#include<string>
#include<sstream>
#include<list>

using namespace std;

list<string> listaF;
list<string> listaI;
list<string> lVarI;
list<string> lVarF;
list<string>::iterator it;


%}

%{

string formatarSF(string ss){
	
	string ret = "";	
	
	for(int i = 5; i < ss.length()-1; i++){
		if(ss[i] != ' ')
			ret +=  ss[i];
	}
	 
	return ret;

}

string formatarSI(string ss){
	
	string ret = "";	
	
	for(int i = 3; i < ss.length()-1; i++){
		if(ss[i] != ' ')
			ret +=  ss[i];
	}
	 
	return ret;

}

void formatarSIV(string ss){
	
	string ret = "";	
	
	for(int i = 3; i < ss.length()-1; i++){
			
			while((ss[i] != ' ') and (ss[i] != ',') and (ss[i] != ';')){

				ret +=  ss[i];
				i++;

			}

			if((ret != "int") and (ret != "")){
				lVarI.push_back(ret);
				ret = "";
			}else{
				ret = "";
			}

	}
	 
}

void formatarSFV(string ss){
	
	string ret = "";	
	
	for(int i = 5; i < ss.length()-1; i++){
			
			while((ss[i] != ' ') and (ss[i] != ',') and (ss[i] != ';') and (ss[i] != ')') ){

				ret +=  ss[i];
				i++;

			}

			if((ret != "float") and (ret != "")){
				lVarF.push_back(ret);
				ret = "";
			}else{
				ret = "";
			}

	}
	 
}


%}

letra_maiusc	[A-Z]
letra_minusc  	[a-z]
letra  	{letra_maiusc}|{letra_minusc}
digito  [0-9]
identificador	{letra}({letra}|{digito})*

tipo (int|float)
espaco [ ]


%%

float{espaco}+{identificador}{espaco}*"(" 	{ 	listaF.push_back(formatarSF(yytext));	}
int{espaco}+{identificador}{espaco}*"(" 	{ 	listaI.push_back(formatarSI(yytext));	}
										 			


int{espaco}+{identificador}({espaco}|","|";"|{identificador})*	{ formatarSIV(yytext);	}
float{espaco}+{identificador}({espaco}|","|";"|float|")"|{identificador})*	{ formatarSFV(yytext);	}



.|\n ;

%%

int yywrap(void){
	return 1;
}

int main(){
	yylex();

	cout << "Variáveis Inteiras:" << endl;	
	for(it = lVarI.begin(); it != lVarI.end(); it++){
		
			cout << " " << *it << " ";

	}
	cout << endl;
	cout << "Total de Variáveis Inteiras: " << lVarI.size() << endl << endl;

	cout << "Variáveis Ponto Flutuante:" << endl;	
	for(it = lVarF.begin(); it != lVarF.end(); it++){
		
			cout << " " << *it << " ";

	}
	cout << endl;
	cout << "Total de Variáveis Ponto Flutuante: " << lVarF.size() << endl << endl;
	
	cout << "Funções Inteiras:" << endl;	
	for(it = listaI.begin(); it != listaI.end(); it++){
		
			cout << " " << *it << " ";

	}
	cout << endl;
	cout << "Total de Funções Inteiras: " << listaI.size() << endl << endl;

	cout << "Funções Ponto Flutuante:" << endl;	
	for(it = listaF.begin(); it != listaF.end(); it++){
		
			cout << " " << *it << " ";

	}
	cout << endl;
	cout << "Total de Ponto Flutuante: " << listaF.size() << endl << endl;

	return 0;

}

