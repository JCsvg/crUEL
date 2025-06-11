.data
	msg1: .asciiz "Entre com o número de elementos: "
	msg2: .asciiz "Vet["
	msg3: .asciiz "]= "
	msg4: .asciiz "a) O maior elemento do vetor é "
	msg5: .asciiz " e sua posição é "
	msg6: .asciiz "; o menor elemento do vetor é "
	msg7: .asciiz " e sua posição é "
	msg8: .asciiz "b) O número de elementos pares é = "
	msg9: .asciiz " e o número de elementos ímpares é = "
	msg10: .asciiz "c) A soma dos elementos é = "
	msg11: .asciiz " e o produto dos elementos é "
	newline: .asciiz "\n"

.text
.globl main
main:
    # msg para entrada do número de elementos
    li $v0, 4
    la $a0, msg1
    syscall

    # lê o número de elementos
    li $v0, 5
    syscall
    move $t0, $v0  # $t0 = n

    # aloc dinâmica do vet
    sll $a0, $t0, 2
    li $v0, 9
    syscall
    move $s0, $v0  # $s0 = endereço do vet

    li $t1, 0  # Índice do vet
    move $s1, $s0  # Ponteiro para percorrer o vet

input_loop:
    bge $t1, $t0, process  # Se índice >= n, vai para processamento

    # Exibe "Vet[i]= "
    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 1
    addiu $a0, $t1, 1  # Corrige índice para começar em 1
    syscall

    li $v0, 4
    la $a0, msg3
    syscall

    # Lê elemento
    li $v0, 5
    syscall
    sw $v0, 0($s1)

    # Atualiza ponteiro e índice
    addiu $s1, $s1, 4
    addiu $t1, $t1, 1
    j input_loop

process:
    lw $t2, 0($s0)  # t2 = maior
    lw $t3, 0($s0)  # t3 = menor
    li $t4, 1       # pos_maior = 1
    li $t5, 1       # pos_menor = 1
    li $t6, 0       # pares
    li $t7, 0       # ímpares
    li $t8, 0       # soma
    li $t9, 1       # produto
    li $t1, 1       # índice ajustado para iniciar em 1
    move $s1, $s0

process_loop:
    bgt $t1, $t0, output  # Se índice > n, vai para saída

    lw $a1, 0($s1)  # Carrega elemento atual

    add $t8, $t8, $a1  # Soma
    mul $t9, $t9, $a1  # Produto

    # Verifica maior
    ble $a1, $t2, check_menor
    move $t2, $a1
    move $t4, $t1

check_menor:
    bge $a1, $t3, check_paridade
    move $t3, $a1
    move $t5, $t1

check_paridade:
    rem $a2, $a1, 2
    beqz $a2, is_par
    addi $t7, $t7, 1  # Ímpar
    j next_iter

is_par:
    addi $t6, $t6, 1  # Par

next_iter:
    addiu $s1, $s1, 4
    addiu $t1, $t1, 1
    j process_loop

output:
    # Exibe resultado
    li $v0, 4
    la $a0, msg4
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, msg5
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, msg6
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, msg7
    syscall

    li $v0, 1
    move $a0, $t5
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, msg8
    syscall

    li $v0, 1
    move $a0, $t6
    syscall

    li $v0, 4
    la $a0, msg9
    syscall

    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, msg10
    syscall

    li $v0, 1
    move $a0, $t8
    syscall

    li $v0, 4
    la $a0, msg11
    syscall

    li $v0, 1
    move $a0, $t9
    syscall

    li $v0, 10
    syscall