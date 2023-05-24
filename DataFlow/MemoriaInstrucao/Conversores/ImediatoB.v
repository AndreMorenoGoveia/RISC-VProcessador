module ImediatoB #(parameter BITSENTRADA = 32, BITSIMM = 11, BITSSAIDA = 64)
(instr, saida);

input [BITSENTRADA-1:0] instr;
wire [BITSIMM-1:0] imm;
output [BITSSAIDA-1:0] saida;

assign imm = {instr[31], instr[7], instr[30:25], instr[11:9]};
assign saida = imm[BITSIMM - 1] ? {~(51'b0), imm, 2'b0} :
                                        {51'b0, imm, 2'b0};


endmodule