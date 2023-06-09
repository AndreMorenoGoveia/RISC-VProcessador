module Conversor(instr, select_imm ,imm);

    input [31:0] instr;
    input [3:0] select_imm;
    output [63:0] imm;

    wire [63:0] imediato_I, imediato_J, imediato_U, imediato_B, imediato_S;

    parameter R = 4'b0000, I = 4'b0001, S = 4'b0010, SB = 4'b0011, U = 4'b0100, UJ = 4'b0101;

    /* mux para escolher a saída */
    assign imm = select_imm === I ? imediato_I :
                 select_imm === UJ ? imediato_J :
                 select_imm === U ? imediato_U :
                 select_imm === SB ? imediato_B :
                 imediato_S;

    ImediatoI convI(.instr(instr), .saida(imediato_I));

    ImediatoJ convJ(.instr(instr), .saida(imediato_J));

    ImediatoU convU(.instr(instr), .saida(imediato_U));

    ImediatoB convB(.instr(instr), .saida(imediato_B));

    ImediatoS convS(.instr(instr), .saida(imediato_S));


endmodule