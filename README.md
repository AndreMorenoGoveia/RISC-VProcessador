## Fluxo de Dados Load-Store

### Registrador
    Os registradores utilizados recebem e retiram seus dados assíncronamente. Para alterar seu
    conteúdo, seu load deve estar ativado.

### BancoRegistradores
    Um banco de 32 registradores de 64 bits. As entradas Ra e Rb recebem um endereço no banco
    (5 bits) e nas saídas douta e doutb estará o conteúdo das respectivas memórias Ra e Rb. Na
    entrada Rw é colocado o endereço de memória a ter seu conteúdo alterado, na entrada din é
    colocado o novo conteúdo a entrada We permite que o conteúdo seja alterado.

### MemoryData
    Um banco de memória de 32 posições de 64 bits. A entrada endr diz qual o endereço atual cujo
    conteúdo sairá por dout. Caso We esteja ativado, o conteúdo do endereço atual será alterado
    para o conteúdo de din.

### SomadorSubtrator
    Um somador preparado para números binários em complemento de 2 onde quando a entrada subtraindo
    for ativada, será trocado o sinal do B de acordo com as regras do complemento de 2 e esse número
    será adicionado ao A, gerando C como saída. Tudo é feito em tempo constante.

## Testbench
No testbench são testadas as operações de load e store assim como o funcionamento da alteração do
conteúdo dos registradores e da memória para qualquer outro comando.

Para testar o funcionamento do hardware pode-se utilizar o Icarus Verilog, digitando os seguintes comandos no terminal:
1. iverilog -o reg Registrador.v MemoryData.v BancoRegistradores.v testbench.v
2. vvp reg

Para uma visão mais detalhada do funcionamento com a wave, após simular o hardware digite no terminal:

3. gtkwave reg.vcd
