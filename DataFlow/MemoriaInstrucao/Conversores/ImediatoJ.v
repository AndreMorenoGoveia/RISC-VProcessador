module ImediatoJ #(parameter BITSENTRADA = 32, BITSIMM = 12, BITSSAIDA = 64)
(instr, saida);

input [BITSENTRADA-1:0] instr;
wire [BITSIMM-1:0] imm;
output [BITSSAIDA-1:0] saida;

assign imm = instr[31:20];
assign saida = imm[BITSIMM - 1] ? {~(32'b0), imm, 20'b0} :
                                        {32'b0, imm, 20'b0};

    
endmodule