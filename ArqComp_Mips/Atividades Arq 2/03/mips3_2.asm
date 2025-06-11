.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	ent1Mat1: .asciiz "Insira o valor em A["
	ent2Mat1: .asciiz "]["
	ent3Mat1: .asciiz "]: "
	ent1Mat2: .asciiz "Insira o valor em B["
	ent2Mat2: .asciiz "]["
	ent3Mat2: .asciiz "]: "
	saidaMatriz: .asciiz "A matriz lida foi:"
	saidaSoma: .asciiz "A soma das posições dos elementos iguais é: "
	saidaQntd: .asciiz "A quantidade de valores iguais na mesma posição é: "
	
	mat1: .align 2
	      .space 64
	mat2: .align 2
	      .space 64

.text
#procedimento main
main:
	jal iniciaMatriz1 #salta para o procedimento inicia matriz1
	jal iniciaMatriz2 #salta para o procedimento inicia matriz2
	jal preparaComparaMatrizes #salta para o procedimento preparaComaraMatrizes
	j encerrar #salta para o procedimento encerrar
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
preparaComparaMatrizes:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	move $t3, $zero #zerando $t3(soma das posições)
	move $t4, $zero #zerando $t4(qntd de iguais)
	j preComparaMatrizes #salta para o procedimento preComparaMatrizes
	
#preparação para comparar os valores da matriz A com os valores da matriz B
preComparaMatrizes:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, saida #se i > 3 salta para o procedimento saida
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	j comparaMatrizes #salta para o procedimento comparaMatrizes
	
#procedimento para comparar os valores da matriz A com os valores da matriz B
comparaMatrizes:
	bgt $t2, 4, preComparaMatrizes #se j > 4 salta para o procedimento preComparaMatrizes
	lw $s0, mat1($t1) #garrega o valor na posição ixj da matriz A
	lw $s1, mat2($t1) #garrega o valor na posição ixj da matriz B
	beq $s0, $s1, iguais #se $s0 == $s1 salta para o procedimento iguais
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a próxima posição da matriz
	j comparaMatrizes #retorna ao início do laço
	
#procedimento caso os valores sejam iguais
iguais:
	addi $t4, $t4, 1 #qntd++
	add $t3, $t3, $t0 #soma = soma + i
	add $t3, $t3, $t2 #soma = soma + j
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a próxima posição da matriz
	j comparaMatrizes #retorna ao início do laço

#procedimento para apresentar os resultados
saida:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaQntd #carrega a string saidaQntd para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t4 #carregando o valor de $t4 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaSoma #carrega a string saidaSoma para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t3 #carregando o valor de $t3 em $a0 para printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para o procedimento retornaMain
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
iniciaMatriz2:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	j preCarregaMatriz2 #salta para o procedimento preCarregaMatriz2
	
#preparação para carregar os valores da matriz B
preCarregaMatriz2:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, pre1ImprimeMatriz2 #se i > 3 salta para o procedimento preImprimeMatriz2
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	j carregaMatriz2 #salta para o procedimento carregaMatriz2
	
#procedimento para fazer a leitura dos valores da matriz B
carregaMatriz2:
	bgt $t2, 4, preCarregaMatriz2 #se j > 4 salta para o procedimento preCarregaMatriz2
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent1Mat2 #carrega a string ent1Mat2 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t0 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent2Mat2 #carrega a string ent2Mat2 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t2 #carregando o valor de j em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent3Mat2 #carrega a string ent3Mat2 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	sw $v0, mat2($t1) #salva o valor lido na posição ixj da matriz B
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a próxima posição da matriz
	j carregaMatriz2 #retorna ao inicio do laço

#procedimento para iniciar $t0 com 0 e zerar o apontador
pre1ImprimeMatriz2:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatriz #carrega a string saidaMatriz para poder printar
	syscall #realiza a chamada de sistema
	j pre2ImprimeMatriz2 #salta para o procedimento preCarregaMatriz2
	
#preparação para imprimir a matriz B
pre2ImprimeMatriz2:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, retornaMain #se i > 4 salta para o procedimento preImprimeMatriz2
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz2 #salta para o procedimento imprimeMatriz2

#procedimento para imprimir a matriz B
imprimeMatriz2:
	bgt $t2, 4, pre2ImprimeMatriz2 #se j > 4 salta para o procedimento pre2ImprimeMatriz2
	lw $s0, mat2($t1) #garrega o valor na posição ixj da matriz B
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz2 #retorna para o inicio do laço

#procedimento para iniciar $t0 com 0 e zerar o apontador
iniciaMatriz1:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	j preCarregaMatriz1 #salta para o procedimento preCarregaMatriz1
	
#preparação para carregar os valores da matriz A
preCarregaMatriz1:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, pre1ImprimeMatriz1 #se i > 4 salta para o procedimento preImprimeMatriz1
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	j carregaMatriz1 #salta para o procedimento carregaMatriz1
	
#procedimento para fazer a leitura dos valores da matriz A
carregaMatriz1:
	bgt $t2, 4, preCarregaMatriz1 #se j > 4 salta para o procedimento preCarregaMatriz1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent1Mat1 #carrega a string ent1Mat1 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t0 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent2Mat1 #carrega a string ent2Mat1 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t2 #carregando o valor de j em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent3Mat1 #carrega a string ent3Mat1 para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	sw $v0, mat1($t1) #salva o valor lido na posição ixj da matriz A
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a próxima posição da matriz
	j carregaMatriz1 #retorna ao inicio do laço

#procedimento para iniciar $t0 com 0 e zerar o apontador
pre1ImprimeMatriz1:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatriz #carrega a string saidaMatriz para poder printar
	syscall #realiza a chamada de sistema
	j pre2ImprimeMatriz1 #salta para o procedimento preCarregaMatriz1
	
#preparação para imprimir a matriz A
pre2ImprimeMatriz1:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, retornaMain #se i > 4 salta para o procedimento preImprimeMatriz1
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz1 #salta para o procedimento carregaMatriz1

#procedimento para imprimir a matriz A
imprimeMatriz1:
	bgt $t2, 4, pre2ImprimeMatriz1 #se j > 4 salta para o procedimento pre2ImprimeMatriz1
	lw $s0, mat1($t1) #garrega o valor na posição ixj da matriz A
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz1 #retorna para o inicio do laço
	
#procedimento para retornar ao main
retornaMain:
	jr $ra #retorna onde parou no main
	
#procedimento para encerrar o programa
encerrar:
	li $v0, 10 #carregando 10 em $v0 para encerrar o programa
	syscall #realizando a chamada de sistema