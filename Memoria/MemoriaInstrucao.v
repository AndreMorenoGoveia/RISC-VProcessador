module MemoriaInstrucao 
#(
    parameter BITS = 32,
    parameter DEPTH = 2000,
    parameter i_addr_bits = 6
) 
(addr, dout);


input [i_addr_bits-3:0] addr;
input clk;
output [BITS-1:0] dout;


reg [BITS-1:0] memoria [0:DEPTH-1];


assign dout = memoria[addr];

/* Instruções */
initial
begin

    memoria[0] <= 32'b00000000000000000010000010000011; //lw x1, #0(x0)
    memoria[1] <= 32'b00000000100000000010000100000011; //lw x2, #8(x0)
    memoria[2] <= 32'b00000001000000000010000110000011; //lw x3, #16(x0)
    memoria[3] <= 32'b00000001100000000010001000000011; //lw x4, #24(x0)
    memoria[4] <= 32'b00000000010000010000001010110011; //add x5, x2, x4
    memoria[5] <= 32'b01000000000100011000001100110011; //sub x6, x3, x1
    memoria[6] <= 32'b00000010011000000010000000100011; //sw x6, #32(x0)
    memoria[7] <= 32'b00000010000000000010001110000011; //lw x7, #32(x0)
    memoria[8] <= 32'b00110001010100111000010000010011; //addi x8, x7, #789
    memoria[9] <= 32'b01111100100000111000000101100011; //beq x7, x8, #1987
    memoria[10] <= 32'b00000000011100110000010001100011; //beq x6, x7, #16
    memoria[12] <= 32'b00011101000000000001000111101111; //jal x3, #4561

end



endmodule