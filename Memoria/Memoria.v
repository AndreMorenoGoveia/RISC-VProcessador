module Memoria(clk, WeDM, dinDM, doutULA, doutPC, doutIR, doutDM, atualiza_pc);
    
    input clk;
    input WeDM;
    input atualiza_pc;
    input [63:0] doutPC;
    input [63:0] dinDM;
    input [63:0] doutULA;
    output [31:0] doutIR;
    output [63:0] doutDM;

    wire [31:0] doutIM;

    /* Dados */
    MemoriaDados DM(.addr(doutULA[7:3]), .We(WeDM), .din(dinDM), .clk(clk), .dout(doutDM));

    /* Instruções */
    MemoriaInstrucao IM(.addr(doutPC[6:2]), .dout(doutIM));
    RegistradorInstrucao IR(.din(doutIM), .dout(doutIR), .clk(atualiza_pc));


endmodule