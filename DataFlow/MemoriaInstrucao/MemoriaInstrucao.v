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

    memoria[0] <= 32'b00000001000000000010000100000011;//ld
    memoria[1] <= 32'b00000000000000010010010000100011;//sw
    memoria[2] <= 32'b00000000000000010000000010110011;//add
    memoria[3] <= 32'b01000000001000000000000110110011;//sub
    memoria[4] <= 32'b11111110101000011000001000010011;//addi

end



endmodule