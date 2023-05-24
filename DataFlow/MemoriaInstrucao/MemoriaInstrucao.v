module MemoriaInstrucao #(parameter BITS = 32, parameter DEPTH = 32) 
(endr, clk, dout);


input [6:0] endr;
input clk;
output [BITS-1:0] dout;


reg [BITS-1:0] memoria [0:DEPTH-1];


assign dout = memoria[endr];

/* Instruções */
initial
begin

    
end



endmodule