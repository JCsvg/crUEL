.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	leiaN: .asciiz "Insira o valor de n: "
	leia1X: .asciiz "Insira o "
	leia2X: .asciiz "° valor do vetor: "
	saidaVetor: .asciiz "O vetor lido foi: "
	erro: .asciiz "Erro ao alocar memória!"
	saida1: .asciiz " ocorre "
	saida2: .asciiz " vezes"
	saida21: .asciiz " vez"
	
	num: .align 3
	.float -999999
	
.text
#procedimento main
main:
	jal lerN #procedimento para ler n
	move $t1, $v0 #salva o endereço base do vetor em $t1
	jal iniciaVetor #salta para o procedimento inicia vetor
	jal alocaVetor #salta para o procedimento alocaVetor
	move $t2, $v0 #salva o endereço base do vetor auxiliar em $t2
	jal preIniciaVetAux #salta para preIniciaVetAux
	jal preVerificaRepeticao #salta para o procedimento preVerificaRepeticao
	j encerrar #salta para o procedimento encerrar
	
#preparação para iniciar o vetor
preIniciaVetAux:
	addi $t3, $zero, 1 #iniciando $t3(i) com 1
	move $t4, $t2 #iniciando $t3(apontador) com o endereço base do vetor auxliar
	j iniciaVetAux #salta para iniciaVetAux
	
#procedimento para iniciar o vetor auxiliar
iniciaVetAux:
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	l.s $f1, num #carrega num em $f1
	s.s $f1, 0($t4) #salva o valor de $f1 na posição i do vetor
	addi $t3, $t3, 1 #i++
	addi $t4, $t4, 32 #apontador desloca para a próxima posição da matriz
	j iniciaVetAux #retorna ao inicio do laço
	
#preparação para verificar as repetições
preVerificaRepeticao:
	addi $t3, $zero, 1 #iniciando $t3(i) com 1
	move $t4, $t1 #iniciando $t4(apontador) com o endereço base do vetor
	j verificaRepeticao #salta para verificaRepeticao
	
#procedimento para verificar a repetição
verificaRepeticao:
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	move $t5, $zero#iniciando $t5(j) com 0
	addi $t6, $zero, 1 #iniciando $t6(contador) com 1
	l.s $f1, 0($t4) #carrega o valor na posição i do vetor
	subi $t7, $zero, 1 #iniciando $t7(g) com -1
	j verificaNumero #salta para verifica numero

#procedimento para verificar o número
verificaNumero:
	addi $t7, $t7, 1 #g++
	bge $t7, $t0, verificaConta #se g >= n salta para verificaConta
	mul $s1, $t7, 32 #$s1 = g * 32
	add $s0, $t2, $s1 #$s0 recebe o endereço de vetAux + g
	l.s $f2, 0($s0) #carrega em $f2 o valor em vetAux[g]
	c.eq.s $f2, $f1 #verifica se $f2 == $f1
	bc1f verificaNumero #se $f2 != $f1 retorna ao inicio do laço
	addi $t5, $t5, 1 #j++
	j verificaNumero #retorna ao início do laço
	
#procedimento para verificar se o número já foi contado
verificaConta:
	bnez $t5, incrementaI #se j != 0 salta para incrementa i
	subi $s1, $t3, 1 #$s1 = i-1
	mul $s1, $s1, 32 #$s1 = $s1 * 32
	add $s0, $t2, $s1 #$s0 recebe o endereço de vetAux + i
	s.s $f1, 0($s0) #guarda vet[i] em vetAux[i]
	move $t5, $t3 #g = i
	j contaRepeticao #salta para contaRepeticao
	
#procedimento para contar as repetições
contaRepeticao:
	bge $t5, $t0, printaRepeticao #se g >= n salta para printaRepeticao
	mul $s0, $t5, 32 #$s0 = g * 32
	add $s0, $t1, $s0 #$s0 recebe o endereço de vet + g
	addi $t5, $t5, 1 #g++
	l.s $f2, 0($s0) #$f2 = vet[g]
	c.eq.s $f2, $f1 #verifica se $f2 == $f1
	bc1f contaRepeticao #se $f2 != $f1 retorna ao inicio do laço
	addi $t6, $t6, 1 #contador++
	j contaRepeticao #retorna ao início do laço
	
