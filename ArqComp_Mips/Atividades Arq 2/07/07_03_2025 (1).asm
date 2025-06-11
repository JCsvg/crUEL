.data
default_array: .word 5, 10, 15, 20       # Vetor padrão, usado somente se o arquivo não existir
buffer:        .space 16                # Buffer para armazenar 4 inteiros (16 bytes)
filename:      .asciiz "vet.dat"        # Nome do arquivo
error_msg:     .asciiz "Erro ao abrir o arquivo\n"
prompt:        .asciiz "Digite o indice (0-3): "
newline:       .asciiz "\n"

.text
.globl main
main:
    # Tenta abrir o arquivo em modo leitura (modo 0)
    li   $v0, 13          # syscall: open
    la   $a0, filename
    li   $a1, 0           # modo: leitura
    li   $a2, 0
    syscall
    bltz $v0, file_not_found  # Se erro, o arquivo não existe
    move $s0, $v0         # Descritor do arquivo

    # Ler o conteúdo do arquivo para o buffer (16 bytes)
    li   $v0, 14          # syscall: read
    move $a0, $s0
    la   $a1, buffer
    li   $a2, 16
    syscall

    # Fechar o arquivo de leitura
    li   $v0, 16          # syscall: close
    move $a0, $s0
    syscall
    j    proceed

file_not_found:
    # O arquivo não existe, então criamos e escrevemos o vetor padrão nele.
    li   $v0, 13          # syscall: open
    la   $a0, filename
    li   $a1, 1           # modo: escrita (cria/trunca)
    li   $a2, 0
    syscall
    bltz $v0, error_exit
    move $s0, $v0

    li   $v0, 15          # syscall: write
    move $a0, $s0
    la   $a1, default_array
    li   $a2, 16
    syscall

    li   $v0, 16          # fechar o arquivo
    move $a0, $s0
    syscall

    # Copiar o vetor padrão para o buffer, para uso posterior
    la   $t0, default_array
    la   $t1, buffer
    li   $t2, 16         # 16 bytes
copy_loop:
    beq  $t2, $zero, done_copy
    lb   $t3, 0($t0)
    sb   $t3, 0($t1)
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    addi $t2, $t2, -1
    j    copy_loop
done_copy:

proceed:
    # Solicita ao usuário o índice (0-3)
    li   $v0, 4          # syscall: print string
    la   $a0, prompt
    syscall

    li   $v0, 5          # syscall: read integer
    syscall
    move $t4, $v0        # $t4 = índice

    # Valida o índice (deve estar entre 0 e 3)
    bltz $t4, exit_program
    li   $t5, 3
    bgt  $t4, $t5, exit_program

    # Calcula o deslocamento no buffer: índice * 4 bytes
    sll  $t6, $t4, 2
    la   $t7, buffer
    add  $t7, $t7, $t6   # Endereço do elemento no buffer
    lw   $t8, 0($t7)     # Carrega o valor
    addi $t8, $t8, 1     # Incrementa
    sw   $t8, 0($t7)     # Atualiza o valor no buffer

    # Reabrir o arquivo em modo escrita para atualizar (cria/trunca)
    li   $v0, 13         # syscall: open
    la   $a0, filename
    li   $a1, 1          # modo: escrita
    li   $a2, 0
    syscall
    bltz $v0, error_exit
    move $s0, $v0

    li   $v0, 15         # syscall: write
    move $a0, $s0
    la   $a1, buffer
    li   $a2, 16
    syscall

    li   $v0, 16         # fechar o arquivo
    move $a0, $s0
    syscall

    # Opcional: Reabrir o arquivo para leitura e imprimir o vetor atualizado
    li   $v0, 13         # syscall: open
    la   $a0, filename
    li   $a1, 0          # modo: leitura
    li   $a2, 0
    syscall
    bltz $v0, error_exit
    move $s0, $v0

    li   $v0, 14         # syscall: read
    move $a0, $s0
    la   $a1, buffer
    li   $a2, 16
    syscall

    li   $v0, 16         # fechar arquivo
    move $a0, $s0
    syscall

    # Imprimir o vetor atualizado (4 inteiros)
    la   $t0, buffer
    li   $t1, 0          # contador
print_loop:
    lw   $a0, 0($t0)
    li   $v0, 1          # syscall: print integer
    syscall

    li   $v0, 11         # syscall: print char (espaço)
    li   $a0, 32
    syscall

    addi $t1, $t1, 1
    addi $t0, $t0, 4
    li   $t2, 4
    blt  $t1, $t2, print_loop

    li   $v0, 4          # imprimir nova linha
    la   $a0, newline
    syscall

exit_program:
    li   $v0, 10         # encerrar programa
    syscall

error_exit:
    li   $v0, 4          # imprimir mensagem de erro
    la   $a0, error_msg
    syscall
    li   $v0, 10
    syscall