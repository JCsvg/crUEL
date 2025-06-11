.data
input_filename:      .asciiz "matriz.txt"
output_filename:     .asciiz "matriz saida.txt"
inBuffer:            .space 1024         # Buffer para o conteúdo do arquivo de entrada
rowBuffer:           .space 256          # Buffer para construir cada linha de saída
errorMsg:            .asciiz "Erro ao abrir o arquivo.\n"

        .text
        .globl main

main:
    # --- 1. Abrir o arquivo de entrada e ler seu conteúdo ---
    la   $a0, input_filename      # Endereço do nome do arquivo
    li   $a1, 0                   # Modo leitura
    li   $v0, 13                  # Syscall: abrir arquivo
    syscall
    move $t0, $v0                 # $t0 <- descritor do arquivo de entrada

    la   $a1, inBuffer            # Endereço do buffer
    li   $a2, 1024                # Tamanho máximo do buffer
    move $a0, $t0                 # Descritor do arquivo
    li   $v0, 14                 # Syscall: ler arquivo
    syscall

    # Fechar o arquivo de entrada
    move $a0, $t0
    li   $v0, 16
    syscall

    # --- 2. Inicializar ponteiro de leitura para o buffer ($s0) ---
    la   $s0, inBuffer

    # --- 3. Ler dimensões e quantidade de anulações ---
    jal  readInt         # Lê número de linhas
    move $s2, $v0       # $s2 <- rows
    jal  readInt         # Lê número de colunas
    move $s3, $v0       # $s3 <- cols
    jal  readInt         # Lê quantidade de posições a anular
    move $s4, $v0       # $s4 <- quantidade de anulações

    # --- 4. Alocar memória para a matriz (rows * cols * 4 bytes) ---
    mul  $t0, $s2, $s3         # t0 = rows * cols
    li   $t1, 4
    mul  $t0, $t0, $t1         # t0 = total de bytes necessários
    move $a0, $t0
    li   $v0, 9               # Syscall: sbrk (alocar memória)
    syscall
    move $s1, $v0             # $s1 aponta para o início da matriz

    # --- 5. Inicializar a matriz com 1's ---
    li   $t0, 0              # i = 0 (linha)
init_rows:
    bge  $t0, $s2, init_done # Se i >= rows, fim da inicialização
    li   $t1, 0              # j = 0 (coluna)
init_cols:
    bge  $t1, $s3, next_row  # Se j >= cols, vai para a próxima linha
        # Calcula o offset: offset = ((i * cols + j) * 4)
        mul  $t2, $t0, $s3
        add  $t2, $t2, $t1
        sll  $t2, $t2, 2
        add  $t2, $s1, $t2    # t2 aponta para matriz[i][j]
        li   $t3, 1
        sw   $t3, 0($t2)      # Armazena 1 na posição
        addi $t1, $t1, 1
        j    init_cols
next_row:
    addi $t0, $t0, 1
    j    init_rows
init_done:

    # --- 6. Anular as posições especificadas ---
    # Usamos $s7 como contador para que as chamadas a readInt não sobrescrevam o valor.
    li   $s7, 0            # $s7 <- contador de anulações
annul_loop:
    bge  $s7, $s4, annul_done  # Se contador >= quantidade de anulações, encerra
    jal  readInt            # Lê índice da linha (resultado em $v0)
    move $a0, $v0          # a0 = linha
    jal  readInt            # Lê índice da coluna (resultado em $v0)
    move $a1, $v0          # a1 = coluna
    jal  setZeroAt         # Chama sub-rotina para zerar matriz[linha][coluna]
    addi $s7, $s7, 1       # Incrementa o contador de anulações
    j    annul_loop
annul_done:

    # --- 7. Abrir o arquivo de saída para escrita ---
    la   $a0, output_filename
    li   $a1, 1              # Modo escrita
    li   $v0, 13             # Syscall: abrir arquivo
    syscall
    move $s5, $v0            # $s5 <- descritor do arquivo de saída

    # --- 8. Gerar a saída: percorrer a matriz e montar cada linha ---
    li   $t0, 0            # i = 0 (linha)
