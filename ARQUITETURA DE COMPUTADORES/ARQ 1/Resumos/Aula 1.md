# Arquitetura x Organização de computador
Arquitetura são as partes visíveis do sistema, que tem um impacto direto na lógica de execução de um programa
Fazem parte: conjunto de instruções, número de bits usados para representação de dados, mecanismos de entrada/saída e técnicas de endereçamento

Organização são as partes "invisíveis" do sistema, hardware, que não tem impacto direto na lógica de execução de um programa
Fazem parte: Sinais de controle, interfaces, tecnologia de memória
(sinais de controle: leitura/escrita, endereço, seleção de dispositivos)
(interfaces: barramento, portas de entrada)
(tecnologia de memória no sentido de RAM, HD, SSD, cache etc.)


Uma família de computadores, como por exemplo Intel x86 ou IBM System/370, compartilham a mesma arquitetura básica
Isso gera compatibilidade de código (com gerações anteriores)
Enquanto a organização é diferente entre diferentes versões
# Estrutura x Função
Estrutura é o modo como os componentes se relacionam
Função é a operação individual de cada componente como parte da estrutura

Na disciplina será utilizada a abordagem *top down*, começando com os componentes principais do computador
# Função
Em termos gerais, há somente quatro funções básicas:
1. Processamento de dados
2. Armazenamento de dados
3. Movimentação de dados
4. Controle

Processamento de dados:
- Dados podem ter uma grande variedade de formas
- Grande exigência de processamento
- Há poucos métodos fundamentais ou tipos de processamento de dados
Armazenamento de dados:
- Existem pelo menos uma função de armazenamento de dados de curto prazo e uma de longo prazo
- Arquivos de dados são armazenados no computador para recuperação e atualização
Movimentação de dados:
- Um computador consiste de dispositivos que servem como fonte ou destino de dados
- Quando dados são entregues ou recebidos de um dispositivo E/S este é chamado de **periférico**
- Quando dados são movimentados por longas distâncias o processo é conhecido como **comunicação de dados**
Controle:
- A unidade de controle de um computador gerencia recursos e orquestra o desempenho de suas partes na resposta às instruções
# Estrutura
Estrutura interna de um computador de processador único tradicional, hierarquicamente:
1. Unidade Central de Processamento (CPU)
2. Memória principal
3. E/S
4. Sistema de interconexão

Unidade Central de Processamento (CPU):
- Controla a operação de um computador
- Realiza funções e processamento de dados
- Referida simplesmente como **processador**
Memória principal:
- Armazena dados
Entrada/Saída:
- mode dados entro o computador e o seu ambiente externo
Sistema de interconexão:
- Mecanismos que proporcionam a comunicação entre CPU, memória principal e E/S
- Ex. **barramento do sistema** (fios condutores aos quais todos os outros componentes se conectam)
![[Estrutura_Computador_Alto-Nivel.png]]
## A CPU
Composta por:
- Unidade de Controle (UC): controla a operação da CPU
- Unidade arimética e lógica (ALU): realiza as funções de processamento de dados do computador
- Registradores: armazenamento interno à CPU
- Interconexão da CPU: mecanismo que oferece comunicação interna entre as partes da CPU
![[Estrutura_Interna_CPU.png]]
### Unidade de controle
Ainda dentro da CPU, a Unidade de Controle é composta por
- Lógica de sequenciação
- Registradores e decodificadores da UC
- Memória de controle
# Placa-mãe, processadores e core
- Quando os processadores todos residem em um único chip, o termo **computador multicore** é usado
- Cada UC é chamada de core
- Uso de múltiplas camadas de memória, entre elas a **memória cache**, entre o processador e a memória principal
Visão simplificada dos componentes principais de um computador multicore típico:
![[Computador_Multicore.png]]

Placa de circuito impresso (PCB - Printed Circuit Board):
- Placa rígida que mantém e interconecta chips e outros componentes eletrônicos
- A PCB principal de um computador é chamada **placa-mãe**
Chip:
- Pedaço único de material semicondutor
- Geralmente de silício
- Onde estão circuitos eletrônicos e portas lógicas de fábrica
PCB + Chip = circuito integrado
# Core
Em linhas gerais, os elementos funcionais de um core são:

Lógica de instrução
- Busca instruções
- Codifica cada instrução para determinar a operação es locais de memória
ALU
- Executa a operação especificada por uma instrução
Lógica de load/store
- Gerencia transferência de dados para e de uma memória principal através da cache
## Subáreas de um Core
Layout de um core do zEnterprise EC12
![[Layout_Core.png]]

**ISU (unidade de sequência de instrução)**
- Determina a sequência na qual as instruções serão executadas (arquitetura superescalar)
**IFU (unidade de busca de instrução)**
- lógica para buscar instruções
**IDU (unidade de decodificação de instrução)**
- Alimentada por buffers IFU
- Responsável por analisar e decodificar os opcodes da z/Arquitetura
**LSU (unidade de load/store)**
- Contém um cache de dados de 96kB L1
- Gerencia o tráfego de dados entra a cache de dados L2 e as unidades de execução funcionais
- Lida com todos os tipos de acessos de operandos de todas as extensões, modos e formatos, como definido na z/Arquitetura
**XU (unidade de tradução)**
- Traduz os endereços lógicos a partir de instruções de endereços físicos na memória principal
- Contém o TLB (Translation Lookaside Buffer) usada para incrementar o acesso da memória
**FXU (unidade de ponto fixo)**
- Executa as operações aritméticas de ponto fixo
**BFU (unidade de ponto flutuante binário)**
- Executa as operações de ponto flutuante binário e hexadecimal
- Executa também as operações de multiplicação de ponto fixo
**DFU (unidade de ponto flutuante decimal)**
- Executa as operações de ponto fixo e flutuante sobre os números que são armazenados com dígitos decimais
**RU (unidade de recuperação)**
- Mantém a cópia do estado completo do sistema (incluindo registradores)
- Coleta sinais de falha de hardware e gerencia as ações de recuperação de hardware
**COP (coprocessador dedicado)**
- Responsável pela compressão de dados e funções de criptografia para cada core
**l-cache**
- cache de instrução de 64 KB L1 que permite que a IFU pré-busque instruções antes que sejam necessárias
**Controle L2**
- Gerencia tráfego através de duas caches L2
**Dados-L2**
- Cache de dados 1 MB L2 para todo o tráfego de memória diferente das instruções
**Instr-L2**
- Cache de instrução 1 MB L2