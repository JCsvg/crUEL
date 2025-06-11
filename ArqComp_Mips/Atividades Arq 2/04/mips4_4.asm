.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	leiaN: .asciiz "Insira o número de linhas da matriz: "
	leiaM: .asciiz "Insira o número de colunas da matriz: "
	ent1Mat: .asciiz "Insira o valor em A["
	ent2Mat: .asciiz "]["
	ent3Mat: .asciiz "]: "
	saidaMatriz: .asciiz "Matriz A:"
	saidaMatrizVogais: .asciiz "Matriz A com as vogais maiúsculas:"
	saidaMatrizLinhas: .asciiz "Matriz A com as linhas ímpares trocadas:"
	saidaMatrizColunas: .asciiz "Matriz A com as colunas pares trocadas:"
	saidaMatrizOrdenada: .asciiz "Matriz A oredenada:"
	qntdVogais: .asciiz "O número de vogais na matriz é: "
	repete3: .asciiz "As letras que repetem mais de 3 vezes são: "
	naoQuadrada: .asciiz "A matriz A não é quadrada!"
	diagPrinc: .asciiz "A diagonal principal da matriz é: "
	erro: .asciiz "A dimenção inserida é inválida!"
	saida1Palindromo: .asciiz "Linha: "
	saida2Palindromo: .asciiz " Palíndromo: "
	
.text
#procedimento main
main:
	jal lerN #salta para o procedimento lerN
	jal lerM #salta para o procedimento lerM
	jal alocaMatriz #salta para o procedimento alocaMatriz
	jal pre1ImprimeVogais #salta para o procedimento pre1ImprimeVogais
	jal saidaVogais #salta para o procedimento qntdVogais
	jal preVerifica3 #salta para o procedimento preVerifica3
	jal verificaQuadrada #salta para o procedimento verificaQuadrada
	jal preVerificaPalindromo #salta para o procedimento preVerificaPalindromo
	jal preTrocaLinhas #salta para o procedimento preTrocaLinhas
	jal preTrocaColunas #salta para o procedimento preTrocaColunas
	jal alocaSegundaMatriz #salta para o procedimento alocaSegundaMatriz
	j encerrar #salta para o procedimento encerrar
	
#procedimento para alocar a matriz auxiliar
alocaSegundaMatriz:
	mul $s0, $t0, $t1 #guarda em $s0 n*m
	li $v0, 9 #carregando 9 em $v0 para realizar a chamada de sistema
	move $a0, $s0 #copia o valor de $s0 em $a0
	syscall #aloca a memória
	move $t6, $v0 #salva o endereço base do vetor em $t6
	bgez $t6, preOrdenaMatriz #se o apontador >= 0 salta para o procedimento preOrdenaMatriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, erro #carrega a string erro para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar
	
#procedimento para iniciar i e apontador
preOrdenaMatriz:
	move $t3, $zero #zerando $t3(i)
	move $t7, $t6 #iniciando $t7(apontador) com o endereço da matriz auxiliar
	j ordenaMatriz #salta para ordenaMatriz
	
#procedimento para ordenar a matriz
ordenaMatriz:
	addi $t3, $t3, 1 #i++
	bgt $t3, 3, pre1ImprimeMatrizOrdenada #se i > 3 salta para o procedimento pre1ImprimeMatrizOrdenada
	move $t4, $t2 #iniciando $t4(apontador) com o endereço da matriz
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	beq $t3, 1, ordenaMaiuscula #se i == 1 salta para ordenaMaiuscula
	beq $t3, 2, ordenaMinuscula #se i == 2 salta para ordenaMinuscula
	beq $t3, 3, ordenaEspecial #se i == 3 salta para ordenaEspecial
	j ordenaMatriz #retorna ao inicio do laço
	
#procedimento para adicionar as letras maiúsculas a matriz auxiliar
ordenaMaiuscula:
	mul $s0, $t0, $t1 #$s0 = n * m
	bgt $t5, $s0, ordenaMatriz #se j > $s0 salta para ordenaMatriz
	lb $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	addi $t5, $t5, 1 #j++
	blt $s0, 65, ordenaMaiuscula #se $s0 <= 'A' salta para ordenaMaiuscula
	bgt $s0, 90, ordenaMaiuscula #se $s0 >= 'Z' salta para ordenaMaiuscula
	sb $s0, 0($t7) #guarda na matriz auxiliar a letra maiuscula
	addi $t7, $t7, 1 #incrementa o apontador da matriz auxiliar
	j ordenaMaiuscula #retorna ao inicio do laço
	
