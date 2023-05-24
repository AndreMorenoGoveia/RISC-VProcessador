module MemoryData #(parameter BITS = 64, parameter DEPTH = 32) 
(endr, We, din, clk, dout);

input [4:0] endr;
input We;
input clk;
input [BITS-1:0] din;


output [BITS-1:0] dout;

reg [BITS-1:0] memoria [0:DEPTH-1];

assign addr = {endr,2'b0};

assign dout = memoria[endr];


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