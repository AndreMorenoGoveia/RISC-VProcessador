module MemoriaDados 
#(
    parameter BITS = 64,
    parameter DEPTH = 32,
    parameter d_addr_bits = 6
    ) 
(addr, We, din, clk, dout);

input [d_addr_bits-4:0] addr;
input We;
input clk;
input [BITS-1:0] din;


output [BITS-1:0] dout;

reg [BITS-1:0] memoria [0:DEPTH-1];

assign dout = memoria[addr];


/* Posições iniciais */
initial
begin

    memoria[0] = 51;
    memoria[1] = 94;
    memoria[2] = 18;
    memoria[3] = -47000;

end


always @(posedge clk)
    begin
        if(We)
            begin
                memoria[addr] = din;
            end
    end

endmodule