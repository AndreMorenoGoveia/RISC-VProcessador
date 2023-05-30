module DataFlow(clk, instr, soma_ou_subtrai, upcode);

parameter I = 0, J = 1, U = 2, B = 3, S = 4;
parameter nao = 0, soma = 1, subrtrai = 2;

input clk;


/* Banco Registradores */
wire [4:0] Ra, Rb, Rw;
wire WeR;
wire [63:0] dinR, douta, doutb;

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
wire [2:0] funct3;
wire [6:0] funct7;
output [6:0] upcode;
assign upcode = instr[6:0];


BancoRegistradores RF(.Ra(Ra), .Rb(Rb), .clk(clk), .We(WeR), .din(dinR),
                         .Rw(Rw), .douta(douta), .doutb(doutb));

Conversor conv(.instr(instr), .select_imm(select_imm_conv), .imm(imm_conv));

ULA ula(.dina(douta), .dinb(doutb), .imm(imm_ula), .soma_ou_subtrai(soma_ou_subtrai),
            .usa_imm(usa_imm_ula), .dout(doutULA), .flag_maior_igual_u(flag_maior_igual_u),
            .flag_igual(flag_igual), .flag_menor(flag_menor));
endmodule