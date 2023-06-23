# Unidade de Ponto Flutuante

## Simulação

Para simular o hardware descrito utilize os seguintes comandos:

1. iverilog FPUnit.v testbench.v -o fpunit
2. vvp fpunit

Para analizar os sinais produzidos pelo harware é possível utilizar
o Gtkwave com o seguinte comando:

* gtkwave float_wave.vcd

Para alterar as entradas do código, mude os valores dos registradores a e b para
algum ponto flutuante existente. Um site para converter decimais em binário de 32
bits é [este](https://www.h-schmidt.net/FloatConverter/IEEE754.html). Caso queira
multiplicar, deixe a flag multiplicando como 1 e 0 caso contrário. A operação roda
a partir do momento que a flag start é acionada e termina quando a unidade retorna
o valor do finish como 1.
