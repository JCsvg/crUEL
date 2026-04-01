## ENIAC (Electronic Numerical Integrator and Computer)
Primeiro computador digital eletrônico do mundo.
Enorme, 30 toneladas, área de mais de 450 m^2, mais de 18000 válvulas
5000 adições por segundo
Programação manual por meio de chaves e conexão e desconexão de cabos
Feito para o exército americano para tabelas de trajetória de armas
## Futuro dos computadores
Von Neuman (dá pra chamar de um dos pais dos computadores)
Unidade de Processamento, memória, input e output
Criou esses conceitos e o desenho do que viria a ser a arquitetura dos computadores.
# IAS
Von Neuman cria o IAS e o "Conceito de Programa Armazenado"
Um computador de 1000 palavras de 40 bits.
	Número binário
	2 instruções de 20 bits
21 Instruções
## Conjunto de registradores (armazenamento em CPU)
Registrador de buffer de memória (MBR - Memory Buffer Register)
- Contém uma palavra a ser armazenada na memória ou enviada à ES
- Pode ser usada para receber uma palavra de memória ou de uma unidade de ES

**Registrador de endereço de memória (MAR -  Memory Address Register)**
- Especifica o endereço na memória da palavra a ser escrita ou lida no MBR.

**Registrador de instrução (IR - Instruction Register)**
- contém o opcode de 8 bits da instrução que está sendo executada

**Registrador de buffer de instrução (IBR - Instruction Buffer Register)**
- Mantém temporariamente a próxima instrução a ser executada
	- ! IBR e PC fazem a mesma coisa, então porque precisa dos dois? O PC aponta para duas instruções, uma a direita e outra à esquerda. 

**Contador de programa (PC - Program computer)**
- Contém o endereço do próxima par de instruções a ser apanhado da memória


**Acumulador (AC) e quociente multiplicador (MQ - Multiplier quotient)**
- Mantém temporariamente operando de resultados de operações da ALU
- Ex. o resultado de multiplicar dois números de 40 bits é um número de 80 bits; os 40 bits mais significativos são armazenados no AC e os menos significativos no MQ.
![[Pasted image 20240717135840.png]]
## Sobre formato de memória,
Em uma palavra de número, o primeiro bit é o de sinal, os outros representam a grandeza
Em uma palavra de instrução, os primeiros 8 bits são do opcode, 12 são do endereço, 8 de outro opcode, 12 de outro endereço
!Cada instrução tem 20 bits, um endereço guarda 2 instruções
![[Pasted image 20240717140230.png]]
## Agrupamento das instruções
**Transferência de dados**
- movem dados entre memória e registradores da ALU ou entre dois registradores da ALU
![[Pasted image 20240717140645.png]]

**Desvio incondicional**
- utilizadas para facilitar operações repetitivas
![[Pasted image 20240717140710.png]]

**Desvio condicional**
- o desvio é dependente de uma condição, permitindo assim pontos de decisão
![[Pasted image 20240717140740.png]]

**Aritméticas**
- operações realizadas pela ALU
![[Pasted image 20240717141448.png]]

**Instruções de alteração de endereço**
![[Pasted image 20240717141614.png]]
## Curiosidade
!Deslocar bits
- Para a direita, divide o valor por 2
- Para a esquerda, multiplica o valor por 2
!Deslocar bits para a direita SEMPRE arredonda para baixo
## Ciclo de vida de uma instrução
![[Pasted image 20240717142207.png]]
**Busca**
- Busca da instrução
- Atualiza PC
- Decodificação
**Execução**
- Busca operandos (se necessário)
- Executa
- Armazena resultado (se necessário)
## Organização IAS
![[Pasted image 20240717142252.png]]
### Organização da memória
![[Pasted image 20240717142347.png]]
### Organização da Unidade de controle (UC)
![[Pasted image 20240717145941.png]]
**PC - Program Counter (Contador do Programa)**
- Armazena um valor que representa o endereço da memória que possui o próximo par de instruções a serem executadas
- Quando o computador é ligado, o conteúdo deste registrador é zerado para que a execução de instruções se inicie a partir do endereço zero da memória

