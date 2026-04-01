    /* 1. SEÇÃO DE DEFINIÇÕES */
    /* Desabilita a necessidade de importar a biblioteca externa do flex (-lfl) */
%option noyywrap

%%
    /* 2. SEÇÃO DE REGRAS */

"+"                     { printf("%s\n", yytext); }
"-"                     { printf("%s\n", yytext); }

[a-z][a-z0-9]* { printf("%s\n", yytext); }

[0-9]+                  { printf("%s\n", yytext); }
[0-9]+e[+-]?[0-9]+      { printf("%s\n", yytext); }

\n|\r                   { /* Quebras de linha devem ser ignoradas */ }

.                       { printf("ERRO\n"); }

%%
    /* 3. SEÇÃO DE CÓDIGO AUXILIAR (C/C++) */

int main(int argc, char** argv) {
    // Inicia a leitura e análise léxica da entrada padrão
    yylex();
    return 0;
}