#procedimento para adicionar as letras minúsculas a matriz auxiliar
ordenaMinuscula:
	mul $s0, $t0, $t1 #$s0 = n * m
	bgt $t5, $s0, ordenaMatriz #se j > $s0 salta para ordenaMatriz
	lb $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	addi $t5, $t5, 1 #j++
	blt $s0, 97, ordenaMinuscula #se $s0 <= 'a' salta para ordenaMinuscula
	bgt $s0, 122, ordenaMinuscula #se $s0 >= 'z' salta para ordenaMinuscula
	sb $s0, 0($t7) #guarda na matriz auxiliar a letra minuscula
	addi $t7, $t7, 1 #incrementa o apontador da matriz auxiliar
	j ordenaMinuscula #retorna ao inicio do laço
	
#procedimento para adicionar os caracteres especiais a matriz auxiliar
ordenaEspecial:
	mul $s0, $t0, $t1 #$s0 = n * m
	bgt $t5, $s0, ordenaMatriz #se j > $s0 salta para ordenaMatriz
	lb $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	addi $t5, $t5, 1 #j++
	bgt $s0, 64, verificaEspecial1 #se $s0 >= 'A' salta para verificaEspecial1
	blt $s0, 91, verificaEspecial2 #se $s0 <= 'Z' salta para verificaEspecial2
	sb $s0, 0($t7) #guarda na matriz auxiliar o caracter especial
	addi $t7, $t7, 1 #incrementa o apontador da matriz auxiliar
	j ordenaEspecial #retorna ao inicio do laço
	
#procedimento para verificar o caracter
verificaEspecial1:
	blt $s0, 91, ordenaEspecial #se $s0 <= 'Z' salta para ordenaEspecial
	bgt $s0, 96, verificaEspecial3 #se $s0 >= 'a' salta para verificaEspecial2
	blt $s0, 123, verificaEspecial2 #se $s0 <= 'z' salta para verificaEspecial2
	sb $s0, 0($t7) #guarda na matriz auxiliar o caracter especial
	addi $t7, $t7, 1 #incrementa o apontador da matriz auxiliar
	j ordenaEspecial #retorna ao inicio do laço
	
#procedimento para verificar o caracter
verificaEspecial2:
	sb $s0, 0($t7) #guarda na matriz auxiliar o caracter especial
	addi $t7, $t7, 1 #incrementa o apontador da matriz auxiliar
	j ordenaEspecial #retorna ao inicio do laço
	
#procedimento para verificar o caracter
verificaEspecial3:
	blt $s0, 123, ordenaEspecial #se $s0 <= 'z' salta para ordenaEspecial
	sb $s0, 0($t7) #guarda na matriz auxiliar o caracter especial
	addi $t7, $t7, 1 #incrementa o apontador da matriz auxiliar
	j ordenaEspecial #retorna ao inicio do laço
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
pre1ImprimeMatrizOrdenada:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t3, $zero#iniciando $t0(i) com 0
	move $t4, $t6 #iniciando $t1(apontador) com o endereço da matriz auxiliar
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatrizOrdenada #carrega a string saidaMatrizOrdenada para poder printar
	syscall #realiza a chamada de sistema
	j pre2ImprimeMatrizOrdenada #salta para o procedimento preCarregaMatriz
		
#preparação para imprimir a matriz
pre2ImprimeMatrizOrdenada:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento preImprimeMatriz 
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatrizOrdenada #salta para o procedimento carregaMatriz
	
#procedimento para imprimir a matriz
imprimeMatrizOrdenada:
	bgt $t5, $t1, pre2ImprimeMatrizOrdenada #se j > m salta para o procedimento pre2ImprimeMatriz
	lb $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatrizOrdenada #retorna para o inicio do laço