**MAR - Memory Address Register (Registrador de Endereço da Memória)**
- Armazena um valor que representa um endereço de uma palavra da memória
- Será lido pela memória durante a operação de leitura ou escrita de dados

**IR - Instruction Register (Registrador de instrução)**
- Armazena a instrução que está sendo executada no momento
- O circuito de controle da unidade de controle lê e interpreta os bits deste registrador e envia sinais de controle para o resto do computador para coordenar a execução da instrução

**IBR - Instruction Buffer Register** 
- Armazena temporariamente uma instrução
- O IAS busca instruções da memória em pares, quando o IAS busca um par de instruções, a primeira instrução é armazenada diretamente no IR e a segunda no IBR
- Ao término da execução da primeira instrução (no IR), o computador move a segunda instrução(que está no IBR) para IR e a executa.
## Organização da ULA
![[Pasted image 20240717153041.png]]
**MBR - Memory Buffer Register (registrador temporário da memória)**
- Utilizado para armazenar temporariamente os dados que foram lidos da memória ou dados que serão escritos na memória
- Para escrever um dado na memória, o computador deve colocar o dado no registrador MBR,o endereço da palavra na qual o dado deve ser armazenado no registrador MAR e, por fim, enviar sinais de controle para a memória realizar a operação de escrita
- Os registradores MAR e MBR, juntamente com os sinais de controle enviados pela unidade de controle, formam a interface da memória com o restante do computador

**AC e MQ - Accumulator (acumulador) e Multiplier Quotient (quociente de multiplicação)**
- são registradores temporários utilizados para armazenar operandos e resultados de operações lógicas e aritméticas
- Por exemplo, a instrução que realiza a soma de dois números (ADD) soma o valor armazenado no registrador AC com um valor armazenado na memória e grava o resultado da operação no registrador AC.
## Operações na memória
### Operação de leitura na memória
Longo
1. O endereço da palavra a ser lida é escrito no registrador MAR
2. Os circuitos de controle da unidade de controle (UC) enviam um sinal de controle através de um canal de comunicação de controle à memória principal, solicitando a leitura do dado;
3. A memória principal lê o endereço do registrador MAR através do canal de comunicação de endereços e, de posse do endereço, lê o valor armazenado da palavra de memória associada a este endereço;
4. Por fim, a memória principal grava o valor lido no registrador MBR através do canal de comunicação de dados.

Simplificado
1. Endereço da palavra a ser lido é escrito no MAR
2. UC envia um sinal para a memória principal, solicitando a leitura
3. A memória principal lê o endereço vindo do MAR e lê o valor armazenado na palavra deste endereço
4. A memória principal grava o valor lido no MBR
### Operação de escrita na memória
Longo
1. O endereço da palavra que armazenara o dado é escrito no registrador MAR;
2. O dado a ser armazenado é gravado no registrador MBR;
3. Os circuitos de controle da unidade de controle (UC) enviam um sinal de controle à memória principal, solicitando a escrita do dado;
4. A memória principal lê o endereço do registrador MAR através do canal de comunicação de dados, lê o dado do registrador MBR e armazena este valor na palavra de memória associada ao endereço lido de MAR;

Simplificado
1. Endereço onde será feita a operação é escrito no MAR
2. O dado a ser armazenado é gravado no registrador MBR
3. UC envia sinal para a memória principal, solicitando escrita
4. Memória principal lê o endereço vindo do MAR, lê o dado do registrador MBR e armazena esse valor no endereço lido
## Execução de Instruções
Execução de uma instrução é realizada em dois ciclos
Ciclo de buscar -> Ciclo de execução

Ciclo de busca
- Buscar a instrução da memória (ou do IBR)
- Armazenar no IR

