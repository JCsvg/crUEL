.data
	leiaN: .asciiz "Insira o valor de n: "
	leiaX: .asciiz "Insira o valor de x: "
	saida1: .asciiz "cos("
	saida2: .asciiz ")= "
	
	num: .align 3
	.float 1.0
	
.text
#procedimento main
main:
	jal lerN #procedimento para ler n
	jal lerX #procedimento para ler x
	j preProcessamento #salta para processamento
	
#preparação para o processamento
preProcessamento:
	addi $t1, $zero, 1 #iniciando $t1(i) com 1
	l.s $f2, num #carregando 1 em $f2(cos)
	addi $t2, $zero, 2 #iniciando $t2(j) com 2
	j processamento #salta para processamento

#procedimento para processar o cos(x)
processamento:
	addi $t1, $t1, 1 #i++
	bgt $t1, $t0, printaCos #se i > n salta para printaCos
	addi $t3, $zero, 2 #iniciando $t3(g) com 2
	mov.s $f3, $f1 #copiar x em $f3
	jal exponencial #salta para exponencial
	addi $t3, $zero, 1 #iniciando $t3(g) com 1
	l.s $f5, num #carrega 1 em $f5(k)
	jal fatorial #salta para fatorial
	addi $s0, $zero, 2 #carrega 2 em $s0
	div $t1, $s0 #i / 2
	mfhi $s0 #i%2
	div.s $f4, $f3, $f5 #$f4 = $f3 / $f5
	addi $t2, $t2, 2 #j = j + 2
	bnez $s0, somaCos #se $s0 != 0 salta para somaCos
	sub.s $f2, $f2, $f4 #cos = cos - $f4
	j processamento #retorna ao início do laço
	
#procedimento para printar o cos
printaCos:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida1 #carrega a string saida1 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 2 #carregando 1 em $v0 para fazer a chamada de sistema
	mov.s $f12, $f1 #carregando o valor de $f1 em $f12 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida2 #carrega a string saida2 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 2 #carregando 1 em $v0 para fazer a chamada de sistema
	mov.s $f12, $f2 #carregando o valor de $f2 em $f12 para printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para encerrar
	
#procedimento para somar o cos(x) quando i é impar
somaCos:
	add.s $f2, $f2, $f4 #cos = cos + $f4
	j processamento #retorna ao início do laço

#procedimento para calcular o exponencial
exponencial:
	bgt $t3, $t2, retornaMain #se g > j salta para retornaMain
	mul.s $f3, $f3, $f1 #$f3 = $f3 * $f1
	addi $t3, $t3, 1 #g++
	j exponencial #retorna ao início do laço 

#procedimento para calcular o fatorial	
fatorial:
	bgt $t3, $t2, retornaMain #se g > j salta para retornaMain
	mtc1 $t3, $f6 #converte g para float
	cvt.s.w $f7, $f6 #converte g para float
	mul.s $f5, $f5, $f7 #k = k * g
	addi $t3, $t3, 1 #g++
	j fatorial #retorna ao início do laço

#procedimento para ler o valor de X
lerX:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaX #carrega a string leiaX para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 6 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	mov.s $f1, $f0 #salva o valor lido em $f1(x)
	j retornaMain #salta para retornaMain
	
#procedimento para ler o valor de n
lerN:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaN #carrega a string leiaN para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t0, $v0 #salva o valor lido em $t0(n)
	j retornaMain #salta para retornaMain
	
#procedimento para retornar ao main
retornaMain:
	jr $ra #retorna onde parou no main
	
#procedimento para encerrar o programa
encerrar:
	li $v0, 10 #carregando 10 em $v0 para encerrar o programa
	syscall #realizando a chamada de sistema
