# 				Sumário
#|    Linhas	|	Contúedo	|		Descrição		|
#|   18 - 90	|Escrita & Leitura	|Escrita e leitura de variáveis.	|
#|   95 - 179	|	Vetores		|Manipulação de Vetores			|		
#|   181 - 204 	|	Matriz		|Manipulação de Matrizes		|
#| 		|	Arquivos	|Manipulação de Arquivos		|
#|    210	|	Suporte		|Macros para facilitar o dia a dia	|




############################################################## MACROS ##############################################################################
					########################################################
					################## Escrita e Leitura ###################
					########################################################


#-- Macro para imprimir um número inteiro
# Descrição:
# - Utiliza a *syscall* para exibir o valor de um número inteiro na tela.
# Entradas:
# - `int_out`: Registrador contendo o número inteiro a ser exibido.
# Operação:
# - Carrega o código da *syscall* (1) em $v0 para impressão de inteiros.
# - Copia o valor do registrador `int_out` para $a0, que é o argumento da *syscall*.
.macro print_int(%int_out)
	li $v0, 1               # Carrega o código para imprimir inteiros
	add $a0, $zero, %int_out # Copia o valor do registrador para $a0
	syscall                 # Invoca a *syscall* de impressão
.end_macro


#-- Macro para ler um número inteiro e salvar em $a0
# Descrição:
# - Lê um número inteiro do usuário utilizando a *syscall* e armazena em $a0.
# Operação:
# - Carrega o código da *syscall* (5) em $v0 para leitura de inteiros.
# - Após a execução, o número digitado pelo usuário será salvo em $a0.
.macro scanf_int
	li $v0, 5               # Carrega o código para leitura de inteiros
	syscall                 # Invoca a *syscall* de leitura
.end_macro

#-- Macro para ler um número inteiro e salvar em `int_in`
# Descrição:
# - Lê um número inteiro do usuário utilizando a *syscall* e salva no registrador `int_in`.
# Entradas:
# - `int_in`: Registrador onde será armazenado o número lido.
# Operação:
# - Carrega o código da *syscall* (5) em $v0 para leitura de inteiros.
# - Copia o valor lido de $v0 para o registrador `int_in`.
.macro scanf_int(%int_in)
	li $v0, 5               # Carrega o código para leitura de inteiros
	syscall                 # Invoca a *syscall* de leitura
	addi %int_in, $v0, 0    # Copia o número lido para o registrador `int_in`
.end_macro

#-- Macro para imprimir uma string
# Descrição:
# - Imprime uma string armazenada na seção `.data` utilizando a *syscall*.
# Entradas:
# - `str_out`: Nome do rótulo da string (ou char) na memória.
# Operação:
# - Carrega o código da *syscall* (4) em $v0 para impressão de strings.
# - Usa `la` para carregar o endereço da string no registrador $a0, argumento da *syscall*.
.macro print_str(%str_out)
	li $v0, 4               # Carrega o código para imprimir strings
	la $a0, %str_out        # Carrega o endereço da string para $a0
	syscall                 # Invoca a *syscall* de impressão
.end_macro


#-- Macro para imprimir uma nova linha
# Descrição:
# - Imprime um caractere de nova linha ("\n") na tela.
# Operação:
# - Cria um rótulo em `.data` para armazenar o caractere de nova linha.
# - Carrega o código da *syscall* (4) em $v0 para impressão de strings.
# - Usa `la` para carregar o endereço do rótulo em $a0 e executa a *syscall*.
.macro ln()
	.data
		lineNext: .asciiz "\n" # Armazena o caractere de nova linha
	.text
		la $a0, lineNext       # Carrega o endereço de "lineNext" para $a0
		li $v0, 4             # Carrega o código para imprimir strings
		syscall               # Invoca a *syscall* de impressão
.end_macro



					########################################################
					####################### Vetores ########################
					########################################################

