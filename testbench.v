`timescale 1ns/100ps
module testbench;

reg clk, reset;

always #500 clk = ~clk;

initial 
begin
    reset <= 0;
    clk <= 0;
    $display("Hello World");
    #1000000
    $finish;

    
end




Processador riscv(.clk(clk), .reset(reset));

endmodule