Ciclo de execução
- Interpretar a instrução armazenada no registrador IR
- Realizar as operações necessárias para execução da mesma

O computador fica nesse ciclo de buscar instrução, executar instrução até que se acabem as instruções e o programa se encerre
### Ciclo de busca (à esquerda)
![[Pasted image 20240720143630.png]]
1. A UC move o endereço em PC para MAR;
2. A UC envia um sinal de controle para a memória fazer uma operação de leitura;
3. A memória lê a palavra de memória e transfere o conteúdo para o registrador MBR;
4. A UC copia a segunda metade (bits 20 a 39) do registrador MBR e salva no registrador IBR. Estes bits correspondem à instrução à direita da palavra de memória.
5. A UC copia os 8 bits à esquerda do registrador MBR para o registrador IR. Estes bits correspondem ao campo de operação da instrução à esquerda da palavra de memória.
6. A UC copia os 12 bits subsequentes ao campo de operação (bits 8 a 19) e os transfere para o registrador MAR. Estes bits correspondem ao campo endereço da instrução e devem estar no registrador MAR caso a instrução precise acessar a memória durante o ciclo de execução.
7. A UC incrementa o valor no registrador PC, indicando que o próximo par de instruções a ser lido da memória deve ser lido do endereço PC + 1.
### Ciclo de busca (à direita)
1. Se a última instrução executada foi a instrução à esquerda (não houve desvio no fluxo de controle),então:
	1.  A UC copia os 8 bits à esquerda do registrador IBR para o registrador IR. Estes bits correspondem ao campo de operação da instrução armazenada em IBR.
	2. A UC copia os 12 bits subsequentes ao campo de operação (bits 8 a 19) e os transfere para o registrador MAR. Estes bits correspondem ao campo endereço da instrução e devem estar no registrador MAR caso a instrução precise acessar a memória durante o ciclo de execução.
## Ciclo de execução
1. Interpretação dos bits do campo operação da instrução (opcode) , armazenados em IR. Esta operação é também chamada de decodificação, pois a operação a ser realizada se encontra codificada, em forma de números, dentro do campo operação.
2. Após a identificação da instrução, a UC verifica se a instrução requer a busca de operandos da memória.Se a busca for necessária, então:
	1. A UC envia um sinal para a memória realizar uma operação de leitura. Note que o endereço do operando já foi transferido para o registrador MAR durante o ciclo de busca.
	2. A memória lê a palavra de memória e transfere o conteúdo para o registrador MBR;
3. Se a instrução envolve a realização de uma operação lógica ou aritmética:
	1. A UC envia sinais de controle para a unidade lógica aritmética realizar a operação associada com a Instrução. Note que neste ponto todos os operandos da operação já se encontram em registradores na unidade lógica e aritmética.
	2. A ULA realiza a operação lógica ou aritmética de acordo com os sinais enviados pela UC. Estas operações incluem transferência de dados entre registradores da ULA, soma, subtração, multiplicação,divisão e outras.
	3. A ULA grava o resultado da operação em seus registradores: AC, MQ ou MBR.
4. Se a instrução envolve a gravação do resultado na memória:
	1. A UC envia um sinal para a memória realizar uma operação de escrita. Note que o endereço do operando já foi transferido para o registrador MAR durante o ciclo de busca e o dado já foi transferido de AC para MBR no passo anterior.
	2. A memória lê o dado de MBR e o grava na palavra de memória associada ao endereço lido de MAR.
5. Se a execução da instrução implica no desvio do fluxo de controle, ou seja, se a instrução “salta” para uma outra instrução:
	1. A UC move o conteúdo do registrador MAR para PC. Note que o registrador MAR contém o valor do campo endereço da instrução sendo executada. No caso de “instruções de salto”, este campo contém o endereço da instrução para o qual o fluxo de execução deve ser desviado.
	2. Caso a execução corresponda a um salto para a instrução à esquerda da palavra de memória selecionada, dá-se início ao ciclo de busca de instrução à esquerda. Caso o salto seja para a instrução à direita, o ciclo de busca de instrução à direita com desvio de fluxo é iniciado
