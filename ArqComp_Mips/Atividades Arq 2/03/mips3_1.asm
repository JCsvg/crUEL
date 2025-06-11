.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	ent1Mat: .asciiz "Insira o valor em A["
	ent2Mat: .asciiz "]["
	ent3Mat: .asciiz "]: "
	saidaMatriz: .asciiz "A matriz lida foi:"
	saidaSoma: .asciiz "A soma dos elementos da diagonal secundária da matriz é: "
	
	mat: .align 2
	     .space 36

.text
#procedimento main
main:
	jal iniciaMatriz #salta para o procedimento inicia matriz
	jal preparaSomaDiagonal #salta para o procedimento preSomaDiagonal
	j encerrar #salta para o procedimento encerrar

#procedimento para iniciar $t0 com 0 e zerar o apontador
preparaSomaDiagonal:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	move $t3, $zero #zerando $t3 (variavel soma)
	j preSomaDiagonal #salta para o procedimento preSomaDiagonal
	
#preparação para somar os valores da diagonal secundária da matriz
preSomaDiagonal:
	addi $t0, $t0, 1 #i++
	bgt $t0, 3, saida #se i > 3 salta para o procedimento saida 
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	j somaDiagonal #salta para o procedimento somaDiagonal
	
#procedimento para encontrar os valores da diagonal secundária da matriz
somaDiagonal:
	bgt $t2, 3, preSomaDiagonal #se j > 3 salta para o procedimento preSomaDiagonal
	add $s0, $t0, $t2 #$s0 = i + j
	beq $s0, 4, soma #se $s0 == 4 salta para o procedimento soma
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a próxima posição da matriz
	j somaDiagonal #retorna ao início do laço

#procedimento para realizar a soma
soma:
	lw $s0, mat($t1) #garrega o valor na posição ixj da matriz
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	add $t3, $t3, $s0 #soma = soma + mat(ixj)
	j somaDiagonal #retorna ao inicio do laço
	
#procedimento para imprimir a soma
saida:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaSoma #carrega a string saidaSoma para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t3 #carregando o valor de soma em $a0 para printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para o procedimento retornaMain

#procedimento para iniciar $t0 com 0 e zerar o apontador
iniciaMatriz:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	j preCarregaMatriz #salta para o procedimento preCarregaMatriz
	
#preparação para carregar os valores da matriz
preCarregaMatriz:
	addi $t0, $t0, 1 #i++
	bgt $t0, 3, pre1ImprimeMatriz #se i > 3 salta para o procedimento preImprimeMatriz 
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
	bgt $t0, 3, retornaMain #se i > 4 salta para o procedimento preImprimeMatriz 
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