print_rows:
    bge  $t0, $s2, end_print   # Se i >= rows, fim
    la   $t3, rowBuffer    # t3 aponta para rowBuffer
    move $t4, $t3         # t4 é o ponteiro corrente no buffer
    li   $t1, 0           # j = 0 (coluna)
print_cols:
    bge  $t1, $s3, finish_row  # Se j >= cols, finaliza a linha
        # Calcula o endereço da célula: endereço = matriz_base + ((i*cols + j)*4)
        mul  $t5, $t0, $s3
        add  $t5, $t5, $t1
        sll  $t5, $t5, 2
        add  $t5, $s1, $t5
        lw   $t6, 0($t5)       # Carrega o valor (0 ou 1)
        addi $t6, $t6, 48      # Converte para ASCII ('0' ou '1')
        sb   $t6, 0($t4)
        addi $t4, $t4, 1
        addi $t1, $t1, 1       # Próxima coluna
        blt  $t1, $s3, add_space_print
        j    print_cols
add_space_print:
        li   $t7, 32          # ASCII do espaço
        sb   $t7, 0($t4)
        addi $t4, $t4, 1
        j    print_cols
finish_row:
    li   $t7, 10             # ASCII da nova linha
    sb   $t7, 0($t4)
    addi $t4, $t4, 1
    sb   $zero, 0($t4)       # Termina a string com '\0'
    # Imprime a linha no console
    move $a0, $t3
    li   $v0, 4
    syscall
    # Escreve a linha no arquivo de saída
    sub  $a2, $t4, $t3       # Calcula o tamanho da string
    move $a0, $s5           # Descritor do arquivo de saída
    la   $a1, rowBuffer
    li   $v0, 15           # Syscall: escrever no arquivo
    syscall
    addi $t0, $t0, 1       # Próxima linha
    j    print_rows
end_print:
    # --- 9. Fechar o arquivo de saída e encerrar o programa ---
    move $a0, $s5
    li   $v0, 16
    syscall
    li   $v0, 10
    syscall

###########################################################################
# Sub-rotina: setZeroAt
# Entrada:
#   $a0 = linha, $a1 = coluna
# Usa:
#   $s1 = base da matriz, $s3 = número de colunas
# Calcula: endereço = base + ((linha * cols + coluna) * 4)
# E armazena 0 nesse endereço.
###########################################################################
setZeroAt:
    mul   $t0, $a0, $s3    # t0 = linha * cols
    add   $t0, $t0, $a1    # t0 = linha * cols + coluna
    sll   $t0, $t0, 2      # t0 = (linha * cols + coluna) * 4
    add   $t0, $s1, $t0    # t0 aponta para matriz[linha][coluna]
    sw    $zero, 0($t0)    # Armazena 0 na posição
    jr    $ra

###########################################################################
# Sub-rotina: readInt
# Lê um inteiro do buffer apontado por $s0, ignorando todos os caracteres que não 
# sejam dígitos (ASCII 48 a 57). Retorna o inteiro lido em $v0 e atualiza $s0.
###########################################################################
readInt:
readInt_skip:
    lb   $t0, 0($s0)
    li   $t1, 48      # '0'
    li   $t2, 57      # '9'
    blt  $t0, $t1, readInt_skip_inc
    bgt  $t0, $t2, readInt_skip_inc
    j    readInt_start
readInt_skip_inc:
    addi $s0, $s0, 1
    j    readInt_skip
readInt_start:
    li   $v0, 0
readInt_loop:
    lb   $t0, 0($s0)
    li   $t1, 48      # '0'
    li   $t2, 57      # '9'
    blt  $t0, $t1, readInt_done
    bgt  $t0, $t2, readInt_done
    mul  $v0, $v0, 10
    sub  $t3, $t0, $t1  # Converte caractere para dígito
    add  $v0, $v0, $t3
    addi $s0, $s0, 1
    j    readInt_loop
readInt_done:
    jr   $ra