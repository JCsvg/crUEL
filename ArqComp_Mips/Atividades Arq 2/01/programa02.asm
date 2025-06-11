.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	ent1Mat: .asciiz "Insira o valor em A["
	ent2Mat: .asciiz "]["
	ent3Mat: .asciiz "]: "
	saidaMatriz: .asciiz "A matriz lida foi:"
	leiaN: .asciiz "Insira a dimensão da matriz quadrada: "
	erro: .asciiz "Erro ao alocar memória!"
	saidaNao: .asciiz "A matriz não é de permutação!"
	saidaSim: .asciiz "A matriz é de permutação!"

.text
#procedimento main
main:
	jal lerN #salta para o procedimento lerN
	jal iniciaMatriz #salta para o procedimento inicia matriz
	jal verificaMatriz #salta para o procedimento verificaMatriz
	j encerrar #salta para o procedimento encerrar
	
#procedimento para iniciar $t2 com 0 e iniciar o apontador
verificaMatriz:
	move $t2, $zero#iniciando $t2(i) com 0
	move $t3, $t1 #iniciando $t3(apontador) com o endereço base da matriz salvo em $t1
	j preVerificaLinha #salta para o procedimento preVerificaLinha
	
#preparação para verificar as linhas da matriz
preVerificaLinha:
	addi $t2, $t2, 1 #i++
	bgt $t2, $t0, pre1VerificaColuna #se i > n salta para o procedimento pre1VerificaColuna 
	addi $t4, $zero, 1 #iniciando $t4(j) com 1
	move $t5, $zero #zerando $t5 que servirá para contar quantos elementos há em cada linha e coluna
	j verificaLinha #salta para o procedimento verificaLinha
	
#procedimento para verificar as linhas da matriz
verificaLinha:
	bgt $t4, $t0, preVerificaLinha #se j > n salta para o procedimento preVerificaLinha
	lw $s0, 0($t3) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #j++
	addi $t3, $t3, 4 #apontador desloca para a proxima posição da matriz
	beqz $s0, verificaLinha #se o elemento ij da matriz for igual a 0 retorna ao inicio do laço
	addi $t5, $t5, 1 #somando 1 em $t5
	bgt $t5, 1, saidaErro #se $t5 > 1 salta para o procedimento saidaErro
	j verificaLinha #retorna para o inicio do laço
	
#procedimento para iniciar $t2 com 0 e iniciar o apontador
pre1VerificaColuna:
	move $t2, $zero#iniciando $t2(j) com 0
	move $t3, $t1 #iniciando $t3(apontador) com o endereço base da matriz salvo em $t1
	j pre2VerificaColuna #salta para o procedimento pre2VerificaColuna
	
#preparação para verificar as colunas da matriz
pre2VerificaColuna:
	addi $t2, $t2, 1 #j++
	bgt $t2, $t0, saida #se j > n salta para o procedimento saida
	addi $t4, $zero, 1 #iniciando $t4(i) com 1
	move $t6, $t3 #guarda em $t6 o endereço em $t3
	move $t5, $zero #zerando $t5 que servirá para contar quantos elementos há em cada linha e coluna
	j verificaColuna #salta para o procedimento verificaColuna
	
#procedimento para verificar as colunas
verificaColuna:
	bgt $t4, $t0, deslocaApontador #se i > n salta para o procedimento deslocaApontador
	lw $s0, 0($t6) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #i++
	mul $s1, $t0, 4 #$s0 = n * 4
	add $t6, $t6, $s1 #apontador desloca para a proxima posição da matriz
	beqz $s0, verificaColuna #se o elemento ij da matriz for igual a 0 retorna ao inicio do laço
	addi $t5, $t5, 1 #somando 1 em $t5
	bgt $t5, 1, saidaErro #se $t5 > 1 salta para o procedimento saidaErro
	j verificaColuna #retorna para o inicio do laço
	
#procedimento para deslocar o apontador
deslocaApontador:
	addi $t3, $t3, 4 #desloca para a proxima coluna
	j pre2VerificaColuna #salta para o procedimento pre2VerificaColuna
	
