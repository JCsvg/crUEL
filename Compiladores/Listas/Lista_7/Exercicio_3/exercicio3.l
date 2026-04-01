/* 1. SEÇÃO DE DEFINIÇÕES */
%option noyywrap

%%
    /* 2. SEÇÃO DE REGRAS */

    /* Ação 1: Prioridade Máxima */
(aba)+      { printf("%s (action 1)\n", yytext); }

    /* Ação 2: Prioridade Média. O parêntese do (b*) é opcional no Flex */
ab*a        { printf("%s (action 2)\n", yytext); }

    /* Ação 3: Prioridade Mínima */
a|b         { printf("%s (action 3)\n", yytext); }

    /* Ignorar quebras de linha e tratar erros (boa prática) */
\n|\r       { /* Ignora */ }
.           { printf("%s (erro)\n", yytext); }

%%
    /* 3. SEÇÃO DE CÓDIGO AUXILIAR */
int main(int argc, char** argv) {
    yylex();
    return 0;
}