#procedimento para iniciar i e apontador
preTrocaColunas:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t3, $zero#iniciando $t0(i) com 0
	move $t4, $t2 #iniciando $t1(apontador) com o endereço da matriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatrizColunas #carrega a string saidaMatrizColunas para poder printar
	syscall #realiza a chamada de sistema
	j preImprimeColuna #salta para preImprimeColuna
	
#preparação para imprimir as colunas
preImprimeColuna:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento preImprimeMatriz 
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t6, $zero #zerando $t6(flag de troca)
	j imprimeColuna #salta para imprimeColuna
	
#procedimento para imprimir as colunas
imprimeColuna:
	bgt $t5, $t1, preImprimeColuna #se j > m salta para o procedimento preImprimeColuna
	addi $s1, $zero, 2 #carrega 2 em $s1
	div $t5, $s1 #i / 2
	mfhi $s1 #$s1 = i % 2
	beqz $s1, trocaColuna #se $s1 == 0 salta para trocaColuna
	lb $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	addi $t5, $t5, 1 #j++
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeColuna #retorna para o inicio do laço
	
#procedimento para trocar as colunas
trocaColuna:
	bnez $t6, trocaColuna2 #se flag != 0 salta para trocaColuna2
	addi $t6, $t6, 1 #flag++
	addi $s1, $t5, 2 #$s1 = j + 2
	bgt $s1, $t1, imprimeColunaAux #se $s1 > m salta para imprimeColunaAux
	addi $s1, $t4, 2 #desloca o apontador para a próxima posição par
	lb $s0, 0($s1) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	addi $t5, $t5, 1 #j++
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeColuna #retorna para o inicio do laço
	
#procedimento para trocar as colunas
trocaColuna2:
	move $t6, $zero #zerando $t6(flag de troca)
	subi $s1, $t4, 2 #retorna para a posição par anterior
	lb $s0, 0($s1) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	addi $t5, $t5, 1 #j++
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeColuna #retorna para o inicio do laço
	
#procedimento para imprimir coluna par sem troca
imprimeColunaAux:
	lb $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	addi $t5, $t5, 1 #j++
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeColuna #retorna para o inicio do laço
	
#procedimento para iniciar i e apontador
preTrocaLinhas:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatrizLinhas #carrega a string saidaMatrizLinhas para poder printar
	syscall #realiza a chamada de sistema
	move $t3, $zero #iniciando $t3(i) com 0
	move $t4, $t2 #iniciando $t4(apontador) com o endereço da matriz
	addi $s0, $zero, 1 #$iniciando $s0 com 1
	move $t6, $zero #zerando $t6(flag de troca)
	j verificaLinhas #salta para verificaLinhas
	
#procedimento para verificar se há linhas ímpares para trocar
verificaLinhas:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	addi $s1, $zero, 2 #carrega 2 em $s1
	div $t3, $s1 #i / 2
	mfhi $s1 #$s1 = i % 2
	beqz $s1, printaLinhas #se $s1 == 0 salta para printa linhas
	bnez $t6, trocaLinhas #se flag != 0 salta para trocaLinhas
	addi $s0, $s0, 2 #$s0 = $s0 + 2
	bgt $s0, $t0, printaLinhas #se $s0 > n salta para printaLinhas
	addi $t6, $t6, 1 #flag++
	move $t7, $t4 #salva a linha atual
	add $t4, $t4, $t1 #desloca apontador para a próxima linha
	add $s2, $t4, $t1 #salva em $s2 próxima linha
	j printaLinhaTrocada #salta para printaLinhaTrocada
	
#procedimento para printar a linha trocada
printaLinhaTrocada:
	bgt $t5, $t1, verificaLinhas #se j > m salta para o procedimento verificaLinhas
	lb $s1, 0($s2) #garrega o valor na posição ixj da matriz
	addi $t5, $t5, 1 #j++
	addi $s2, $s2, 1 #apontador desloca para a proxima posição da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j printaLinhaTrocada #retorna para o inicio do laço
	
