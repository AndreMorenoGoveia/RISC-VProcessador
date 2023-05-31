module MemoriaInstrucao #(parameter BITS = 32, parameter DEPTH = 2000) 
(addr, dout);


input [4:0] addr;
input clk;
output [BITS-1:0] dout;


reg [BITS-1:0] memoria [0:DEPTH-1];


assign dout = memoria[addr];

/* Instruções */
initial
begin



end



endmodule