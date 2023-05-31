module Memoria(clk, WeM, dinDM, doutULA, doutPC, doutIR, doutDM);
    
    input clk;
    input WeM;
    input [63:0] doutPC;
    input [63:0] dinDM;
    input [63:0] doutULA;
    output [31:0] doutIR;
    output [63:0] doutDM;

    wire [31:0] doutIM;

    /* Dados */
    MemoriaDados DM(.addr(doutULA[7:3]), .We(WeM), .din(dinDM), .clk(clk), .dout(doutDM));

    /* Instruções */
    MemoriaInstrucao IM(.addr(doutPC[6:2]), .dout(doutIM));
    RegistradorInstrucao IR(.din(doutIM), .dout(doutIR), .clk(clk));


endmodule