.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	ent1Mat: .asciiz "Insira o valor em A["
	ent2Mat: .asciiz "]["
	ent3Mat: .asciiz "]: "
	saidaMatriz: .asciiz "A matriz lida foi:"
	leiaN: .asciiz "Insira o número de colunas da matriz: "
	leiaM: .asciiz "Insira o número de linhas da matriz: "
	erro: .asciiz "Erro ao alocar memória!"
	numColunas: .asciiz "Número de colunas nulas: "
	numLinhas: .asciiz "Núemro de linhas nulas: "

.text
#procedimento main
main:
	jal lerN #salta para o procedimento lerN
	jal lerM #salta para o procedimento lerM
	jal iniciaMatriz #salta para o procedimento iniciaMatriz
	jal verificaMatriz #salta para o procedimento verificaMatriz
	j encerrar #salta para o procedimento encerrar
	
#procedimento para iniciar $t3 com 0 e iniciar o apontador
verificaMatriz:
	move $t3, $zero#iniciando $t3(i) com 0
	move $t4, $t2 #iniciando $t4(apontador) com o endereço base da matriz salvo em $t2
	move $t7, $zero #zerando $t7 que será o contador de linhas nulas
	j preVerificaLinha #salta para o procedimento preVerificaLinha

#preparação para verificar as linhas da matriz
preVerificaLinha:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, saidaLinha #se i > n salta para o procedimento saidaLinha
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	move $t6, $zero #zerando $t6 que servirá para contar quantos elementos há em cada linha e coluna
	j verificaLinha #salta para o procedimento verificaLinha

#procedimento para verificar as linhas da matriz
verificaLinha:
	bgt $t5, $t1, preVerificaLinha #se j > m salta para o procedimento preVerificaLinha
	lw $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 4 #apontador desloca para a proxima posição da matriz
	bnez $s0, proxLinha #se o elemento ij da matriz for diferente de 0 salta para o procedimento proxLinha
	addi $t6, $t6, 1 #somando 1 em $t6
	beq $t6, $t1, somaLinha #se $t6 == j salta para o procedimento somaLinha
	j verificaLinha #retorna para o inicio do laço
	
#procedimento para ir para a próxima linha
proxLinha:
	subi $t5, $t5, 1 #j--
	sub $s1, $t1, $t5 #guarda em $s1 m - j
	mul $s1, $s1, 4 #$s1 = $s1 * 4
	add $t4, $t4, $s1 #move o apontador para a próxima linha
	j preVerificaLinha #salta para o procedimento preVerificaLinha

#procedimento para somar o número de linhas nulas
somaLinha:
	addi $t7, $t7, 1 #contador++
	j preVerificaLinha #salta para o procedimento preVerificaLinha
			
#procedimento para imprimir o número de linhas nulas
saidaLinha:
	blt $t3, $t0, preVerificaLinha #se i < n salta para o procedimento preVerificaLinha
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, numLinhas #carrega a string numLinhas para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t7 #copia o valor de $t7 em $a0 poder printar
	syscall #realiza a chamada de sistema
	j pre1VerificaColuna #salta para o procedimento pre1VerificaColuna
	
#procedimento para iniciar $t3 com 0 e iniciar o apontador
pre1VerificaColuna:
	move $t3, $zero#iniciando $t3(j) com 0
	move $t7, $zero #zerando $t7 que será o contador de colunas nulas
	j pre2VerificaColuna #salta para o procedimento pre2VerificaColuna
	
#preparação para verificar as colunas da matriz
pre2VerificaColuna:
	addi $t3, $t3, 1 #j++
	bgt $t3, $t1, saidaColuna #se j > m salta para o procedimento saida
	addi $t5, $zero, 1 #iniciando $t5(i) com 1
	move $t4, $t2 #iniciando $t4(apontador) com o endereço base da matriz salvo em $t2
	move $t6, $zero #zerando $t6 que servirá para contar quantos elementos há em cada linha e coluna
	j verificaColuna #salta para o procedimento verificaColuna
	
#procedimento para verificar as colunas
verificaColuna:
	bgt $t5, $t0, proxColuna #se i > n salta para o procedimento deslocaApontador
	lw $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t5, $t5, 1 #i++
	mul $s1, $t1, 4 #$s0 = m * 4
	add $t4, $t4, $s1 #apontador desloca para a proxima coluna da matriz
	bnez $s0, proxColuna #se o elemento ij da matriz for diferente de 0 passa para a próxima coluna
	addi $t6, $t6, 1 #somando 1 em $t6
	beq $t6, $t0, somaColuna #se $t5 == n salta para o procedimento somaColuna
	j verificaColuna #retorna para o inicio do laço
	