### Exemplo: ciclo de instrução ADD(X)
1. A UC interpreta os bits armazenados em IR (0000 0101 no caso da instrução ADD M(X)) e identifica a instrução como sendo uma soma.
2. Após a identificação da instrução , o UC sabe que a instrução requer a busca de operandos da memória.Dessa forma:
	1. A UC envia um sinal para a memória realizar uma operação de leitura. Relembrando que o endereço do operando já foi transferido para o registrador MAR durante o ciclo de busca.
	2. A memória lê a palavra de memória e transfere o conteúdo para o registrador MBR;
1. A UC sabe que a instrução ADD envolve a realização de uma operação de soma na ULA, então:
	1. A UC envia sinais para a unidade lógica e aritmética (ULA) solicitando a realização da soma dos valores armazenados em AC e MBR. Note que neste ponto todos os operandos da operação já se encontram em AC e MBR. (b) A ULA realiza a operação de soma.
	2. A ULA grava o resultado da soma no registrador AC. ULA: AC, MQ ou MBR. Note que os passos 4 (armazenamento do resultado na memória ) e 5 (desvio do fluxo de controle) não são necessários nesta instrução
# Instruções e programação do IAS
Possui 20 instruções, de 4 tipos distintos
**Transferência de dados** instruções para mover dados entre a memória e os registradores
**Salto** instruções para desviar o fluxo da execução das instruções
**Aritmética** instruções para realização de operações aritméticas
**Modificação de endereço** instruções para alterar o campo endereço de outras instruções
## Instruções
- colocar aqui tabela com todas as instruçōes e o que fazem
- colocar também os códigos em hexa
## Exemplo de programa
Código do IAS, soma dos elementos de um vetor de 20 números armazenados a partir do endereço 100
``` IAS
000 LOAD  M(OF2); STOR M(OO2,28:39)
001 ADD   M(0F1); STOR M(0F2)
002 LOAD  M(0F3); ADD  M(000)
003 STOR  M(0F3); LOAD M(0F0)
004 SUB   M(0F1); STOR M(0F0)
005 JUMP+ M(000,0:19); ...


0F0 00 00 00 00 19
0F1 00 00 00 00 01
0F2 00 00 00 01 00
0F3 00 00 00 00 00

100 00 00 00 00 00 
```

```
000 - Modifica o endereço da instrução ADD e atualiza o apontador

002 - Carrega a variável e soma com o conteúdo do vetor apontador pelo apontador

003 - Salva a soma e carrega o contador de it.

004 - Atualiza o contador de iterações

0F0 - Contador de iterações
0F1 - Constante 1
0F2 - Apontador
0F3 - Variável soma

100 - Primeiro elemento do vetor
```
## Linguagem de montagem do IAS
**Montador**
- Converte o código em linguagem de montagem para código em linguagem de máquina
- `LOAD M(0x102)` -> `01 10 2`
### Diretiva .org
A diretiva `.org` informa ao montador o endereço de memória onde o montador deve iniciar a geração do código
Exemplo de uso
``` IAS
.org 0x000
	LOAD M(0x102)
	MUL  M(0x103)
	LOAD MQ
	JUMP M(0x020,0:19)

.orf 0x020
	STOR M(0x102)
```
### Diretiva .word
A diretiva `.word` auxilia o programador a adicionar à memória
Para adicionar um dado, basta inserir a diretiva .word e um valor de 40 bits no programa
Exemplo de uso
``` IAS
.org 0x102
	.word 0x1
	.word 10

.org 0x000
	LOAD M(0x102)
	MUL  M(0x103)
	LOAD MQ
	JUMP M(0x000,0:19)
```
### Rótulos
Rótulos são anotações no código que serão convertidas em endereços pelo montador.
Um rótulo é uma palavra terminada com ":"
Pode ser utilizado para especificar um local para onde uma instrução deve saltar.
Exemplo de uso simples
``` IAS
laco:
	LOAD M(0x100)
	SUB  M(0x200)
	JUMP M(laco)
```

