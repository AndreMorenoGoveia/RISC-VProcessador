module MemoriaInstrucao #(parameter BITS = 32, parameter DEPTH = 2000) 
(endr, dout);


input [4:0] endr;
input clk;
output [BITS-1:0] dout;


reg [BITS-1:0] memoria [0:DEPTH-1];


assign dout = memoria[endr];

/* Instruções */
initial
begin

    memoria[0] = 32'b11111011110100000010000100000011;
    
end



endmodule