## Classes de aplicações de computadores e suas características
**Computador desktop**
- Projetado para uso por uma única pessoa
- Normalmente inclui monitor gráfico, teclado e  mouse.

**Servidor**
- Usado para executar grandes programas para múltiplos usuários (quase sempre de maneira simultânea)
-  Acessado apenas por meio de uma rede (normalmente)

**Supercomputador**
- Desempenho e custo mais altos
- Configurados como servidores
- Normalmente custam de dezenas a centenas de milhares de dólares.

**Computador embutido**
- Computador dentro de outro dispositivo
- Usado par executar uma aplicação predeterminada ou um conjunto de softwares
## A era pós PC
**PMDs (Personal Mobile Devices)**
- Pequenos dispositivos sem fio para conexão com a Internet
- Utilizam baterias para gerar energia
- Software é instalado baixando aplicativos
- Smartphones, tablets...

**Computação em nuvem**  
- Grande conjunto de servidores que prestam serviço através da Internet. 
- Alguns provedores fornecem um número dinâmico variante de servidores como um serviço.

**Software as a Service (SaaS)** 
-  Software e dados como um serviço pela Internet
	- Através de um programa magro, como um navegador, que roda em dispositivos clientes locais em vez de um código binário que precisa ser instalado e executado localmente 
- Alguns exemplos são a busca na Web e as redes sociais.

**Internet of Things (IOT)/Computadores embarcados** 
- Uso da computação embarcada 
- Ênfase é o custo
## Oito grandes ideias sobre arquitetura de computadores
### 1. Projete pensando na lei de Moore
- Lei de Moore: os recursos do circuito integrado dobram a cada 18/24 meses.(Gordon Moore – 1965 – um dos fundadores da Intel)
- Os arquitetos de computador precisam antecipar onde estará a tecnologia quando o projeto terminar, e não quando ele começar.
![[Pasted image 20240717103411.png]]
### 2. Use a abstração para simplificar o projeto
Uma técnica de produtividade importante para o hardware e o e o software é usar abstrações para representar o projeto em diferentes níveis de representação; os detalhes de nível mais baixo serão ocultados, para oferecer um modelo mais simples nos níveis mais altos.
![[Pasted image 20240717103501.png]]
### 3. Torne o caso comum veloz
Tornar o caso comum veloz costuma melhorar mais o desempenho do que otimizar o caso raro. O caso comum é mais simples do que o caso raro e, portanto, geralmente é mais fácil de melhorar.
![[Pasted image 20240717103624.png]]
### 4. Desempenho pelo paralelismo
Desde o nascimento da computação, os arquitetos de computador têm oferecido projetos que ganham mais desempenho realizando operações em paralelo.
![[Pasted image 20240717103719.png]]
### 5. Desempenho pelo pipelining
Pipelining: padrão de paralelismo em particular, prevalecente na arquitetura de computador. 
![[Pasted image 20240717103812.png]]

### 6. Desempenho pela predição
Em alguns casos, na média, pode ser mais rápido prever e começar a trabalhar do que esperar até saber ao certo, supondo que o mecanismo para recuperar de um erro de previsão não seja tão dispendioso e sua predição seja relativamente precisa. 
![[Pasted image 20240717103940.png]]
### 7. Hierarquia de memórias
A velocidade da memória modela o desempenho, a capacidade limita o tamanho dos problemas que podem ser resolvidos e o custo, hoje, geralmente, e o maior custo do computador. Hierarquia de memória: a memória mais rápida, menor e mais cara por bit no topo da hierarquia e amais lenta, maior de menor custo por bit, na base.
![[Pasted image 20240717104103.png]]
### 8. Estabilidade pela redundância
Os computadores não precisam apenas serem rápidos; eles precisam ser, também, estáveis. Sistemas estáveis incluem componentes redundantes, que podem assumir o controle quanto uma falha ocorre e ajudar a detectá-la. 
![[Pasted image 20240717104219.png]]
## Conceitos por trás do programa
**Software de sistemas**
- Fornece serviços normalmente úteis
- Sistemas operacionais, compiladores, carregadores e montadores

**Sistema operacional**
- Programa de supervisão que gerencia os recursos de um computador

**Compilador**
- Traduz as instruções de linguagem de alto nível para instruções de linguagem assembly.

**Números binários**: 0 (off) ou 1 (on)

**Dígito binário**: Também chamado bit. Um dos dois números na base 2 (0 ou 1). Componente básico da informação

**Instrução**: comando que o hardware do computador entende e obedece

**Montador (assembler)**: programa que traduz uma versão simbólica de instruções para a versão binária

**Linguagem assembly**: representação simbólica das instruções de máquina.

**Linguagem de máquina**: uma representação binária das instruções de máquina.
![[Pasted image 20240717110354.png]]

**Dispositivo de entrada**
- Mecanismo por meio do qual o computador é alimentado com informações
- Teclado e mouse.

**Dispositivo de saída** 
- Mecanismo que transmite o resultado de uma computação para o usuário ou para outro computador
- Monitor, alto-falantes