#procedimento para pular para a próxima coluna
proxColuna:
	addi $t2, $t2, 4 #desloca para a proxima coluna
	j pre2VerificaColuna #salta para o procedimento pre2VerificaColuna
	
#procedimento para somar o número de colunas nulas
somaColuna:
	addi $t7, $t7, 1 #contador++
	j proxColuna #salta para o procedimento proxColuna
	
#procedimento para imprimir o número de linhas nulas
saidaColuna:
	ble $t3, $t0, proxColuna #se j <= m salta para o procedimento pre2VerificaColuna
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, numColunas #carrega a string numColunas para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t7 #copia o valor de $t7 em $a0 poder printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para o procedimento retornaMain
		
#procedimento para iniciar $t3 com 0 e iniciar o apontador
iniciaMatriz:
	move $t3, $zero#iniciando $t3(i) com 0
	move $t4, $t2 #iniciando $t4(apontador) com o endereço base da matriz salvo em $t2
	j preCarregaMatriz #salta para o procedimento preCarregaMatriz
	
#preparação para carregar os valores da matriz
preCarregaMatriz:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, pre1ImprimeMatriz #se i > n salta para o procedimento preImprimeMatriz 
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	j carregaMatriz #salta para o procedimento carregaMatriz
	
#procedimento para fazer a leitura dos valores da matriz
carregaMatriz:
	bgt $t5, $t1, preCarregaMatriz #se j > m salta para o procedimento preCarregaMatriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent1Mat #carrega a string ent1Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t3 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent2Mat #carrega a string ent2Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t5 #carregando o valor de j em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent3Mat #carrega a string ent3Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	sw $v0, 0($t4) #salva o valor lido na posição ixj da matriz
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 4 #apontador desloca para a próxima posição da matriz
	j carregaMatriz #retorna ao inicio do laço

#procedimento para iniciar $t3 com 0 e zerar o apontador
pre1ImprimeMatriz:
	move $t3, $zero#iniciando $t3(i) com 0
	move $t4, $t2 #iniciando $t4(apontador) com o endereço base da matriz salvo em $t2
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatriz #carrega a string saidaMatriz para poder printar
	syscall #realiza a chamada de sistema
	j pre2ImprimeMatriz #salta para o procedimento preCarregaMatriz
	
#preparação para imprimir a matriz
pre2ImprimeMatriz:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento preImprimeMatriz 
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #salta para o procedimento carregaMatriz

#procedimento para imprimir a matriz
imprimeMatriz:
	bgt $t5, $t1, pre2ImprimeMatriz #se j > m salta para o procedimento pre2ImprimeMatriz
	lw $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 4 #apontador desloca para a proxima posição da matriz
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #retorna para o inicio do laço
	
#procedimento para alocar memória para a matriz
alocaMatriz:
	mul $s0, $t0, $t1 #$s0 = n*m
	mul $s1, $s0, 4 #salva em $s1 a quantidade de bytes da matriz
	li $v0, 9 #carregando 9 em $v0 para realizar a chamada de sistema
	move $a0, $s1 #copia o valor de $s1 em $a0
	syscall #aloca a memória
	move $t2, $v0 #salva o endereço base da matriz em $t1
	bgez $t2, retornaMain #se o apontador >= 0 salta para o procedimento retornaMain
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, erro #carrega a string erro para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar

#procedimento para ler o número de linhas da matriz
lerM:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaM #carrega a string leiaM para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t1, $v0 #salva o valor lido em $t1(m)
	j alocaMatriz #salta para o procedimento alocaMatriz
	
	
#procedimento para ler o número de colunas da matriz
lerN:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaN #carrega a string leiaN para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t0, $v0 #salva o valor lido em $t0(n)
	j retornaMain #salta para o procedimento retornaMain
	
#procedimento para retornar ao main
retornaMain:
	jr $ra #retorna onde parou no main
	
#procedimento para encerrar o programa
encerrar:
	li $v0, 10 #carregando 10 em $v0 para encerrar o programa
	syscall #realizando a chamada de sistema