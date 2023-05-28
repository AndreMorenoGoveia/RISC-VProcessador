module ImediatoS #(parameter BITSENTRADA = 32, BITSIMM = 12, BITSSAIDA = 64)
(instr, saida);

input [BITSENTRADA-1:0] instr;
wire [BITSIMM-1:0] imm;
output [BITSSAIDA-1:0] saida;

assign imm = {instr[31:25], instr[11:7]};
assign saida = imm[BITSIMM - 1] ? {~(52'b0), imm} :
                                        {52'b0, imm};


endmodule