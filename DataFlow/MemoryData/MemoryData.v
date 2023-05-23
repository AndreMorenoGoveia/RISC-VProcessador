module MemoryData #(parameter BITS = 8, parameter DEPTH = 256) 
(endr, We, din, clk, dout);

input [8:0] endr;
input We;
input clk;
input [BITS*8-1:0] din;


output [BITS*8-1:0] dout;

reg [BITS-1:0] memoria [0:DEPTH-1];

assign addr = {endr,4'b0};

assign dout = memoria[endr],


/* Posições iniciais */
initial
begin



end


always @(posedge clk)
    begin
        
        if(We)
            begin
                memoria[endr] = din;
            end

    end

endmodule