#procedimento para printar que a matriz é de permutação
saida:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaSim #carrega a string saidaSim para poder printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para o procedimento RetornaMain
	
#procedimento para iniciar $t2 com 0 e iniciar o apontador
iniciaMatriz:
	move $t2, $zero#iniciando $t2(i) com 0
	move $t3, $t1 #iniciando $t3(apontador) com o endereço base da matriz salvo em $t1
	j preCarregaMatriz #salta para o procedimento preCarregaMatriz
	
#preparação para carregar os valores da matriz
preCarregaMatriz:
	addi $t2, $t2, 1 #i++
	bgt $t2, $t0, pre1ImprimeMatriz #se i > n salta para o procedimento preImprimeMatriz 
	addi $t4, $zero, 1 #iniciando $t4(j) com 1
	j carregaMatriz #salta para o procedimento carregaMatriz
	
#procedimento para fazer a leitura dos valores da matriz
carregaMatriz:
	bgt $t4, $t0, preCarregaMatriz #se j > n salta para o procedimento preCarregaMatriz
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent1Mat #carrega a string ent1Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t2 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent2Mat #carrega a string ent2Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t4 #carregando o valor de j em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent3Mat #carrega a string ent3Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	sw $v0, 0($t3) #salva o valor lido na posição ixj da matriz
	addi $t4, $t4, 1 #j++
	addi $t3, $t3, 4 #apontador desloca para a próxima posição da matriz
	j carregaMatriz #retorna ao inicio do laço

#procedimento para iniciar $t0 com 0 e zerar o apontador
pre1ImprimeMatriz:
	move $t2, $zero#iniciando $t2(i) com 0
	move $t3, $t1 #iniciando $t3(apontador) com o endereço base da matriz salvo em $t1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaMatriz #carrega a string saidaMatriz para poder printar
	syscall #realiza a chamada de sistema
	j pre2ImprimeMatriz #salta para o procedimento preCarregaMatriz
	
#preparação para imprimir a matriz
pre2ImprimeMatriz:
	addi $t2, $t2, 1 #i++
	bgt $t2, $t0, retornaMain #se i > n salta para o procedimento preImprimeMatriz 
	addi $t4, $zero, 1 #iniciando $t4(j) com 1
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #salta para o procedimento carregaMatriz

#procedimento para imprimir a matriz
imprimeMatriz:
	bgt $t4, $t0, pre2ImprimeMatriz #se j > n salta para o procedimento pre2ImprimeMatriz
	lw $s0, 0($t3) #garrega o valor na posição ixj da matriz
	addi $t4, $t4, 1 #j++
	addi $t3, $t3, 4 #apontador desloca para a proxima posição da matriz
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $s0 #carregando o valor de $s0 em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	j imprimeMatriz #retorna para o inicio do laço
	
#procedimento para ler a dimensão da matriz
lerN:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaN #carrega a string leiaN para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t0, $v0 #salva o valor lido em $t0(n)
	j alocaMatriz #salta para o procedimento alocaMatriz
	
#procedimento para alocar memória para a matriz
alocaMatriz:
	mul $s0, $t0, $t0 #$s0 = n*n
	mul $s1, $s0, 4 #salva em $s1 a quantidade de bytes da matriz
	li $v0, 9 #carregando 9 em $v0 para realizar a chamada de sistema
	move $a0, $s1 #copia o valor de $s1 em $a0
	syscall #aloca a memória
	move $t1, $v0 #salva o endereço base da matriz em $t1
	bgez $t1, retornaMain #se o apontador >= 0 salta para o procedimento retornaMain
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, erro #carrega a string erro para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar
	
#procedimento para imprimir que a matriz não é de permutação
saidaErro:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saidaNao #carrega a string saidaNao para poder printar
	syscall #realiza a chamada de sistema
	j encerrar #salta para o procedimento encerrar

#procedimento para retornar ao main
retornaMain:
	jr $ra #retorna onde parou no main
	
#procedimento para encerrar o programa
encerrar:
	li $v0, 10 #carregando 10 em $v0 para encerrar o programa
	syscall #realizando a chamada de sistema