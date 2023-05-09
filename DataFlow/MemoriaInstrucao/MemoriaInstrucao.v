module MemoriaInstrucao #(parameter BITS = 8, parameter DEPTH = 128) 
(endr, clk, dout);


input [6:0] endr;
input clk;
output [BITS*4-1:0] dout;


reg [BITS-1:0] memoria [0:DEPTH-1];


assign dout[7:0] = memoria[endr],
       dout[15:8] = memoria[endr+1],
       dout[23:16] = memoria[endr+2],
       dout[31:24] = memoria[endr+3];

/* Instruções */
initial
begin

    memoria[3:0] = {12'd219, 20'd0};
    memoria[7:4] = {12'd1002, 20'd0};

end



endmodule