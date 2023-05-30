module Conversor(instr, select_imm ,imm);

    input [31:0] instr;
    input [2:0] select_imm;
    output [63:0] imm;

    wire [63:0] imediato_I, imediato_J, imediato_U, imediato_B, imediato_S;

    parameter I = 0, J = 1, U = 2, B = 3, S = 4;

    assign imm = select_imm == I ? imediato_I :
                 select_imm == J ? imediato_J :
                 select_imm == U ? imediato_U :
                 select_imm == B ? imediato_B :
                 imediato_S;

    ImediatoI convI(.instr(instr), .saida(imediato_I));

    ImediatoJ convJ(.instr(instr), .saida(imediato_J));

    ImediatoU convU(.instr(instr), .saida(imediato_U));

    ImediatoB convB(.instr(instr), .saida(imediato_B));

    ImediatoS convS(.instr(instr), .saida(imediato_S));


endmodule