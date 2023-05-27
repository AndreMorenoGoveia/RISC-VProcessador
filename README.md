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

 ### Program Counter
    Registrador que armazena o endereço da instrução do próximo ciclo de clock   

### ULAPC
    Define a quantidade de instruções a serem avançadas.

## Testbench
No testbench são testadas as operações de load e store assim como o funcionamento da alteração do
conteúdo dos registradores e da memória para qualquer outro comando.

Para testar o funcionamento do hardware pode-se utilizar o Icarus Verilog, digitando os seguintes comandos no terminal:
1. iverilog -o reg Registrador.v MemoryData.v BancoRegistradores.v testbench.v
2. vvp reg

Para uma visão mais detalhada do funcionamento com a wave, após simular o hardware digite no terminal:

3. gtkwave reg.vcd