#procedimento para trocar as linhas
trocaLinhas:
	addi $s0, $s0, 2 #$s0 = $s0 + 2
	move $t6, $zero #zerando $t6(flag de troca)
	add $t4, $t4, $t1 #desloca apontador para a próxima linha par
	move $s2, $t7 #salva em $t7 a linha ímpar anterior
	j printaLinhaTrocada #salta para printaLinhaTrocada

#procedimento para printar a linha
printaLinhas:
	bgt $t5, $t1, verificaLinhas #se j > m salta para o procedimento verificaLinhas
	lb $s1, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j printaLinhas #retorna para o inicio do laço
	
#procedimento para iniciar i e apontador
preVerificaPalindromo:
	move $t3, $zero#iniciando $t3(i) com 0
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	move $t4, $t2 #iniciando $t4(apontador) com o endereço da matriz
	j calculaLinhaPalindromo #salta para calculaLinhaPalindromo

#procedimento para deslocar o apontador
calculaLinhaPalindromo:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	add $t4, $t4, $t5 #desloca o apontador para a próxima linha
	subi $t4, $t4, 1 #$t4--
	add $t6, $t4, $t1 #calcula o ultimo caracter da linha
	subi $t6, $t6, 1 #$t6--
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	move $t7, $t4 #salva o endereço do primeiro caracter da linha
	j percorreLinhaPalindromo #salta para percorreLinhaPalindromo
	
#procedimento para percorrer a linha
percorreLinhaPalindromo:
	bgt $t5, $t1, calculaLinhaPalindromo #se j > m salta para o procedimento calculaLinhaPalindromo
	addi $t5, $t5, 1 #j++
	lb $s0, 0($t4) #carrega o caracter a esquerda
	lb $s1, 0($t6) #carrega o caracter a direita
	bne $s0, $s1, deslocaLinhaPalindromo #se $s0 != $s1 salta para deslocaLinhaPalindromo
	sub $s2, $t6, $t4 #calcula a distância entre os ponteiros
	addi $t4, $t4, 1 #desloca o apontador da direita para a proxima posição da matriz
	subi $t6, $t6, 1 #desloca o apontador da esquerda para a posição anterior da matriz
	bgtz $s2, percorreLinhaPalindromo #se distância <= 0 salta para prePrintaLinhaPalindromo
	j prePrintaLinhaPalindromo #retorna ao início do laço
	
#procedimento para definir $t5 como m+1
deslocaLinhaPalindromo:
	addi $t5, $t1, 1 #$t5 = m+1
	j calculaLinhaPalindromo #salta para calculaLinhaPalindromo
	
#preparação para printar a linha
prePrintaLinhaPalindromo:
	move $t4, $t6 #reseta o apontador para o inicio da linha
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida1Palindromo #carrega a string saida1Palindromo para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t3 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida2Palindromo #carrega a string saida2Palindromo para poder printar
	syscall #realiza a chamada de sistema
	addi $s0, $zero, 1 #inicia $s0 com 1
	j printaLinhaPalindromo #salta para printaLinhaPalindromo
	
#procedimento para printar a linha
printaLinhaPalindromo:
	bgt $s0, $t1, deslocaLinhaPalindromo #se $s0 > n salta para deslocaLinhaPalindromo
	lb $s1, 0($t7) #carrega a letra na posição ixj da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	addi $s0, $s0, 1 #$s0++
	addi $t7, $t7, 1 #apontador++
	j printaLinhaPalindromo #retorna ao inicio do laço
	
#procedimento para verificar se a matriz é quadrada
verificaQuadrada:
	beq $t0, $t1, preDiagonal #se n == m salta para preDiagonal
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, naoQuadrada #carrega a string naoQuadrada para poder printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para o procedimento retornaMain
	
#procedimento para iniciar i e apontador
preDiagonal:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, diagPrinc #carrega a string diagPrinc para poder printar
	syscall #realiza a chamada de sistema
	move $t3, $zero#iniciando $t3(i) com 0
	move $t4, $t2 #iniciando $t4(apontador) com o endereço da matriz
	j prePercorreDiagonal #salta para o procedimento prePercorreDiagonal
	
#preparação para encontrar a diagonal principal
prePercorreDiagonal:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento retornaMain 
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	j percorreDiagonal #salta para o procedimento percorrediagonal

