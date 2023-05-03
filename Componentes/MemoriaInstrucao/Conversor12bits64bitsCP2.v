module Conversor12bits64bitsCP2 #(parameter BITSENTRADA = 12, BITSSAIDA = 64)
(entrada, saida);

input [BITSENTRADA-1:0] entrada;
output [BITSSAIDA-1:0] saida;

assign saida = entrada[BITSENTRADA - 1] ? {~(52'b0), entrada} :
                                        {52'b0, entrada};

    
endmodule