# Processador Risc-V
Processador multiciclo


## Fluxo de Dados

### Registrador

    Os registradores utilizados recebem e retiram seus dados assíncronamente. Para alterar seu
    conteúdo, seu load deve estar ativado.

### BancoRegistradores

    Um banco de 32 registradores de 64 bits. As entradas Ra e Rb recebem um endereço no banco
    (5 bits) e nas saídas douta e doutb estará o conteúdo das respectivas memórias Ra e Rb. Na
    entrada Rw é colocado o endereço de memória a ter seu conteúdo alterado, na entrada din é
    colocado o novo conteúdo e a entrada We permite que o conteúdo seja alterado.

### Memória Instrução

    Memória com um valor de espaço fixo que armazena os comandos de instruções a serem realizadas nos endereços de memória.

### Registrador Instrução

    Registrador que armazena a instrução a ser executada no mesmo ciclo de clock.

### Conversores

    Transformam o dado da instrução binária em dados a serem utilizados.

### MemoryData

    Um banco de memória de 32 posições de 64 bits. A entrada endr diz qual o endereço atual cujo
    conteúdo sairá por dout. Caso We esteja ativado, o conteúdo do endereço atual será alterado
    para o conteúdo de din.

### SomadorSubtrator

    Um somador preparado para números binários em complemento de 2 onde quando a entrada subtraindo
    for ativada, será trocado o sinal do B de acordo com as regras do complemento de 2 e esse número
    será adicionado ao A, gerando C como saída. Tudo é feito em tempo constante.

### Flags

    Definimos as flags "maior unsigned", "menor" e "igual". A partir destas, podemos fazer qualquer comparação entre as entradas A e B. Nota-se que não foram utilizadas as flags "Not Equal", "Menor unsigned" e "Maior", visto que o nosso grupo teve como objetivo simplificar a ULA.

### UC

    A UC foi construída a partir de uma maquina de estados possuindo apenas 4 estados, Fetch, Decode, Execute e Write Back. Para cada estado, as execuções são realizadas no segundo always (sensível ao reset e ao estado).
    Para o estado Fetch, atualiza_pc recebe o valor de 1 para indicar que o valor do Program Counter deve ser atualizado para a próxima instrução, após a instrução atual ter sido salva no IR.
    Em relação ao estado Decode, atualiza_pc é mudado para 0, pois o único estado em que o valor do Program Counter deve ser atualizado é no estado Fetch.
    Já para o estado Execute (ex),
    Por fim, para o estado Write Back, a váriavel WeR receberá  valor de 1 apenas quando é indicada a escrita na memória. Tal ocasião ocorre quando a variável soma_ou_subtrai estiver em 1 ou quando a variável load receber 1 também. 

### Program Counter

    Registrador que armazena o endereço da instrução do próximo ciclo de clock   

### ULAPC

    Define a quantidade de instruções a serem avançadas.

## Simulação

    Para simular o funcionamento do hardware é possível utilizar o comando make que gerará toda a saída
    do testbench caso seu computador tenha o make instalado. Caso contrário utilize os seguintes comandos
    nesta ordem:
    1. iverilog -o riscv.out Ambiente.v Processador/DataFlow/BancoRegistradores/Registrador.v Processador/DataFlow/BancoRegistradores/RegistradorZero.v Processador/DataFlow/BancoRegistradores/Codificador.v Processador/DataFlow/BancoRegistradores/Mux32x64bits.v Processador/DataFlow/BancoRegistradores/BancoRegistradores.v Processador/DataFlow/Conversores/ImediatoB.v Processador/DataFlow/Conversores/ImediatoI.v Processador/DataFlow/Conversores/ImediatoJ.v Processador/DataFlow/Conversores/ImediatoS.v Processador/DataFlow/Conversores/ImediatoU.v Processador/DataFlow/Conversores/Conversor.v Processador/DataFlow/ULA/Flags.v Processador/DataFlow/ULA/SomadorSubtrator.v Processador/DataFlow/ULA/ULA.v Processador/DataFlow/ProgramCounter/ProgramCounter.v Processador/DataFlow/ProgramCounter/ULAPC.v Processador/DataFlow/RegistradorInstrucao.v Processador/DataFlow/fd.v Processador/UC/uc.v Processador/polirv.v Memoria/MemoriaInstrucao.v Memoria/MemoriaDados.v  Memoria/Memoria.v
    2. vvp riscv.out

    Para analizar em formato de ondas o funcionamento, após dar make ou utilizar os comandos acima, digite no terminal:
    * gtkwave riscv.vcd


    Na simulação atual o processador realiza as opreações lw, sw, add, sub, addi, beq, jal com um adendo no jal onde não é guardado o valor anterior ao pulo em um registrador. A ordem e a maneira como essas operações foram realizadas está no arquivo MemoriaInstrucao.v nos comentários na frente de cada instrução armazenada.
    Para verificar o funcionamento, recomendo analisar o dado armazenado nos registradores encontrados na pasta do banco de registradores e a doutPC para ver onde é jogado o Program Counter de acordo com as instruções.
    Vale ressaltar que no Data Memory os endereços avançam de 8 em 8, no Instruction Memory de 4 em 4 e que as
    instruções mudam a cada 4 ciclos de clock.
  
