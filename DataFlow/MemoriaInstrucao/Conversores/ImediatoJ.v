module ImediatoJ #(parameter BITSENTRADA = 32, BITSIMM = 19, BITSSAIDA = 64)
(instr, saida);

input [BITSENTRADA-1:0] instr;
wire [BITSIMM-1:0] imm;
output [BITSSAIDA-1:0] saida;

assign imm = {instr[31], instr[19:12], instr[20], instr[30:25], instr[24:22]};
assign saida = imm[BITSIMM - 1] ? {~(43'b0), imm, 2'b0} : 
                                  {43'b0, imm, 2'b0};

    
endmodule