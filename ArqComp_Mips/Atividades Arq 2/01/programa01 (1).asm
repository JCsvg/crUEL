.data
	ent1Vet: .asciiz "Insira o "
	ent2Vet: .asciiz "° número do vetor V: "
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	ent1Mat: .asciiz "Insira o valor em A["
	ent2Mat: .asciiz "]["
	ent3Mat: .asciiz "]: "
	saida: .asciiz "Produto de AxV: "
	saidaMatriz: .asciiz "A matriz lida foi:"
	saidaVetor: .asciiz "O vetor lido foi: "
		
	mat: .align 2
	     .space 48
	vet: .align 2
	     .space 12
.text
#procedimento main
main:
	jal iniciaMatriz #salta para o procedimento inicia matriz
	jal iniciaVetor #salta para o procedimento inicia vetor
	jal preProduto #salta para o procedimento preProduto
	j encerrar #salta para o procedimento encerrar
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
preProduto:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida #carrega a string saida para poder printar
	syscall #realiza a chamada de sistema
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador da matriz)
	j preMultiplicacao #salta para o procedimento preMultiplicacao

#preparação para realizar a multiplicação
preMultiplicacao:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, retornaMain #se i > 4 salta para o procedimento preImprimeMatriz 
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	move $t3, $zero #zerando $t3(apontador do vetor)
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j multiplicacao #salta para o procedimento carregaMatriz

#procedimento para realizar AxV
multiplicacao:
	bgt $t2, 3, preMultiplicacao #se j > 3 salta para o procedimento preMultiplicacao
	lw $s0, mat($t1) #garrega o valor na posição ixj da matriz
	lw $s1, vet($t3) #garrega o valor na posição j do vetor
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador da matriz desloca para a proxima posição da matriz
	addi $t3, $t3, 4 #apontador do vetor desloca para a proxima posição do vetor
	mul $s2, $s0, $s1 #$s2 = $s0 * $s1
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s2 #carregando o valor de $s2 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j multiplicacao #retorna para o inicio do laço

#preparação para fazer a leitura dos valores do vetor
iniciaVetor:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t0, $zero #zerando $t0(i)
	move $t1, $zero #zerando $t1(apontador) 
	j carregaVetor #salta para o procedimento carregaVetor
	
#procedimento para fazer a leitura do vetor
carregaVetor:
	bgt $t0, 2, preImprimeVetor #se i > 3 salta para o procedimento preImprimeVetor
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent1Vet #carrega a string ent1Vet para poder printar
	syscall #realiza a chamada de sistema
	addi $s0, $t0, 1 #$s0 = i + 1
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent2Vet #carrega a string ent2Vet para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	sw $v0, vet($t1) #salva o valor lido na posição i do vetor
	addi $t0, $t0, 1 #i++
	addi $t1, $t1, 4 #apontador desloca para a próxima posição da matriz
	j carregaVetor #retorna ao inicio do laço
	
#preparação para imprimir o vetor
preImprimeVetor:
	move $t0, $zero #zerando $t0(i)
	move $t1, $zero #zerando $t1(apontador)
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaVetor #carrega a string saidaVetor para poder printar
	syscall #realiza a chamada de sistema
	j imprimeVetor #salta para o procedimento imprimeVetor
	
#procedimento para imprimir o vetor
imprimeVetor:
	bgt $t0, 2, retornaMain #se i > 3 salta para o procedimento retornaMain
	lw $s0, vet($t1) #garrega o valor na posição i do vetor
	addi $t0, $t0, 1 #i++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeVetor #retorna para o inicio do laço

#procedimento para iniciar $t0 com 0 e zerar o apontador
iniciaMatriz:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	j preCarregaMatriz #salta para o procedimento preCarregaMatriz
	
#preparação para carregar os valores da matriz
preCarregaMatriz:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, pre1ImprimeMatriz #se i > 4 salta para o procedimento preImprimeMatriz 
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	j carregaMatriz #salta para o procedimento carregaMatriz
	
#procedimento para fazer a leitura dos valores da matriz
carregaMatriz:
	bgt $t2, 3, preCarregaMatriz #se j > 3 salta para o procedimento preCarregaMatriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent1Mat #carrega a string ent1Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t0 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent2Mat #carrega a string ent2Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t2 #carregando o valor de j em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent3Mat #carrega a string ent3Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	sw $v0, mat($t1) #salva o valor lido na posição ixj da matriz
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a próxima posição da matriz
	j carregaMatriz #retorna ao inicio do laço

#procedimento para iniciar $t0 com 0 e zerar o apontador
pre1ImprimeMatriz:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatriz #carrega a string saidaMatriz para poder printar
	syscall #realiza a chamada de sistema
	j pre2ImprimeMatriz #salta para o procedimento preCarregaMatriz
	
#preparação para imprimir a matriz
pre2ImprimeMatriz:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, retornaMain #se i > 4 salta para o procedimento preImprimeMatriz 
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #salta para o procedimento carregaMatriz

#procedimento para imprimir a matriz
imprimeMatriz:
	bgt $t2, 3, pre2ImprimeMatriz #se j > 3 salta para o procedimento pre2ImprimeMatriz
	lw $s0, mat($t1) #garrega o valor na posição ixj da matriz
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #retorna para o inicio do laço
	
#procedimento para retornar ao main
retornaMain:
	jr $ra #retorna onde parou no main
	
#procedimento para encerrar o programa
encerrar:
	li $v0, 10 #carregando 10 em $v0 para encerrar o programa
	syscall #realizando a chamada de sistema