.data
	msg1: .asciiz "Insira a string 1: "
	msg2: .asciiz "Insira a string 2: "
	msg3: .asciiz "String intercalada: "
	quebraLinha: .ascii "\n"
	str1: .space 100
	str2: .space 100
	str3: .space 200
	
.text
	.globl main
main:
	la $a0, msg1	# parametro ("Insira a string 1: ")
	la $a1, str1	# parametro: endereco da string 1
	jal leitura
	
	la $a0, str1	# parametro: endereco da string 1
	jal tamanho
	add $s0, $zero, $v0 # $s0 = tamanho da string 1
	
	
	la $a0, msg2	# parametro ("Insira a string 2: ")
	la $a1, str2	# parametro: endereco da string 2
	jal leitura
	
	la $a0, str2	# parametro: endereco da string 2
	jal tamanho
	add $s1, $zero, $v0 # $s1 = tamanho da string 2
	
	
	la $a0, str1	# parametro: endereco da string 1
	la $a1, str2	# parametro: endereco da string 2
	la $a2, str3	# parametro: endereco da string 3
	jal intercala
	
	la $a0, msg3	# parametro ("String intercalada: ")
	la $a1, str3	# parametro: endereco da string 3 (intercala)
	jal imprimir
	
	li $v0, 10	# codigo finalizar programa
	syscall
	
	
leitura:
	li $v0, 4	# codigo de impressao de string
	syscall
	move $a0, $a1	# endereco string para leitura
	li $a1, 100	# numero max de caracteres
	
	li $v0, 8	# codigo leitura string
	syscall
	
	jr $ra		# retorna para main
	
	
imprimir: # (a0 = endereço da mensagem a ser impressa antes, a1 = endereço da string a ser impressa)
	li $v0, 4	# codigo de impressao de string
	syscall 	# parametro ("String: " )
		
	la $a0, ($a1)	# $a0 = endereco string($a1)
	syscall 	# impressao da string
		
	jr $ra		# retorna para main
	
	
tamanho: # (a0 = endereço da string)
	addi $sp, $sp, -4
	sw $s0, 0($sp) 	# empilhando registrador(es) save
		
	li $s0, 0 	# tamanho string($s0) = 0
	la $t0, ($a0) 	# t0 = endereço base da string
	li $t1, 0 	# i($t1) = 0 
		
	lbu $t4, quebraLinha	# $t4 = '\n'
		
	loop_tamanho:
		add $t2, $t1, $t0	# $t2 = deslocamento + endereço base do vetor ($t2 == &string[i])
		lbu $t3, 0($t2)		# $t3 = string[i]
			
		beq $t3, $t4, fim_tamanho	# if($t3 == '\n') sair do loop
		beq $t3, $zero, fim_tamanho	# if($t3 == '\0') sair do loop
				
		addi $s0, $s0, 1	# tamanho string($s0)++
		addi $t1, $t1, 1 	# i($t1)++
		j loop_tamanho
			
	fim_tamanho:
		move $v0, $s0	# $v0 = tamanho string($s0)
		lw $s0, 0($sp) 	# desempilhando registrador(es) save
		addi $sp, $sp, 4 
		jr $ra		# retorna para main

	
intercala: # (a0 = endereco da str1, a1 = endereco str2, a2 = endereco str3)
	# $s0 = tamanho string 1
	# $s1 = tamanho string 2
	blt $s0, $s1, else	# se tamanho str1 < tamanho str2 jump else
	# str1($s0) > str2($s1)
	la $t1, ($a0)	# enderecoMaior($t1) = endereco str1
	la $t0, ($a1)	# enderecoMenor($t0) = endereco str2
	
	add $t2, $zero, $s0	# temp($t0) = tamanhoStr1($s0)
	move $s0, $s1		# tamanhoStr1($s0) = tamanhoStr2($s1)
	move $s1, $t2		# tamanhoStr2($s1) = tamanhoStr1($s0)
	# fazendo o $s1 ser sempre > $s0
	j c	# jump para c (pula o else)
	
	else:
	# str1($s0) < str2($s1)
	la $t1, ($a1)	# enderecoMaior($t1) = endereco str2
	la $t0, ($a0)	# enderecoMenor($t0) = endereco str1
	
c:	li $t2, 0 	# i($t2) = 0;
	li $t3, 0	# j($t3) = 0;
	la $s2, str3	# s2 = endereco string 3 (string intercalada)
		
	loop1_inter: # de i=0 até length(stringMenor($t0)) - 1
	
		add $t4, $t2, $t0 	# t4 = deslocamento i + endereço base string menor (t4 == &menor[i])
		add $t5, $t2, $t1 	# t5 = deslocamento i + endereço base string maior (t5 == &maior[i])
								
		lbu $t6, 0($t4) 	# t6 = stringMenor[i]
		lbu $t7, 0($t5) 	# t7 = stringMaior[i]
			
		add $t9, $t3, $s2 	# t9 = deslocamento j + endereço base string_inter (t9 == &string_inter[j])
		sb $t6, ($t9) 		# guarda o byte (caractere) atual da stringMenor($t6) na string_intercala
		addi $t3, $t3, 1 	# j($t3)++
		
		add $t9, $t3, $s2 	# t9 = deslocamento j + endereço base string_inter (t9 == &string_inter[j])
		sb $t7, ($t9)		# guarda o byte (caractere) atual da stringMaior($t7) na string_intercala
		addi $t3, $t3, 1 	# j($t3)++

		addi $t2, $t2, 1 	# i($t2)++
		blt $t2, $s0, loop1_inter # se i($t2) < tamanhoMenor($s0) continuar loop
		
	loop2_inter: # de i(atual) até length(stringMaior($t1)) - 1
			
		bge $t2, $s1, fim	 # se i($t2) >= tamanhoMaior($s1) sair do loop
			
		add $t5, $t2, $t1 	# $t5 = deslocamento i + endereço base string maior (t5 == &maior[i])
		lbu $t7, 0($t5) 	# $t7 = stringMaior[i]
		 	
		add $t9, $t3, $s2 	# t9 = deslocamento j + endereço base string_inter (t9 == &string_inter[j])
		sb $t7, ($t9) 		# guarda o byte (caractere) atual da stringMaior($t7) na string_intercala
		addi $t3, $t3, 1 	# j($t3)++
			
		addi $t2, $t2, 1	# i($t2)++
		j loop2_inter		# retorna loop
		
	fim:	
		move $v0, $a2	# $v0 = string intercala($a2)
		jr $ra
	