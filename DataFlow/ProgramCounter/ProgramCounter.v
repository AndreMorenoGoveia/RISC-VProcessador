module ProgramCounter(clk, din, dout);

input clk;

input [63:0] din;
reg [63:0] PC;
output [63:0] dout;

always @ (posedge clk) PC <= din;


endmodule