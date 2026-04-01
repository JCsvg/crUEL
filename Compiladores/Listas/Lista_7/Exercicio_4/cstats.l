/* 1. SEÇÃO DE DEFINIÇÕES */
%option noyywrap

    /* Declaramos um estado exclusivo para tratar comentários de múltiplas linhas */
%x C_COMMENT

%{
#include <stdio.h>

int total_lines = 0;
int blank_lines = 0;
int comment_lines = 0;
int nb_nc_lines = 0;
int semi_colons = 0;
int preproc_direct = 0;

int is_blank = 1;           // Começa assumindo que a linha é em branco
int has_comment = 0;        // Começa assumindo que não tem comentário
int in_comment_block = 0;   // Controla se estamos no meio de um /* ... */
%}

%%
    /* 2. SEÇÃO DE REGRAS */

    /* Regras para Comentários de Múltiplas Linhas */
"/*"                    { has_comment = 1; in_comment_block = 1; is_blank = 0; BEGIN(C_COMMENT); }
<C_COMMENT>"*/"         { has_comment = 1; in_comment_block = 0; is_blank = 0; BEGIN(INITIAL); }
<C_COMMENT>[ \t\r]+     { /* Espaços dentro do comentário não tiram o status de linha em branco */ }
<C_COMMENT>\n           {
                            total_lines++;
                            if (is_blank) blank_lines++;
                            if (has_comment) comment_lines++;
                            if (!is_blank && !has_comment) nb_nc_lines++;
                            
                            // Reseta as flags para a próxima linha
                            is_blank = 1;
                            has_comment = in_comment_block; // Se ainda estamos no bloco, a próxima linha já começa com comentário
                        }
<C_COMMENT>.            { is_blank = 0; }

    /* Comentário de linha única */
"//".* { has_comment = 1; is_blank = 0; }

    /* Strings e Chars (Ignora ; ou // que estiverem dentro de aspas) */
\"([^\"\n\\]|\\.)*\"    { is_blank = 0; }
\'([^\'\n\\]|\\.)*\'    { is_blank = 0; }

    /* Diretivas de Pré-processador (devem estar no início da linha) */
^[ \t]*#[ \t]*include   { preproc_direct++; is_blank = 0; }
^[ \t]*#[ \t]*define    { preproc_direct++; is_blank = 0; }

    /* Ponto e vírgula */
";"                     { semi_colons++; is_blank = 0; }

    /* Espaços e Tabulações genéricas */
[ \t\r]+                { /* Não alteram a flag is_blank */ }

    /* Fim de linha padrão (fora de blocos de comentário) */
\n                      {
                            total_lines++;
                            if (is_blank) blank_lines++;
                            if (has_comment) comment_lines++;
                            if (!is_blank && !has_comment) nb_nc_lines++; // nb, nc: Não é em branco E não tem comentário
                            
                            // Reseta as flags para a próxima linha
                            is_blank = 1;
                            has_comment = in_comment_block; 
                        }

    /* Qualquer outro caractere (código fonte normal) */
.                       { is_blank = 0; }

%%

    /* 3. SEÇÃO DE CÓDIGO AUXILIAR */
int main(int argc, char** argv) {
    // Totais acumulados para imprimir a última linha
    int tot_lines = 0, tot_blank = 0, tot_comm = 0, tot_nb_nc = 0;
    int tot_semi = 0, tot_prep = 0;

    // Imprime o cabeçalho da tabela formatado de acordo com o gabarito
    printf("total  blank lines w/ nb, nc   semi preproc. file\n");
    printf("lines  lines comments  lines colons  direct.\n");
    printf("-----+ ------ -------- ------ ------ ------- ----\n");

    // Verifica se algum arquivo foi passado por argumento
    if (argc < 2) {
        printf("ERRO: Passe os arquivos como argumento. Ex: ./cstats main.c\n");
        return 1;
    }

    // Loop que varre todos os arquivos passados na linha de comando
    for (int i = 1; i < argc; i++) {
        FILE *f = fopen(argv[i], "r");
        if (!f) {
            perror(argv[i]); // Se o arquivo não existir, avisa e pula para o próximo
            continue;
        }
        
        // Redireciona a entrada do Flex (yyin) para o arquivo atual
        yyin = f;
        
        // Zera os contadores do arquivo para iniciar a leitura
        total_lines = 0; blank_lines = 0; comment_lines = 0;
        nb_nc_lines = 0; semi_colons = 0; preproc_direct = 0;
        is_blank = 1; has_comment = 0; in_comment_block = 0;
        
        BEGIN(INITIAL); // Garante que começamos no estado normal
        
        yylex(); // Roda a análise!
        
        fclose(f);
        
        // Imprime a linha com as estatísticas do arquivo atual [cite: 476-483]
        printf("%5d %6d %8d %6d %6d %7d %s\n", 
               total_lines, blank_lines, comment_lines, nb_nc_lines, semi_colons, preproc_direct, argv[i]);
        
        // Acumula os valores para a linha final 'total'
        tot_lines += total_lines;
        tot_blank += blank_lines;
        tot_comm += comment_lines;
        tot_nb_nc += nb_nc_lines;
        tot_semi += semi_colons;
        tot_prep += preproc_direct;
    }

    // Se mais de um arquivo foi lido, imprime a linha final somatória 
    if (argc > 2) {
        printf("%5d %6d %8d %6d %6d %7d total\n", 
               tot_lines, tot_blank, tot_comm, tot_nb_nc, tot_semi, tot_prep);
    }

    return 0;
}