#procedimento para printar o número de repetições
printaRepeticao:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 2 #carregando 1 em $v0 para fazer a chamada de sistema
	mov.s $f12, $f1 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida1 #carrega a string saida1 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t6 #carregando o valor de $t6 em $a0 para printar
	syscall #realiza a chamada de sistema
	beq $t6, 1, printa1 #se $t6 = 1 salta para printa1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida2 #carrega a string saida2 para poder printar
	syscall #realiza a chamada de sistema
	j incrementaI #salta para incrementaI
	
#procedimento para printar 'vez' ao invés de 'vezes'
printa1:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida21 #carrega a string saida21 para poder printar
	syscall #realiza a chamada de sistema
	j incrementaI #salta para incrementaI
	
#procedimento para incrementar i
incrementaI:
	addi $t3, $t3, 1 #i++
	addi $t4, $t4, 32 #desloca o apontador
	j verificaRepeticao #salta para verificaRepeticao
	
#preparação para fazer a leitura dos valores do vetor
iniciaVetor:
	addi $t2, $zero, 1 #iniciando $t2(i) com 1
	move $t3, $t1 #iniciando $t3(apontador) com o endereço base do vetor
	j carregaVetor #salta para o procedimento carregaVetor
	
#procedimento para fazer a leitura do vetor
carregaVetor:
	bgt $t2, $t0, preImprimeVetor #se i > n salta para o procedimento preImprimeVetor
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leia1X #carrega a string leia1X para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t2 #carregando o valor de $t2 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leia2X #carrega a string leia2X para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 6 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	s.s $f0, 0($t3) #salva o valor lido na posição i do vetor
	addi $t2, $t2, 1 #i++
	addi $t3, $t3, 32 #apontador desloca para a próxima posição da matriz
	j carregaVetor #retorna ao inicio do laço	
	
#preparação para imprimir o vetor
preImprimeVetor:
	addi $t2, $zero, 1 #iniciando $t2(i) com 1
	move $t3, $t1 #iniciando $t3(apontador) com o endereço base do vetor
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaVetor #carrega a string saidaVetor para poder printar
	syscall #realiza a chamada de sistema
	j imprimeVetor #salta para o procedimento imprimeVetor
	
#procedimento para imprimir o vetor
imprimeVetor:
	bgt $t2, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	l.s $f1, 0($t3) #garrega o valor na posição i do vetor
	addi $t2, $t2, 1 #i++
	addi $t3, $t3, 32 #apontador desloca para a proxima posição do vetor
	li $v0, 2 #carregando 1 em $v0 para fazer a chamada de sistema
	mov.s $f12, $f1 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeVetor #retorna para o inicio do laço
	
#procedimento para ler o valor de n
lerN:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaN #carrega a string leiaN para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t0, $v0 #salva o valor lido em $t0(n)
	j alocaVetor #salta para o procedimento alocaVetor
	
#procedimento para alocar memória para a matriz
alocaVetor:
	mul $s0, $t0, 32 #salva em $s0 a quantidade de bytes do vetor
	li $v0, 9 #carregando 9 em $v0 para realizar a chamada de sistema
	move $a0, $s0 #copia o valor de $s0 em $a0
	syscall #aloca a memória
	bgez $t1, retornaMain #se o apontador >= 0 salta para o procedimento retornaMain
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, erro #carrega a string erro para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar

#procedimento para retornar ao main
retornaMain:
	jr $ra #retorna onde parou no main
	
#procedimento para encerrar o programa
encerrar:
	li $v0, 10 #carregando 10 em $v0 para encerrar o programa
	syscall #realizando a chamada de sistema
