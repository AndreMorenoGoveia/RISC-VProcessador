module Processador(clk, reset, instr);

    input clk, reset;
    input [31:0] instr;

    UC uc(.clk(clk), .reset(reset));
    

endmodule