#	+-----------------------------------------------------------------------------+
#	|                   Arquitetura de Computadores II - 1COP012                  |
#	|                                Atividade 04                                 |
#	+-----------------------------------------------------------------------------+
#	| Aluno: Jader Gomes Cardoso Junior                                           |
#	|                                                                             |
#	| Descrição: Este programa realiza a leitura lê um CPF com 11 dígitos e um    | 
#	| traço separador (xxxxxxxxx-xx), valida o formato da entrada e verifica sua  |
#	| autenticidade. Ele realiza cálculos nos dígitos para confirmar se os 	      |
#	| dígitos verificadores são corretos, indicando se o CPF é válido ou inválido.|
#	+-----------------------------------------------------------------------------+


#programa02
.data
Cpf: .space 32          
Ent0: .asciiz "Informe o CPF: "  # String para solicitar entrada do CPF
Sai0: .asciiz "CPF valido."      # String para CPF válido
Sai1: .asciiz "CPF invalido."    # String para CPF inválido


.text
main:
    la $a0, Ent0         # Carrega o endereço da string de entrada em $a0
    li $v0, 4            # Carrega o código 4 (print_string) em $v0
    syscall              # Chama o sistema para imprimir a string
    
    la $a0, Cpf          # Carrega o endereço do buffer do CPF em $a0
    li $a1, 32           # Define o tamanho máximo da leitura (32 bytes)
    li $v0, 8            # Carrega o código 8 (read_string) em $v0
    syscall              # Chama o sistema para ler a string
    
    jal validacao        # Pula para a função de validação
    li $v0, 10           # Carrega o código 10 (exit) em $v0
    syscall              # Encerra o programa
    
validacao:
    li $t0, 0            # Inicializa contador com 0
    move $t1, $a0        # Move o endereço do CPF para $t1
    li $t8, 10           # Carrega constante 10 em $t8
    li $t9, 11           # Carrega constante 11 em $t9

validacao_loop:
    lb $t4, ($t1)        # Carrega um byte (caractere) do CPF em $t4

if1:
    bge $t0, 9, if2      # Se contador >= 9, vai para if2
    subi $t5, $t4, '0'   # Converte caractere ASCII para número
    sub $t6, $t8, $t0    # Calcula peso (10 - contador)
    mul $t7, $t5, $t6    # Multiplica dígito pelo peso
    add $t2, $t2, $t7    # Soma ao primeiro acumulador
    addi $t6, $t6, 1     # Incrementa peso
    mul $t7, $t5, $t6    # Multiplica dígito pelo novo peso
    add $t3, $t3, $t7    # Soma ao segundo acumulador
    j validacao_prox     # Pula para próximo caractere

if2:
    bne $t0, 9, if3                # Se contador != 9, vai para if3
    bne $t4, '-', validacao_falsa  # Se caractere != '-', CPF inválido
    j validacao_prox               # Pula para próximo caractere

if3:
    bne $t0, 10, if4     # Se contador != 10, vai para if4
    div $t2, $t9         # Divide primeiro acumulador por 11
    mfhi $t5             # Obtém resto da divisão
    if3_1:
        bge $t5, 2, if3_2    # Se resto >= 2, vai para if3_2
        li $s0, '0'          # Carrega '0' em $s0
        j if3_3              # Pula para if3_3
    if3_2:
        sub $s0, $t9, $t5    # Calcula 11 - resto
        sll $t5, $s0, 1      # Multiplica por 2
        add $t3, $t3, $t5    # Adiciona ao segundo acumulador
        addi $s0, $s0, '0'   # Converte número para ASCII
    if3_3:
        bne $s0, $t4, validacao_falsa  # Se dígito calculado != dígito lido, CPF inválido
        j validacao_prox               # Pula para próximo caractere

if4:
    bne $t0, 11, if5     # Se contador != 11, vai para if5
    div $t3, $t9         # Divide segundo acumulador por 11
    mfhi $t5             # Obtém resto da divisão
    if4_1:
        bge $t5, 2, if4_2    # Se resto >= 2, vai para if4_2
        li $s1, '0'          # Carrega '0' em $s1
        j if4_3              # Pula para if4_3
    if4_2:
        sub $s1, $t9, $t5    # Calcula 11 - resto
        addi $s1, $s1, '0'   # Converte número para ASCII
    if4_3:
        bne $s1, $t4, validacao_falsa  # Se dígito calculado != dígito lido, CPF inválido
        j validacao_prox               # Pula para próximo caractere

if5:
    bne $t4, '\n', validacao_falsa  # Se caractere != '\n', CPF inválido
    j validacao_verdadeira          # CPF válido

validacao_prox:
    addi $t0, $t0, 1          # Incrementa contador
    addi $t1, $t1, 1          # Avança para próximo caractere
    bnez $t4, validacao_loop  # Se não chegou ao fim, continua loop

validacao_falsa:
    la $a0, Sai1         # Carrega endereço da mensagem de CPF inválido
    li $v0, 4            # Carrega código para imprimir string
    syscall              # Imprime mensagem
    jr $ra               # Retorna para o chamador

validacao_verdadeira:
    la $a0, Sai0         # Carrega endereço da mensagem de CPF válido
    li $v0, 4            # Carrega código para imprimir string
    syscall              # Imprime mensagem
    jr $ra               # Retorna para o chamador