#procedimento para encontrar a diagonal
percorreDiagonal:
	bgt $t5, $t1, prePercorreDiagonal #se j > m salta para o procedimento prePercorreDiagonal
	beq $t5, $t3, printaDiagonal #se j == i salta para printaDiagonal
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	j percorreDiagonal #retorna para o inicio do laço	
	
#procedimento para printar a diagonal
printaDiagonal:
	lb $s0, 0($t4) #carrega a letra na posição ixj da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	j percorreDiagonal #retorna para o inicio do laço
	
#preparação para verificar a matriz
preVerifica3:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, repete3 #carrega a string repete3 para poder printar
	syscall #realiza a chamada de sistema
	move $t3, $zero #zerando $t3(i)
	move $t5, $t2 #iniciando $t4(apontador) com o endereço da matriz
	j verifica3 #salta para verifica3
	
#procedimento para verificar quantas vezes cada elemento repete
verifica3:
	addi $t3, $t3, 1 #i++
	mul $s0, $t0, $t1 #$s0 = n * m
	bgt $t3, $s0, retornaMain #se i > $s0 salta para retornaMain
	addi $t4, $zero, 1 #iniciando $t4(j) com 1
	add $s0, $t2, $t3 #$s0 = $t2 + i
	move $t7, $s0 #iniciando $t4(apontador) com o endereço da matriz deslocada
	move $t6, $zero #zerando $t6(contador)
	lb $s0, 0($t5) #carrega o valor da matriz na posição i
	addi $t5, $t5, 1 #desloca o apontador
	j conta3 #salta para o procedimento conta3
	
#procedimento para contar quantas vezes o elemento repete
conta3:
	mul $s1, $t0, $t1 #$s1 = n * m
	bgt $t4, $s1, verifica3 #se j > $s1 salta para verifica3
	lb $s1, 0($t7) #carrega em $s1 o valor da matriz em $t7
	beq $s1, $s0, incrementa3 #se $s1 == $s0 salta para incrementa3
	addi $t4, $t4, 1 #j++
	addi $t7, $t7, 1 #desloca o apontador
	j conta3 #retorna ao início do laço
	
#procedimento para incrementar o contador
incrementa3:
	addi $t6, $t6, 1 #contador++
	addi $t4, $t4, 1 #j++
	addi $t7, $t7, 1 #desloca o apontador
	blt $t6, 3, conta3 #se contador < 3 salta para conta 3
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j verifica3 #salta para verifica3
		
#procedimento para printar o número de vogais
saidaVogais:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, qntdVogais #carrega a string qntdVogais para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t6 #carregando o valor de $t6 em $a0 para printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para o procedimento retornaMain

#procedimento para iniciar $t0 com 0, zerar o apontador e zerar o contador
pre1ImprimeVogais:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t3, $zero #iniciando $t3(i) com 0
	move $t4, $t2 #iniciando $t4(apontador) com o endereço da matriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatrizVogais #carrega a string saidaMatrizVogais para poder printar
	syscall #realiza a chamada de sistema
	move $t6, $zero #zerando $t6(contador de vogais)
	j pre2ImprimeVogais #salta para o procedimento pre2ImprimeVogais
		
#preparação para verificar as vogais
pre2ImprimeVogais:
	addi $t3, $t3, 1 #i++
	bgt $t3, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	addi $t5, $zero, 1 #iniciando $t5(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j trocaVogais #salta para o procedimento trocaVogais
	
#procedimento para trocar as vogais de minúsculo para maiúsculo
trocaVogais:
	bgt $t5, $t1, pre2ImprimeVogais #se j > m salta para o procedimento pre2ImprimeVogais
	lb $s1, 0($t4) #garrega o valor na posição ixj da matriz
	beq $s1, 97, trocaA #se $s1 == 'a' salta para trocaA
	beq $s1, 101, trocaE #se $s1 == 'e' salta para trocaE
	beq $s1, 105, trocaI #se $s1 == 'i' salta para trocaI
	beq $s1, 111, trocaO #se $s1 == 'o' salta para trocaO
	beq $s1, 117, trocaU #se $s1 == 'u' salta para trocaU
	beq $s1, 65, incrementaContadorVogal #se $s1 == 'A' salta para incrementaContadorVogal
	beq $s1, 69, incrementaContadorVogal #se $s1 == 'E' salta para incrementaContadorVogal
	beq $s1, 73, incrementaContadorVogal #se $s1 == 'I' salta para incrementaContadorVogal
	beq $s1, 79, incrementaContadorVogal #se $s1 == 'O' salta para incrementaContadorVogal
	beq $s1, 85, incrementaContadorVogal #se $s1 == 'U' salta para incrementaContadorVogal
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j trocaVogais #retorna para o inicio do laço
	
