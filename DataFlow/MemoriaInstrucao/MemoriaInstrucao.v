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

    memoria[1] <= 32'b00000001000000000010000100000011;//ld
    memoria[2] <= 32'b00000000000000010010010000100011;//sw
    memoria[3] <= 32'b00000000000000010000000010110011;//add
    memoria[4] <= 32'b01000000001000000000000110110011;//sub
    memoria[5] <= 32'b11111110101000011000001000010011;//addi
    memoria[6] <= 32'b00000000000100010000010001100011;//beq
    memoria[8] <= 32'b00000100001000100001000001100011;//bne

end



endmodule