module Processador(clk, reset, instr, doutPC, WeM);

    input clk, reset;
    input [31:0] instr;
    output [63:0] doutPC;
    output WeM;

    wire [63:0] imm_pc;
    wire [6:0] opcode;
    wire [6:0] funct7;
    wire [2:0] funct3;
    wire [1:0] soma_ou_subtrai;



    UC uc(.clk(clk), .reset(reset), .imm_pc(imm_pc), .opcode(opcode),
          .funct7(funct7), .funct3(funct3), .soma_ou_subtrai(soma_ou_subtrai),
          .doutPC(doutPC));
    
    DataFlow df(.clk(clk), .instr(instr), .soma_ou_subtrai(soma_ou_subtrai),
                .imm(imm_pc), .opcode(opcode), .funct7(funct7), .funct3(funct3));


endmodule