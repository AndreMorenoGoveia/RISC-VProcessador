module fd #(parameter i_addr_bits = 6, 
              parameter d_addr_bits = 6)
              (clk, rst_n instr, opcode, rf_we, d_mem_we 
              alu_flags, alu_cmd, alu_src, pc_src, rf_src, 
              i_mem_data, i_mem_addr, d_mem_addr, d_mem_data);

parameter I = 0, J = 1, U = 2, B = 3, S = 4;
parameter R = 4'b0000, I = 4'b0001, S = 4'b0010, SB = 4'b0011, U = 4'b0100, UJ = 4'b0101;
parameter zero = 0, MSB = 1, overflow = 2, n_usado_ainda = 3;  


input rst_n;
input clk;
input alu_src, pc_src, rf_src; 
input [31:0] i_mem_data;
output [i_addr_bits - 1: 0] i_mem_addr;
output [d_addr_bits - 1: 0] d_mem_addr;
inout [63: 0] d_mem_data;

input [3:0] alu_cmd;
output [3:0] alu_flags;
input d_mem_we;
/* Banco Registradores */
wire [4:0] Ra, Rb, Rw;
input rf_we;
wire [63:0] dinR, douta, doutb;
assign dinR = doutULA;

/* Conversor */
wire [2:0] select_imm_conv;
wire [63:0] imm_conv;

/* ULA */
wire [63:0] imm_ula;
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