## E/S - Monitor Gráfico
**Monitor de cristal líquido**
- Tecnologia de vídeo 
- Usa uma fina camada de polímeros líquidos que podem ser usados para transmitir ou bloquear a luz conforme uma corrente seja aplicada ou não. 

**Monitor de matriz ativa**
Monitor de cristal líquido usando um transistor para controlar a transmissão da luz em cada pixel individual

**Pixel**
- Menor elemento individual da imagem
- Uma tela é composta de centenas de milhares a milhões de pixels, organizados em uma matriz.

**Touchscreen**
- Telas sensíveis ao toque
- (substituição do mouse e do teclado em dispositivos móveis inteligentes – Ex. smartphones e tablets)
## Abrindo o gabinete
**Circuito integrado - chip**
- Dispositivo que combina de dezenas a milhões de transistores

**CPU - Unidade Central de Processamento - (processador)**
- A parte ativa do computador, que contém o caminho de dados, e o controle
- Soma, testa números e sinaliza aos dispositivos de E/S para que sejam ativados etc

**Caminho de dados**
- Componente do processador que realiza operações aritméticas. 

**Controle**
- Componente do processador que comanda o caminho de dados, a memória e os dispositivos de E/S de acordo com as instruções do programa.
### Parte relacionada à hierarquia de memória
**Memória**
- Área de armazenamento temporária
- Programas são mantidos quanto estão sendo executados
- Contém os dados necessários para os programas em execução.

**Dynamic Random Access Memory (DRAM)**
- Memória construída como um circuito integrado para fornecer acesso aleatório a qualquer local.

**Memória cache**
- Memória pequena e rápida 
- Age como um buffer para uma memória maior e mais lenta.

**Static Random Access Memory (SRAM)**
- Memória montada como um circuito integrado
- Mais rápida e menos densa que a DRAM.
### Parte relacionada à abstração
**Arquitetura do conjunto de instruções**
- Interface abstrata entre o hardware e o software de nível mais baixo de uma máquina
- Abrange todas as informações necessárias para escrever um programa em linguagem de máquina (instruções, registradores, acesso à memória, E/S, etc.)

**Interface binária de aplicação (ABI)**
- Parte voltada ao usuário do conjunto de instruções
- Interfaces do sistema operacional usadas pelos programadores das aplicações
- Define um padrão para a portabilidade binária entre computadores

**Implementação**: Hardware que obedece à abstração de uma arquitetura

**Abstração em perspectiva**
- Tanto o hardware quanto o software consistem em camadas hierárquicas usando abstração, com cada camada inferior ocultando detalhes do nível acima
- A arquitetura do conjunto de instruções é uma interface-chave entre os níveis de abstração (interface entre o hardware e o software de baixo nível)
- Permite que muitas implementações com custo e desempenho variáveis executem um software idêntico.
## Um lugar seguro para os dados (tipos de memória)
**Memória volátil**
- Armazenamento
- Conserva os dados apenas enquanto estiver recebendo energia
- Ex. DRAM

**Memória não volátil**
- Forma de memória que conserva os dados mesmo na ausência de energia
- É usada para armazenar programas entre execuções
- Um disco de DVD é não volátil.

**Memória principal (memória primária)**
- Usada para armazenar os programas enquanto estão sendo executados

**Memória secundária**
- Não volátil
- Usada para armazenar programas e dados entre execuções
- Consiste em memória flash nos PMDs e discos magnéticos nos servidores (normalmente)

**Disco magnético**
- Memória secundária não volátil
- Composta por discos giratórios cobertos com um material de gravação magnético
- Dispositivos mecânicos rotativos
- Tempos de acesso são cerca de 5 a 20 milissegundos.

**Memória flash**
- Semicondutora não volátil
- Mais barata e mais lenta que a DRAM
- Mais cara por bit e mais rápida que os discos magnéticos
- Os tempos de acesso são cerca de 5 a 50 microssegundos.
### Disco magnético
• Substrato de disco coberto com material magnetizável (óxido de ferro)
• Substrato era de alumínio, foi substituído por vidro
	maior uniformidade da superfície do filme magnético
	aumenta a confiabilidade
	redução nos defeitos gerais da superfície 
	erros reduzidos de leitura/gravação
	melhor rigidez (para reduzir a dinâmica do disco
	maior resistência a choques e danos
• Gravação e leitura por bobina condutora, chamada cabeça
• Pode ser única cabeça de leitura/gravação ou separadas
• Durante leitura/gravação, cabeça fica parada, placas gira
• Gravação:
	• Corrente pela bobina produz campo magnético
	• Pulsos enviados à cabeça
	• Padrão magnético gravado na superfície abaixo dela (corrente positiva e
	negativa)
• Leitura (tradicional): - disquetes e discos rígidos mais antigos
	• Campo magnético movendo-se em relação à bobina produz corrente
	• Bobina é a mesma para leitura e gravação
• Leitura (contemporânea):
	• Cabeça de leitura separada e próxima da cabeça de gravação
	• Sensor magnetorresistivo (MR) parcialmente blindado
	• Resistência elétrica depende da direção do campo magnético
	• Operação em alta frequência.
		• Densidade de armazenamento e velocidade mais altas