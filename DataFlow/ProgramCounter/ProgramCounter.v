module ProgramCounter(clk, din, dout);

input clk;

input [63:0] din;
output reg [63:0] dout;

always @ (posedge clk) dout <= din;

initial dout <= 0;


endmodule