Podem ser utilizados em conjunto com `.word` para declarar variáveis ou constantes
Exemplo 2
``` IAS
.org 0x00
	LOAD M(var_x)
	SUB  M(const1)
	JUMP M(laco)

.org 0x100
var_x:
	.word 00 00 00 00 09
const1:
	.word 00 00 00 00 01
```

Também podem ser usadas para declarar um vetor
Exemplo 3
``` IAS
.org 0x100
base:
	.word vetor
vetor:
	.word 00 00 00 00 00
	.word 00 00 00 00 01
	.word 00 00 00 00 02
fim_vetor:
```
### Diretiva .align N
Informa ao montador para continuar a montagem a partir da próxima palavra com endereço múltiplo de N
Exemplo
``` IAS
.org 0x00
laco:
	LOAD M(var_x)
	SUB  M(var_y)
	JUMP M(laco)
.align 1
var_x: .word 0x1
var_y: .word 0x2
```

Todos os exemplos de uso dos slides usam `.align 1`, que teoricamente não faz nada.
Parece que está sendo usado (chat gpt concorda) só como separador estético entre blocos de código.
### Diretiva `.wfill`
Preenche N palavras da memória com o dado D
Exemplo
``` IAS
.org 0x000
laco:
	JUMP M(laco)
.align 1
vetor:
	.wfill 1000, 0x5
```
### Diretiva .set NOME VALOR
Utilizada nas linguagens de montagem do IAS para associar valores a nomes
(`typedef`?)
``` IAS
.set CODIGO  0x000
.set DADOS   0x100
.set TAMANHO 200

.org CODIGO
laco:
	JUMP M(laco)

.org DADOS
vetor:
	.wfill TAMANHO, 0x5
```
# Simulador
https://www.ic.unicamp.br/~edson/disciplinas/mc404/2017-2s/abef/IAS-sim/
# Exercícios propostos
1. 
Elaborar um programa, em código do IAS, que analise os valores armazenados a partir do endereço 100h (5, 2, 8, 20, 45, 61, 1, 5, 3, 12) e determine o maior valor, que deverá ser armazenado no endereço 200h e o menor valor, que deverá ser armazenado no endereço 201h.

Utilizar o simulador do IAS (link no final) para testar o testar o programa e comentar todas as linhas do código.

2. 
Elaborar um programa, em código IAS, utilizando os mesmos valores armazenados no exercício 1 que, ao final, determine o número de elementos ímpares (que deverá ser armazenado no endereço 300h) e o número de elementos pares (que deverá ser
armazenado no endereço 301h).

Utilizar o simulador do IAS (link no final) para testar o testar o programa e comentar
todas as linhas do código.

Os programas testados e com os códigos comentados (linha a linha) deverão ser enviado no formato pdf. (Exercício 1.pdf e Exercício2.pdf).

## Vetor com esses valores
~~~ IAS
100 00 000 00 101
101 00 000 00 010
102 00 000 01 000
103 00 000 10 100
104 00 001 01 101
105 00 001 11 101
106 00 000 00 001
107 00 000 00 101
108 00 000 00 011
109 00 000 01 100
~~~

.set VETOR 100
.set CONT  203
.set UM    204
.set MAIOR 200
.set MENOR 201

.org VETOR
.word 5
.word 2
.word 8
.word 20
.word 45
.word 61
.word 1
.word 5 
.word 3 
.word 12

.org CONT
.word 9

.org UM
.word 1

.org 0x000


STOR M(CONT)
loop:
    se for maior poe em 200
    se for menor poe em 201
    SUB M(UM)
    JUMP+ M(loop)