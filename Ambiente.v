`timescale 1ns/100ps
module Ambiente;

reg clk, reset;

always #500 clk = ~clk;

initial 
begin
    $dumpfile("riscv.vcd");
    $dumpvars(0, testbench);
    reset <= 0;
    clk <= 0;
    $display("Hello World");
    #1000000
    $finish;

    
end

/* Entradas Processador */
wire [31:0] instr;
wire [63:0] doutDM;

/* Entradas Memoria */
wire WeDM;
wire [63:0] dinDM;
wire [63:0] doutULA;
wire [63:0] doutPC;
wire atualiza_pc;



polirv riscv(.clk(clk), .reset(reset), .instr(instr), .doutPC(doutPC), .WeDM(WeDM),
                .doutULA(doutULA), .dinDM(dinDM), .doutDM(doutDM), .atualiza_pc(atualiza_pc));

Memoria mem(.clk(clk), .WeDM(WeDM), .dinDM(dinDM), .doutULA(doutULA), .doutPC(doutPC),
            .doutIR(instr), .doutDM(doutDM), .atualiza_pc(atualiza_pc));

endmodule
