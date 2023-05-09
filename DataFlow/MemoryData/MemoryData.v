module MemoryData #(parameter BITS = 8, parameter DEPTH = 256) 
(endr, We, din, clk, dout);

input [8:0] endr;
input We;
input clk;
input [BITS*8-1:0] din;


output [BITS*8-1:0] dout;

reg [BITS-1:0] memoria [0:DEPTH-1];

assign addr = {endr,4'b0};

assign dout[7:0] = memoria[endr],
       dout[15:8] = memoria[endr+1],
       dout[23:16] = memoria[endr+2],
       dout[31:24] = memoria[endr+3],
       dout[39:32] = memoria[endr+4],
       dout[47:40] = memoria[endr+5],
       dout[55:48] = memoria[endr+6],
       dout[63:56] = memoria[endr+7];


/* Posições iniciais */
initial
begin

memoria[0] <= 64'd0;
memoria[15:8] <= {64'd149};
memoria[23:16] <= 64'd295;
memoria[31:24] <= 64'd2978;
memoria[39:32] <= 64'd19;

end


always @(posedge clk)
    begin
        
        if(We)
            begin
                memoria[endr] = din[7:0];
                memoria[endr+1] = din[15:8];
                memoria[endr+2] = din[23:16];
                memoria[endr+3] = din[31:24]; 
                memoria[endr+4] = din[39:32];
                memoria[endr+5] = din[47:40];
                memoria[endr+6] = din[55:48];
                memoria[endr+7] = din[63:56]; 
            end

    end

endmodule