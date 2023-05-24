module MemoriaInstrucao #(parameter BITS = 32, parameter DEPTH = 32) 
(endr, clk, dout);


input [4:0] endr;
input clk;
output [BITS-1:0] dout;


reg [BITS-1:0] memoria [0:DEPTH-1];


assign dout = memoria[endr];

/* Instruções */
initial
begin

    memoria[0] = 32'b00000000000000000001001000010111; // auipc #1 = 4096
    memoria[1] = 32'b00000100000001100000001001100111; // jalr 
    
end



endmodule