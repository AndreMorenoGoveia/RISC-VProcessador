module DataFlow(clk, instr, soma_ou_subtrai, imm, opcode, funct7, funct3, WeR);

parameter I = 0, J = 1, U = 2, B = 3, S = 4;
parameter nao = 0, soma = 1, subrtrai = 2;

input clk;


/* Banco Registradores */
wire [4:0] Ra, Rb, Rw;
input WeR;
wire [63:0] dinR, douta, doutb;
assign dinR = doutULA;

/* Conversor */
wire [2:0] select_imm_conv;
wire [63:0] imm_conv;


/* ULA */
wire [63:0] imm_ula;
input [1:0] soma_ou_subtrai;
wire [63:0] doutULA;
wire usa_imm_ula;
wire flag_maior_igual_u, flag_menor, flag_igual;

/* instrucoes */
input [31:0] instr;
output [2:0] funct3;
output [6:0] funct7;
output [6:0] opcode;
assign opcode = instr[6:0];
assign funct7 = instr[31:25];
assign funct3 = instr[14:12];
output [63:0] imm;

wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
assign rd = instr[11:7];
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];


/* soma/sub */
assign Rw = soma_ou_subtrai !== nao ? rd :
       0;
assign Ra = soma_ou_subtrai !== nao ? rs1 :
       0;
assign Rb = soma_ou_subtrai !== nao ? rs2 :
       0;
assign usa_imm_ula = soma_ou_subtrai === nao;



BancoRegistradores RF(.Ra(Ra), .Rb(Rb), .clk(clk), .We(WeR), .din(dinR),
                         .Rw(Rw), .douta(douta), .doutb(doutb));

Conversor conv(.instr(instr), .select_imm(select_imm_conv), .imm(imm_conv));

ULA ula(.dina(douta), .dinb(doutb), .imm(imm_ula), .soma_ou_subtrai(soma_ou_subtrai),
            .usa_imm(usa_imm_ula), .dout(doutULA), .flag_maior_igual_u(flag_maior_igual_u),
            .flag_igual(flag_igual), .flag_menor(flag_menor));
endmodule