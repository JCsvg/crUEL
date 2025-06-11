.macro scanf_str(%rg, %tam)
    li $v0, 8                  	# Código da syscall para ler string
    la $a0, %rg			# Carrega o endereço do buffer no $a0
    li $a1, %tam               	# Define o comprimento máximo da string em $a1
    syscall                     # Executa a syscall
    
    # Verifica se o último caractere é '\n' e substitui por '\0'
    li $t0, 0                   # Inicializa um índice
    la $t1, %rg                 # Carrega o endereço do buffer em $t1
check_novaLinha:
    lb $t2, 0($t1)              	# Carrega o caractere atual
    beq $t2, $zero, fim_check   	# Se for '\0', termina
    beq $t2, 10, encontrando_fim 	# Se for '\n', substitui por '\0'
    addi $t1, $t1, 1            	# Avança para o próximo caractere
    j check_novaLinha           	# Repete o loop

encontrando_fim:
    sb $zero, 0($t1)           		# Substitui '\n' por '\0'
fim_check:
.end_macro

.macro print_str(%rg)
    li $v0, 4		# Código da syscall para imprimir string
    la $a0, %rg		# Carrega o endereço do buffer no $a0
    syscall		# Executa a syscall
.end_macro

.macro print_int(%rg)
    move $a0, %rg       # Move o valor do registrador para $a0
    li $v0, 1		# Código da syscall para imprimir inteiro
    syscall            	# Executa a syscall
.end_macro

 .macro verifica_palidromo(%str)
        # Remove o caractere de nova linha e conta o tamanho
        la $t0, %str           		# Caractere atual da string
        li $t1, 0              		# Tamanho da string
    contador_loop:
        lb $t2, 0($t0)         		# Caractere atual
        beq $t2, 10, fim_contador 	# Se for '\n', termina a contagem
        beq $t2, 0, fim_contador  	# Se for nulo, termina a contagem
        addi $t0, $t0, 1       		# Próximo caractere
        addi $t1, $t1, 1       		# Incrementa o tamanho
        j contador_loop
    fim_contador:

        # Define os índices inicial e final
        li $t3, 0              # Índice do início da string
        sub $t4, $t1, 1        # Índice do final da string (tamanho - 1)

    check_loop:
        bge $t3, $t4, verdadeiro 	# Se cruzou o meio, é palíndromo
        lb $t5, %str($t3)      		# Caractere do início
        lb $t6, %str($t4)      		# Caractere do final
        bne $t5, $t6, falso 		# Se diferentes, não é palíndromo
        addi $t3, $t3, 1       		# Próximo caractere do início
        subi $t4, $t4, 1       		# Próximo caractere do final
        j check_loop           		# Continua verificando

    verdadeiro:
    	addi $t7, $zero, 1
        print_int $t7
        j end_macro

    falso:
  	move $t7, $zero  
        print_int $t7
    end_macro:
.end_macro


.data
    ent1: .asciiz "Insira a palavra: \n"
    str1: .space 100

.text
    .globl main

main:
    print_str ent1              	# Imprime mensagem de entrada
    scanf_str str1, 100         	# Lê a string do usuário
    verifica_palidromo str1

    # Finaliza o programa
    li $v0, 10
    syscall
