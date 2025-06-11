.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	leiaN: .asciiz "Insira o valor de n: "
	alfabeto: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	erroN: .asciiz "O valor inserido é inválido!"
	erro: .asciiz "Erro ao alocar memória!"
	
.text
#procedimento main
main:
	jal lerN #salta para o procedimento lerN
	jal preProcessamento #salta para o procedimento preProcessamento
	j encerrar #salta para o procedimento encerrar
	
#preparação para o processamento
preProcessamento:
	sb $zero, alfabeto($t0) #adiciona o caracter nulo na posição digitada pelo usuario
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, alfabeto #carrega a string alfabeto para poder printar
	syscall #realiza a chamada de sistema
	move $t2, $zero #zerando $t2(i)
	j processamento #salta para o procedimento processamento
	
#procedimento para realizar as permutações
processamento:
	bge $t2, $t0, retornaMain #se i >= n salta para retornaMain
	mul $s5, $t2, 4 #$s5 = i * 4
	add $s0, $t1, $s5 #endereço base da pilha + i
	lw $s0, 0($s0) #carrega o valor da pilha em $s0
	bge $s0, $t2, incrementaI #se o valor lido > i salta para incrementaI
	addi $s1, $zero, 2 #carrega 2 em $s1
	div $t2, $s1 #i / 2
	mfhi $s1 #carrega o resto em $s1
	bne $s1, $zero, trocaPosicoes #se $s1 != 0 salta para trocaPosicoes
	lb $s1, alfabeto($zero) #salva em $s1 a letra em alfabeto[0]
	lb $s2, alfabeto($t2) #salva em $s2 a letra em alfabeto[i]
	sb $s2, alfabeto($zero) #troca as letras de posições
	sb $s1, alfabeto($t2) #troca as letras de posições
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, alfabeto #carrega a string alfabeto para poder printar
	syscall #realiza a chamada de sistema
	addi $s0, $s0, 1 #$s0++
	mul $s5, $t2, 4 #$s5 = i * 4
	add $s5, $t1, $s5 #endereço base da pilha + i
	sw $s0, 0($s5) #pilha[i]++
	move $t2, $zero #zera i
	j processamento #retorna ao início do laço
	
#procedimento para trocarPosicoes
trocaPosicoes:
	mul $s5, $t2, 4 #$s5 = i * 4
	add $s0, $t1, $s5 #endereço base da pilha + i
	lw $s0, 0($s0) #carrega o valor da pilha em i
	lb $s1, alfabeto($s0) #carrega em $s1 a letra do alfabeto na posição $s0
	lb $s2, alfabeto($t2) #carrega em $s2 a letra do alfabeto na posição i
	sb $s2, alfabeto($s0) #troca as letras de posições
	sb $s1, alfabeto($t2) #troca as letras de posições
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, alfabeto #carrega a string alfabeto para poder printar
	syscall #realiza a chamada de sistema
	addi $s0, $s0, 1 #$s0++
	mul $s5, $t2, 4 #$s5 = i * 4
	add $s5, $t1, $s5 #endereço base da pilha + i
	sw $s0, 0($s5) #pilha[i]++
	move $t2, $zero #zera i
	j processamento #retorna ao início do laço
	
#procedimento pra incrementar i
incrementaI:
	mul $s5, $t2, 4 #$s5 = i * 4
	add $s0, $t1, $s5 #endereço base da pilha + i
	sw $zero, 0($s0) #gurda 0 na posição i da pilha
	addi $t2, $t2, 1 #i++
	j processamento #retorna ao início do laço
	
#procedimento para alocar memória para a matriz
alocaVetor:
	mul $s0, $t0, 4 #salva em $s0 a quantidade de bytes do vetor
	li $v0, 9 #carregando 9 em $v0 para realizar a chamada de sistema
	move $a0, $s0 #copia o valor de $s0 em $a0
	syscall #aloca a memória
	move $t1, $v0 #salva o endereço base do vetor em $t1
	bgez $t1, iniciaVetor #se o apontador >= 0 salta para o procedimento iniciaVetor
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, erro #carrega a string erro para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar
	
#procedimento para ler o valor de n
lerN:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaN #carrega a string leiaN para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t0, $v0 #salva o valor lido em $t0(n)
	addi $s0, $zero, 26 #carrega 26 em $s0
	bgt $t0, $s0, saidaErro #se n > 26 salta para saidaErro
	addi $s0, $zero, 1 #carrega 1 em $s0
	blt $t0, $s0, saidaErro #se n < 1 salta para saidaErro
	j alocaVetor #salta para o procedimento alocaVetor
	
#preparação para fazer a leitura dos valores do vetor
iniciaVetor:
	addi $t2, $zero, 1 #iniciando $t2(i) com 1
	move $t3, $t1 #iniciando $t3(apontador) com o endereço base do vetor
	j carregaVetor #salta para o procedimento carregaVetor
	
#procedimento para fazer a leitura do vetor
carregaVetor:
	bgt $t2, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	sw $zero, 0($t3) #carrega 0 na posição i do vetor
	addi $t2, $t2, 1 #i++
	addi $t3, $t3, 4 #apontador desloca para a próxima posição da matriz
	j carregaVetor #retorna ao inicio do laço
	
#procedimento para avisar que a entrada é invalida
saidaErro:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, erroN #carrega a string erroN para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar
	
#procedimento para retornar ao main
retornaMain:
	jr $ra #retorna onde parou no main
	
#procedimento para encerrar o programa
encerrar:
	li $v0, 10 #carregando 10 em $v0 para encerrar o programa
	syscall #realizando a chamada de sistema