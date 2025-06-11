.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	ent1Mat: .asciiz "Insira o valor em A["
	ent2Mat: .asciiz "]["
	ent3Mat: .asciiz "]: "
	saidaMatriz: .asciiz "A matriz lida foi:"
	saidaSub: .asciiz "O resultado da subtração é: "
	maior: .asciiz "O maior elemento acima da diagonal principal: "
	menor: .asciiz "O menor elemento abaixo da diagonal principal: "
	matrizOrdenada: .asciiz "A matriz ordenada crescentemente:"
	
	mat: .align 2
	     .space 64
	     
.text
#procedimento main
main:
	jal iniciaMatriz #salta para o procedimento inicia matriz
	jal preparaProcessamento #salta para o procedimento preparaProcessamento
	jal preparaOrdena #salta para o procedimento preparaOrdena
	j encerrar #salta para o procedimento encerrar

#preparação para recursão
preparaOrdena:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string quebraLinha para poder printar
	syscall #realiza a chamada de sistema
	move $t0, $zero #zerando o registrador $t0
	j preOrdena #salta para o procedimento preOrdena
	
#preparação para ordenar a matriz
preOrdena:
	addi $s0, $zero, 16 #definindo $s0 como 16
	bgt $t0, 16, preImprimeOrdenada #se $t0 > 16 salta para o procedimento preImprimeOrdenada
	sub $t1, $s0, $t0 #$t1 = n - i
	subi $t1, $t1, 1 # $t1 = $t1 - 1
	addi $t2, $zero, 1 #inicializando o registrador $t2 com 1
	move $t3, $zero #zerando $t3
	lw $t4, mat($t3) #carregando o primeiro valor da matriz
	addi $t3, $t3, 4 #somando 4 para ir para a segunda posição da matriz
	addi $t0, $t0, 1 #somando 1 em $t0
	j ordenaMatriz #salta para o procedimento ordenaMatriz

#procedimento para ordenar o vetor
ordenaMatriz:
	bgt $t2, $t1, preOrdena #se $t2 > $t1 salta para o procedimento preOrdena
	lw $t5, mat($t3) #carregando o valor na posição i da matriz
	la $t6, verificaTroca #guarda o endereço do procedimento verificaTroca em $t6
	jalr $t7, $t6 #salta para $t6 e guarda o PC em $t7
	addi $t2, $t2, 1 #incrementa 1 no contador
	addi $t3, $t3, 4 #incrementa 4 em $t2 para percorrer a matriz
	j ordenaMatriz #retorna para o inicio do laço

#procedimento para verificar se $t4 < $t3
verificaTroca:
	blt $t5, $t4, troca #se $t5 < $t4 salta para o procedimento troca
	move $t4, $t5 #carrega o valor de $t5 em $t4
	jr $t7 #retorna para o ponto onde parou no procedimento ordenaMatriz

#procedimento para trocar 2 valores de posição no vetor
troca:
	sw $t4, mat($t3) #guarda na posição i do vetor o valor em $t4
	subi $t3, $t3, 4 #subtrai 4 em $t3 para retornar a posição i-1 da matriz
	sw $t5, mat($t3) #guarda na posição i-1 do vetor o valor de $t5
	addi $t3, $t3, 4 #soma 8 em $t3 para ir para a posição i da matriz
	jr $t7 #retorna para o ponto onde parou no procedimento ordenaMatriz

#procedimento para iniciar $t0 com 0 e zerar o apontador
preparaProcessamento:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	addi $t3, $zero, -99999 #iniciando $t1 com -99999(maior)
	addi $t4, $zero, 99999 #iniciando $t1 com 99999(menor)
	move $t5, $zero #zerando $t1(soma acima)
	move $t6, $zero #zerando $t1(soma abaixo)
	j preProcessamento #salta para o procedimento preProcessamento
	
#preparação para realizar as somas e encontrar o maior elemento acima e o menor elemento abaixo da diagonal principal
preProcessamento:
	addi $t0, $t0, 1 #i++
	bgt $t0, 4, subSaida #se i > 4 salta para o procedimento subSaida 
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	j processamento #salta para o procedimento processamento
	
#procedimento para realizar as somas e encontrar o maior elemento acima e o menor elemento abaixo da diagonal principal
processamento:
	bgt $t2, 4, preProcessamento #se j > 4 salta para o procedimento preprocessamento
	bgt $t2, $t0, somaAcima #se j < i salta para o procedimento somaAcima
	blt $t2, $t0, somaAbaixo #se j > i salta para o procedimento somaAbaixo
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	j processamento #retorna ao início do laço
	
#procedimento para apresentar as saídas do maior e menor elemento e da subtração
subSaida:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, maior #carrega a string maior para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t3 #carregando o valor de $t3 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, menor #carrega a string menor para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t4 #carregando o valor de $t4 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaSub #carrega a string saidaSub para poder printar
	syscall #realiza a chamada de sistema
	sub $s0, $t5, $t6 #guarda em $s0 soma acima - soma abaixo
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para o procedimento retornaMain
	
#procedimento para somar os elementos abaixo da diagonal principla
somaAbaixo:
	lw $s0, mat($t1) #garrega o valor na posição ixj da matriz
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	add $t6, $t6, $s0 #soma abaixo = soma abaixo + valor
	blt $s0, $t4, alteraMenor #se valor < menor salta para o procedimento alteraMenor
	j processamento #retorna ao início do laço
	
#procedimento para alterar o menor valor abaixo da diagonal principal
alteraMenor:
	move $t4, $s0 #salva o novo menor valor
	j processamento #retorna ao início do laço
	
#procedimento para somar os elementos acima da diagonal principal
somaAcima:
	lw $s0, mat($t1) #garrega o valor na posição ixj da matriz
	addi $t2, $t2, 1 #j++
	addi $t1, $t1, 4 #apontador desloca para a proxima posição da matriz
	add $t5, $t5, $s0 #soma acima = soma acima + valor
	bgt $s0, $t3, alteraMaior #se valor > maior salta para o procedimento alteraMaior
	j processamento #retorna ao início do laço
	
#procedimento para alterar o maior valor acima da diagonal principal
alteraMaior:
	move $t3, $s0 #salva o novo maior valor
	j processamento #retorna ao início do laço

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
	bgt $t2, 4, preCarregaMatriz #se j > 4 salta para o procedimento preCarregaMatriz
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
preImprimeOrdenada:
	move $t0, $zero#iniciando $t0(i) com 0
	move $t1, $zero #zerando $t1(apontador)
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, matrizOrdenada #carrega a string matrizOrdenada para poder printar
	syscall #realiza a chamada de sistema
	j pre2ImprimeMatriz #salta para o procedimento preCarregaMatriz

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
	bgt $t0, 4, retornaMain #se i > 4 salta para o procedimento retornaMain
	addi $t2, $zero, 1 #iniciando $t2(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #salta para o procedimento carregaMatriz

#procedimento para imprimir a matriz
imprimeMatriz:
	bgt $t2, 4, pre2ImprimeMatriz #se j > 4 salta para o procedimento pre2ImprimeMatriz
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