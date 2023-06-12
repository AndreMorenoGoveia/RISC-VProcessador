`timescale 1ns/100ps
module Ambiente
#(
    parameter i_addr_bits = 6,
    parameter d_addr_bits = 6
);

reg clk, rst_n;

always #500 clk = ~clk;

initial 
begin
    $dumpfile("riscv.vcd");
    $dumpvars(0, Ambiente);
    rst_n <= 0;
    clk <= 0;
    $display("Hello World");
    #10000000
    $finish;

    
end

/* Conexões */
wire [i_addr_bits-1:0] i_mem_addr;
wire [31:0]            i_mem_data;
wire                   d_mem_we;
wire [d_addr_bits-1:0] d_mem_addr;
wire [63:0]            d_mem_data;




polirv riscv(.clk(clk), .rst_n(rst_n),
             .i_mem_addr(i_mem_addr),
             .i_mem_data(i_mem_data),
             .d_mem_we(d_mem_we),
             .d_mem_addr(d_mem_addr),
             .d_mem_data(d_mem_data));

Memoria mem(.clk(clk),
            .i_mem_addr(i_mem_addr),
            .i_mem_data(i_mem_data),
            .d_mem_we(d_mem_we),
            .d_mem_addr(d_mem_addr),
            .d_mem_data(d_mem_data));

endmodule
