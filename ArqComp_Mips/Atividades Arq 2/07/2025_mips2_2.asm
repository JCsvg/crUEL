.data
	Arquivo: .space 30
    	ArquivoSaida: .asciiz "asterisco.txt"
    	Erro: .asciiz "Erro ao abrir o arquivo!\n"
    	buffer: .asciiz " "
    	msg1: .asciiz "Digite nome do arquivo: "
.text 
	.globl main
main:

	li $v0, 4	# codigo syscall escrever string
    	la $a0, msg1	# parâmetro ("Digite nome do arquivo: ")
    	syscall
    	
    	li $v0, 8	# codigo syscall leitura string
    	la $a0, Arquivo # carrega endereço Arquivo
    	li $a1, 30      # limita a 29 caracteres
    	syscall
    	
    	# a0 = $string
    	jal tamanhoString
    	
    	addi $v0, $v0, -1
    	add $t0, $v0, $a0	# t0 = endereco(a0) + indice fim
    	sb  $zero, ($t0)        # remove \n do fim da string
    	
    	la $a0, Arquivo # a0 = endereço arquivo
    	li $a1, 0 	# a1 = modo leitura
    	li $v0, 13	# codigo abertura arquivo
    	syscall
    	
    	bnez $v0, valido	# if(v0 != 0) jump valido
    	invalido:
    	li $v0, 4	# codigo syscall escrever string
    	la $a0, Erro	# parâmetro ("Erro ao abrir o arquivo!\n")
    	syscall
    	li $v0, 10	# codigo syscall finalizar programa
    	syscall
    	
	valido:
	move $s0, $v0	# s0 = descriptor arquivo
	
	la $a0, ArquivoSaida # a0 = endereço arquivo
    	li $a1, 1 	# a1 = modo escrita
    	li $v0, 13	# codigo abertura arquivo
    	syscall
    	
    	beqz $v0, invalido 	# if(v0 == 0) jump invalido
    	move $s1, $v0	# s0 = descriptor arquivoSaida
    	
    	jal asterisco
    	
        li $v0, 16	# codigo fechar arquivo
        move $a0, $s0   # a0 = descriptor
        syscall            

        li $v0, 16      # codigo fechar arquivo
        move $a0, $s1   # a0 = descriptor arquivoSaida
        syscall            
    	
    	li $v0, 10	# codigo syscall finalizar programa
    	syscall


tamanhoString: # (a0 = &string)
	addi $sp, $sp, -4 # armazena espaço para 1 registrador
	sw $ra, 0($sp) 	
    	li $t0, 0 # tamanho(t0) = 0
   	move $t1, $a0 # t1 = &string

    	loop_tamanho:
        	lb $t2, ($t1) # t2 = string[i]
        	beqz $t2, fim_tamanho # if(string[i] == 0) jump fim_tamanho
        	addi $t0, $t0, 1 # tamanho(t0)++
        	addi $t1, $t1, 1 # string[i++]
        j loop_tamanho # retorna loop

fim_tamanho:
    	move $v0, $t0     # v0 = tamanho(t0)
    	jr $ra
    	
    	
asterisco: # (s0 = descriptor arquivo, s1 = descriptor arquivoSaida)
	addi $sp, $sp, -4 # armazena espaço para 1 registrador
	sw $ra, 0($sp)
	
	loop_asterisco:
	li $v0, 14     # codigo leitura arquivo arquivo
        move $a0, $s0  # a0 = descriptor arquivo
        la $a1, buffer # a1 = &buffer
        li $a2, 1      # a2 = 1
        syscall	
        					
        blez $v0, fim_asterisco  # chegou ao fim do arquivo
        lb $t0, ($a1) # t0 = caractere lido
        beq $t0, 'a', vogal
        beq $t0, 'A', vogal
        beq $t0, 'e', vogal
        beq $t0, 'E', vogal
        beq $t0, 'i', vogal
        beq $t0, 'I', vogal
        beq $t0, 'o', vogal
        beq $t0, 'O', vogal
        beq $t0, 'u', vogal
        beq $t0, 'U', vogal
        continue:
        li $v0, 15	# codigo escrita arquivo
        move $a0, $s1  # a0 = descriptor arquivoSaida
        la $a1, buffer # a1 = &buffer
        li $a2, 1	# a2 = 1
        syscall						
        j loop_asterisco # retorna loop
vogal:	li $t1, '*'      
        sb $t1, ($a1)
        j continue
        
fim_asterisco:
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # retorna espaço pilha
	jr $ra
	