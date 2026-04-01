/* 1. SEÇÃO DE DEFINIÇÕES */
%option noyywrap

%%
    /* Lembrete: Este recuo é necessário para comentários na Seção de Regras */
    /* 2. SEÇÃO DE REGRAS */

"if"                    { printf("%s IF\n", yytext); }

[a-z][a-z0-9]* { printf("%s ID\n", yytext); }

[0-9]+                  { printf("%s NUM\n", yytext); }

[0-9]+\.[0-9]* { printf("%s REAL\n", yytext); }
\.[0-9]+                { printf("%s REAL\n", yytext); }

"--"[a-z]*\r?\n         { 
                            /* O autômato exige o \n para aceitar o comentário. */
                            /* Aqui nós apagamos a quebra de linha da string 'yytext' apenas para a impressão ficar bonita e igual ao gabarito */
                            if(yytext[yyleng-1] == '\n') yytext[--yyleng] = '\0';
                            if(yytext[yyleng-1] == '\r') yytext[--yyleng] = '\0';
                            
                            printf("%s comment\n", yytext); 
                        }

[ \t]+                  { printf("white space\n"); }

\n|\r                   { /* Quebras de linha isoladas devem ser ignoradas conforme o enunciado */ }

.                       { printf("%s error\n", yytext); }

%%
    /* 3. SEÇÃO DE CÓDIGO AUXILIAR */

int main(int argc, char** argv) {
    yylex();
    return 0;
}