#procedimento para incrementar o contador
incrementaContadorVogal:
	addi $t6, $t6, 1#contador++
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j trocaVogais #retorna para o inicio do laço
	
#procediemnto para trocar 'a' por 'A'
trocaA:
	addi $s1, $zero, 65 #carrega o código ascii de 'A'
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #desloca o apontador
	addi $t6, $t6, 1#contador++
	j trocaVogais #retorna ao inicio do laço

#procediemnto para trocar 'e' por 'E'
trocaE:
	addi $s1, $zero, 69 #carrega o código ascii de 'E'
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #desloca o apontador
	addi $t6, $t6, 1#contador++
	j trocaVogais #retorna ao inicio do laço
	
#procediemnto para trocar 'i' por 'I'
trocaI:
	addi $s1, $zero, 73 #carrega o código ascii de 'I'
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #desloca o apontador
	addi $t6, $t6, 1#contador++
	j trocaVogais #retorna ao inicio do laço
	
#procediemnto para trocar 'o' por 'O'
trocaO:
	addi $s1, $zero, 79 #carrega o código ascii de 'O'
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #desloca o apontador
	addi $t6, $t6, 1#contador++
	j trocaVogais #retorna ao inicio do laço
	
#procediemnto para trocar 'u' por 'U'
trocaU:
	addi $s1, $zero, 85 #carrega o código ascii de 'U'
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s1 #carregando o valor de $s1 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #desloca o apontador
	addi $t6, $t6, 1#contador++
	j trocaVogais #retorna ao inicio do laço
		
#procedimento para alocar a matriz
alocaMatriz:
	mul $s0, $t0, $t1 #guarda em $s0 n*m
	li $v0, 9 #carregando 9 em $v0 para realizar a chamada de sistema
	move $a0, $s0 #copia o valor de $s0 em $a0
	syscall #aloca a memória
	move $t2, $v0 #salva o endereço base do vetor em $t1
	bgez $t2, iniciaMatriz #se o apontador >= 0 salta para o procedimento iniciaMatriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, erro #carrega a string erro para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
iniciaMatriz:
	move $t3, $zero#iniciando $t3(i) com 0
	move $t4, $t2 #iniciando $t4(apontador) com o endereço da matriz
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
	li $v0, 12 #carrega 12 em $v0 para fazer a leitura
	syscall #realiza a leitura
	sb $v0, 0($t4) #salva o valor lido na posição ixj da matriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a próxima posição da matriz
	j carregaMatriz #retorna ao inicio do laço
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
pre1ImprimeMatriz:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t3, $zero#iniciando $t0(i) com 0
	move $t4, $t2 #iniciando $t1(apontador) com o endereço da matriz
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
	lb $s0, 0($t4) #garrega o valor na posição ixj da matriz
	addi $t5, $t5, 1 #j++
	addi $t4, $t4, 1 #apontador desloca para a proxima posição da matriz
	li $v0, 11 #carregando 11 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #retorna para o inicio do laço
	
#procedimento para ler o valor de m
lerM:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaM #carrega a string leiaM para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t1, $v0 #salva o valor lido em $t0(n)
	blez $t1, saidaErro #se n <= 0 salta para saidaErro
	j retornaMain #salta para o procedimento retornaMain

#procedimento para ler o valor de n
lerN:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaN #carrega a string leiaN para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t0, $v0 #salva o valor lido em $t0(n)
	blez $t0, saidaErro #se n <= 0 salta para saidaErro
	j retornaMain #salta para o procedimento retornaMain
	
#procedimento para avisar que a entrada é invalida
saidaErro:
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