#-- Macro para ler números do usuário e salvar em um vetor
# Descrição:
# - Preenche um vetor na memória com números fornecidos pelo usuário.
# - Para cada posição do vetor, exibe uma mensagem indicando o índice atual e aguarda o número digitado.
# Entradas:
# - `%vetor`: Nome do vetor onde os números serão armazenados.
# - `%tam`: Registrador contendo o tamanho do vetor.
# - `%pos`: Registrador auxiliar para calcular o endereço da posição atual no vetor.
# - `%cont`: Registrador usado como contador para rastrear o índice do vetor.
# - `%aux`: Registrador que armazena temporariamente o número lido antes de ser salvo.
# Operação:
# - Zera os registradores auxiliares.
# - Para cada índice, exibe a mensagem "Vetor[i]: " e lê um número do usuário.
# - Salva o número no endereço correspondente no vetor.
# - Incrementa os índices e repete o processo até que o vetor esteja preenchido.
.macro lendo_um_vetor(%vetor, %tam, %pos, %cont, %aux)
	.data
		LUV_ent1: .asciiz "Vetor["   # Parte fixa da mensagem de entrada
		LUV_ent2: .asciiz "]: "      # Fechamento da mensagem
	.text
	# Zerando os registradores auxiliares
	move %pos, $zero
	move %cont, $zero
	move %aux, $zero
	
	LUV_preenchendo_o_vetor:
		# Exibe mensagem e solicita número ao usuário
		print_str(LUV_ent1)    # Exibe "Vetor["
		print_int(%cont)       # Exibe o índice atual
		print_str(LUV_ent2)    # Exibe "]: "
		scanf_int(%aux)        # Lê o número digitado
		
		# Salva o número no vetor
		sw %aux, %vetor(%pos)
		
		# Incrementa os índices
		addi %cont, %cont, 1
		addi %pos, %pos, 4  # Salta para a próxima posição no vetor
		
		# Verifica se ainda há posições para preencher
		blt %cont, %tam, LUV_preenchendo_o_vetor
.end_macro

#-- Macro para imprimir os valores de um vetor
# Descrição:
# - Percorre um vetor na memória e exibe os valores armazenados, indicando o índice de cada posição.
# Entradas:
# - `%vetor`: Nome do vetor cujos valores serão exibidos.
# - `%tam`: Registrador contendo o tamanho do vetor.
# - `%pos`: Registrador auxiliar para calcular o endereço da posição atual no vetor.
# - `%cont`: Registrador usado como contador para rastrear o índice do vetor.
# - `%aux`: Registrador que armazena temporariamente o valor da posição atual para exibição.
# Operação:
# - Zera os registradores auxiliares.
# - Para cada índice, carrega o valor do vetor, exibe o índice e o valor correspondente.
# - Incrementa os índices e repete o processo até que todos os valores sejam exibidos.
.macro imprimindo_um_vetor(%vetor, %tam, %pos, %cont, %aux)
	.data
		IUV_ent1: .asciiz "Vetor["   # Parte fixa da mensagem de impressão
		IUV_ent2: .asciiz "]: "      # Fechamento da mensagem
	.text
	# Zerando os registradores auxiliares
	move %pos, $zero
	move %cont, $zero
	move %aux, $zero
	
	IUV_imprimindo_o_vetor:
		# Carrega o valor do vetor na posição atual
		lw %aux, %vetor(%pos)
		
		# Exibe o índice e o valor correspondente
		print_str(IUV_ent1)    # Exibe "Vetor["
		print_int(%cont)       # Exibe o índice atual
		print_str(IUV_ent2)    # Exibe "]: "
		print_int(%aux)        # Exibe o valor armazenado
		ln                     # Insere uma nova linha
		
		# Incrementa os índices
		addi %cont, %cont, 1
		addi %pos, %pos, 4  # Salta para a próxima posição no vetor
		
		# Verifica se ainda há posições para imprimir
		blt %cont, %tam, IUV_imprimindo_o_vetor
.end_macro


					########################################################
					######################## Matriz ########################
					########################################################

#-- Macro para calcular o endereço de um elemento de uma matriz 2D
# Entradas:
# linha = Registrador contendo o índice da linha (i) que será acessada.
# coluna = Registrador contendo o índice da coluna (j) que será acessada.
# ncolunas = Registrador contendo o número de colunas da matriz (ncol).
# base = Registrador contendo o endereço base da matriz na memória.
# resultado = Registrador onde será armazenado o endereço calculado do elemento Mat[i][j].
#
# Operação:
# Calcula o endereço do elemento (i, j) da matriz usando a fórmula:
# endereço = base + [(i * ncol) + j] * 4
# Cada elemento da matriz é assumido como ocupando 4 bytes.
.macro matriz_indice(%linha, %coluna, %ncolunas, %base, %resultado)
    mult %linha, %ncolunas      		# Multiplica a linha pelo número de colunas: i * ncol
    mflo %resultado                 		# Armazena o resultado no registrador de saída
    add %resultado, %resultado, %coluna  	# Soma o índice da coluna: (i * ncol) + j
    sll %resultado, %resultado, 2        	# Multiplica por 4 (tamanho de cada elemento): [(i * ncol) + j] * 4
    add %resultado, %resultado, %base   	# Soma o endereço base da matriz
