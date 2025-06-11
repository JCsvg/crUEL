.data
	space: .asciiz " "
	pulaLinha: .asciiz "\n"
	ent1Mat: .asciiz "Insira a "
	ent2Mat: .asciiz "° nota do "
	ent3Mat: .asciiz "° aluno: "
	leiaN: .asciiz "Insira o valor de n: "
	erro: .asciiz "Erro ao alocar memória!"
	saida1: .asciiz "° aluno: "
	saida2: .asciiz "média: "
	mediaGeral: .asciiz "A média geral da turma foi: "
	numAprovados: .asciiz " alunos foram aprovados."
	numReprovados: .asciiz " alunos foram reprovados."
	
	zero: .align 3
	.float 0.0
	tres: .align 3
	.float 3.0
	seis: .align 3
	.float 6.0
	
.text
#procedimento main
main:
	jal lerN #procedimento para ler n
	jal processamento #salta para processamento
	jal preSaida #salta para preSaida
	j encerrar #salta para encerrar
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
preSaida:
	move $t2, $zero #iniciando $t0(i) com 0
	move $t3, $t1 #iniciando $t3(apontador) com o endereço da matriz
	j pre2Saida #salta para pre2Saida
	
#preparação para exibir as saídas
pre2Saida:
	addi $t2, $t2, 1 #i++
	bgt $t2, $t0, saidaGeral #se i > n salta para o procedimento saidaGeral
	addi $t4, $zero, 1 #iniciando $t4(j) com 1
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t2 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, saida1 #carrega a string saida1 para poder printar
	syscall #realiza a chamada de sistema
	j saida #salta para saida
	
#procedimento para exibir as notas
saida:
	bgt $t4, 3, saidaMedia #se j > 3 salta para o procedimento saidaMedia
	l.s $f12, 0($t3) #carrega a iésima nota do iésimo aluno
	li $v0, 2 #carregando 1 em $v0 para fazer a chamada de sistema
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, space #carrega a string space para poder printar
	syscall #realiza a chamada de sistema
	addi $t3, $t3, 32 #desloca o apontador
	addi $t4, $t4, 1 #j++
	j saida #retorna ao início do laço
	
#procedimento para exibir a saída
saidaMedia:
	l.s $f12, 0($t3) #carrega a iésima nota do iésimo aluno
	li $v0, 2 #carregando 1 em $v0 para fazer a chamada de sistema
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	addi $t3, $t3, 32 #desloca o apontador
	j pre2Saida #salta para pre2Saida
	
#procedimento para exibir a media geral, o número de aprovados e reprovados
saidaGeral:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, mediaGeral #carrega a string mediaGeral para poder printar
	syscall #realiza a chamada de sistema
	mtc1 $t0, $f6 #converte n para float
	cvt.s.w $f7, $f6 #converte n para float
	div.s $f4, $f3, $f7 #calcula a média geral
	mov.s $f12, $f4 #carrega a media da turma em $f12
	li $v0, 2 #carregando 1 em $v0 para fazer a chamada de sistema
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t5 #carregando o número de aprovados em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, numAprovados #carrega a string numAprovados para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, pulaLinha #carrega a string pulaLinha para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t6 #carregando o número de reprovados $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, numReprovados #carrega a string numReprovados para poder printar
	syscall #realiza a chamada de sistema
	j retornaMain #salta para retornaMain
	
#procedimento para iniciar $t0 com 0 e zerar o apontador
processamento:
	move $t2, $zero #iniciando $t0(i) com 0
	move $t3, $t1 #iniciando $t3(apontador) com o endereço da matriz
	l.s $f3, zero #zerando $f3(média da turma)
	move $t5, $zero #zerando $t5(aprovados)
	move $t6, $zero #zerando $t6(reprovados)
	j preLerNotas #salta para o procedimento preLerNotas
	
#preparação para ler as notas
preLerNotas:
	addi $t2, $t2, 1 #i++
	bgt $t2, $t0, retornaMain #se i > n salta para o procedimento retornaMain
	addi $t4, $zero, 1 #iniciando $t4(j) com 1
	l.s $f1, zero #zerando $f1(média)
	j lerNotas #salta para lerNotas
	
#procedimento para ler as notas
lerNotas:
	bgt $t4, 3, calculaMedia #se j > 3 salta para o procedimento calculaMedia
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent1Mat #carrega a string ent1Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t4 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent2Mat #carrega a string ent2Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 1 #carregando 1 em $v0 para fazer a chamada de sistema
	move $a0, $t2 #carregando o valor de i em $a0 para printar
	syscall #realiza a chamada de sistema
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, ent3Mat #carrega a string ent3Mat para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 6 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	s.s $f0, 0($t3) #guarda o valor lido na posição i da matriz
	addi $t3, $t3, 32 #desloca o apontador
	addi $t4, $t4, 1 #j++
	add.s $f1, $f1, $f0 #media = media + valor lido
	j lerNotas #retorna ao início do laço
	
#procedimento para calcular a média
calculaMedia:
	l.s $f2, tres #carrega 3 em $f2
	div.s $f1, $f1, $f2 #calcula a média
	s.s $f1, 0($t3) #guarda a média
	add.s $f3, $f3, $f1 #somando a média geral
	addi $t3, $t3, 32 #desloca o apontador
	l.s $f4, seis #carrega 6 em $f4
	c.lt.s $f1, $f4 #verifica se $f1 < 6
	bc1t reprova #se true salta para reprova
	addi $t5, $t5, 1 #aprovados++
	j preLerNotas #salta para preLerNotas
	
#procedimento para contar os reprovados
reprova:
	addi $t6, $t6, 1 #reprovados++
	j preLerNotas #salta para preLerNotas
		
#procedimento para ler o valor de n
lerN:
	li $v0, 4 #carregando 4 em $v0 para fazer a chamada de sistema
	la $a0, leiaN #carrega a string leiaN para poder printar
	syscall #realiza a chamada de sistema
	li $v0, 5 #carrega 5 em $v0 para fazer a leitura
	syscall #realiza a leitura
	move $t0, $v0 #salva o valor lido em $t0(n)
	j alocaMatriz #salta para o procedimento alocaMatriz
	
#procedimento para alocar a matriz
alocaMatriz:
	mul $s0, $t0, 4 #guarda em $s0 n*4
	mul $s0, $s0, 32 #guarda em $s0 a quantidade de bits para a matriz
	li $v0, 9 #carregando 9 em $v0 para realizar a chamada de sistema
	move $a0, $s0 #copia o valor de $s0 em $a0
	syscall #aloca a memória
	move $t1, $v0 #salva o endereço base do vetor em $t1
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
