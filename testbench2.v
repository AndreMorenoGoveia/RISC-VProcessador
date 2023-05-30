module testbench;

reg clk, reset;

always #500 clk = ~clk;

initial 
begin
    reset <= 0;
    clk <= 0;
end




Processador riscv(.clk(clk), .reset(reset));

endmodule