.end_macro

#-- Comentar mais tarde
.macro AUX_perguntar_numero(%linha, %coluna, %var)
	.data
	ent1: .asciiz "Insira o valor de Mat["
	ent2: .asciiz "]["
	ent3: .asciiz "]: "
	.text
	print_str(ent1)
	print_int(%linha)
	print_str(ent2)
	print_int(%coluna)
	print_str(ent3)
	scanf_int(%var)
.end_macro

#-- Comentar
.macro matriz_add_num(%pos, %num, %linha, %coluna, %ncolunas, %base)
	matriz_indice(%linha, %coluna, %ncolunas, %base, %pos)
	sw %num (%pos)
.end_macro

.macro matriz_leitura(%aux_linha, %aux_coluna, %n_linha, %n_coluna, %end_matriz, %aux1, %aux2)
	li %aux_linha, 0
	li %aux_coluna, 0
	subi $sp, $sp, 4
colunas:
	AUX_perguntar_numero(%aux_linha, %aux_coluna, %aux1)
	matriz_add_num(%aux2, %aux1, %aux_linha, %aux_coluna, %n_coluna, %end_matriz)
	addi %aux_coluna, %aux_coluna, 1
	blt %aux_coluna, %n_coluna, colunas
	
	li %aux_coluna, 0
	addi %aux_linha, %aux_linha, 1
	blt %aux_linha, %n_linha, colunas
	li %aux_linha, 0
	addi $sp, $sp, 4
.end_macro

.macro matriz_escrita(%aux_linha, %aux_coluna, %n_linha, %n_coluna, %end_matriz, %aux1, %aux2)
	li %aux_linha, 0
	li %aux_coluna, 0
	subi $sp, $sp, 4
colunas:
	esp
	matriz_indice(%aux_linha, %aux_coluna, %n_coluna, %end_matriz, %aux1)
	lw %aux2, (%aux1)
	print_int(%aux2)
	esp
	addi %aux_coluna, %aux_coluna, 1
	blt %aux_coluna, %n_coluna, colunas
	
	ln
	li %aux_coluna, 0
	addi %aux_linha, %aux_linha, 1
	blt %aux_linha, %n_linha, colunas
	
	li %aux_linha, 0
	addi $sp, $sp, 4
.end_macro


					########################################################
					####################### Arquivos #######################
					########################################################


					########################################################
					####################### Suporte ########################
					########################################################

#-- Macro para encerrar o programa
# Descrição:
# Finaliza a execução do programa MIPS chamando a *system call* para encerramento.
# - Não requer entradas ou saídas.
# - Utiliza $v0 = 10 para invocar a *system call* de término.
.macro end
	li $v0, 10      # Carrega o código de *syscall* para encerrar o programa
	syscall          # Invoca a *syscall* para terminar a execução
.end_macro

.macro esp()
	li $v0, 11		# C�digo para impress�o de caractere
	la $a0, 32		# C�digo ASCII para espa�o
	syscall
.end_macro
.#-- Macro para alocar memória dinamicamente
# Descrição:
# Utiliza a *system call* de alocação de memória para reservar um bloco de memória de tamanho especificado.
# Entradas:
# - qntd_bytes: Registrador contendo a quantidade de bytes a serem alocados.
# - ponteiro: Registrador onde será armazenado o endereço da memória alocada.
# Operação:
# - Carrega o número de bytes a serem alocados em $a0.
# - Usa $v0 = 9 para invocar a *syscall* de alocação de memória.
# - Após a execução, o endereço da memória alocada é armazenado no registrador `ponteiro`.
.macro malloc(%qntd_bytes, %ponteiro)
	move $a0, %qntd_bytes   # Copia a quantidade de bytes para $a0 (argumento da syscall)
	li $v0, 9               # Carrega o código da *syscall* para alocar memória
	syscall                 # Invoca a *syscall* de alocação
	move %ponteiro, $v0     # Armazena o endereço retornado em %ponteiro
.end_macro
