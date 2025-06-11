.data
	msg1: .asciiz "Digite valor N: "
	Arquivo: .asciiz "primoGemeo.txt"
	espaco: .asciiz " "
	buffer: .space 20
.text 
	.globl main
main:
	li $v0, 4	# codigo syscall escrever string
    	la $a0, msg1	# parâmetro ("Digite valor N: ")
    	syscall
    	
    	li $v0, 5	# codigo syscall leitura inteiro
    	syscall
    	move $s0, $v0	# s0 = N
    	
    	la $a0, Arquivo # a0 = endereço arquivo
    	li $a1, 1 	# a1 = modo escrita
    	li $v0, 13	# codigo abertura arquivo
    	syscall
    	move $s1, $v0 	# s1 = descriptor
    	
    	li $t0, 1 # i(t0) = 1
    	for_main: # (i = 1; i <= N; i++)
    		bgt $t0, $s0, fim_loop_main # if(i > N)
    		move $a0, $t0 # a0 = i
    		jal ehPrimo
    		beqz $v0, incrementa # if(return == false) jump incrementa
    		addi $a0, $a0, 2 # a0 += 2 
    		jal ehPrimo # verificar se o gemeo eh primo
    		beqz $v0, incrementa # if(return == false) jump incrementa
    		
    		li $v0, 0
    		move $a0, $t0 # a0 = num
    		la $a1, buffer # endereco buffer para armazenar a sequência de caracteres
    		jal intToString
    		
    		move $a0, $s1 # carrega descriptor
    		la $a1, buffer # a1 = i(t0) (primo que será escrito)
    		move $a2, $v0 # numero de caracteres1
    		li $v0, 15 # codigo escrever arquivo
   		syscall
    		# imprimir espaço
    		move $a0, $s1 # carrega descriptor
    		li $v0, 15 # codigo escrever arquivo
    		la $a1, espaco
    		li $a2, 1
    		syscall
    	incrementa:
    		addi $t0, $t0, 1 # i(t0)++
    		j for_main
    		
fim_loop_main:
    	move $a0, $s1	# carrega descriptor
    	li $v0, 16      # codigo syscall fechar arquivo
    	syscall
    	
    	li $v0, 10	# codigo syscall finalizar programa
    	syscall
    	

ehPrimo: # (a0 = num): bollean
	addi $sp, $sp, -4 # armazena espaço para 2 registradores
	sw $ra, 0($sp) 	 
	sw $t0, 4($sp)
	
	ble $a0, 1, false
	ble $a0, 3, true
	
	li $t0, 2 # i(t0) = 2
	for_primo: # (i = 2; i * i <= num; i++) 
		mul $t1, $t0, $t0 # t1 = i * i
		bgt $t1, $a0, true # if(i * i > num)
		div $a0, $t0 # hi = num(a0) % i(t0)
		mfhi $t2 # t2 = hi
		beqz $t2, false # if(t2 == 0) return false
		addi $t0, $t0, 1 # i(t0)++
		j for_primo
true:
	li $v0, 1 # return 1		
	j fim_primo
false:
	li $v0, 0 # return 0 
fim_primo:
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 4 # retorna espaço pilha
	jr $ra
	

intToString: # (a0 = num)
	div $a0, $a0, 10 # num(a0) = num(a0) / 10
	mfhi $t3 # t3 = resto
	subi $sp, $sp, 4 # aloca espaço para 1 registrador
	sw $t3, ($sp) # armazena o resto na pilha
	addi $v0, $v0, 1 # digitos++

	bnez $a0, intToString # if(num(a0) != 0) jump intToString
	li $t2, 0 # i(t2) = 0
	loop_intString:
		lw $t3, ($sp) # recupera o resto da pilha 
		addi $sp, $sp, 4 # libera pilha

		add $t3, $t3, 48 # converte unidade para caractere
		sb $t3, ($a1) # armazena t3 no buffer
		addi $a1, $a1, 1 # incrementa endereco do buffer(a1)
		addi $t2, $t2, 1 # i(t2)++
		bne $t2, $v0, loop_intString # if(i != digitos) jump loop
		sb $zero, ($a1)	# armazena zero no buffer de saida
	jr $ra
	