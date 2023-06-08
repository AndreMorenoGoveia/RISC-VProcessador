module fd 
    #(  // Tamanho em bits dos barramentos
        parameter i_addr_bits = 6,
        parameter d_addr_bits = 6
    )(
        input  clk, rst_n,                   // clock borda subida, reset assíncrono ativo baixo
        output [6:0] opcode,                    
        input  d_mem_we, rf_we,              // Habilita escrita na memória de dados e no banco de registradores
        input  [3:0] alu_cmd,                // ver abaixo
        output [3:0] alu_flags,
        input  alu_src,                      // 0: rf, 1: imm
               pc_src,                       // 0: +4, 1: +imm
               rf_src,                       // 0: alu, 1:d_mem
        output [i_addr_bits-1:0] i_mem_addr,
        input  [31:0]            i_mem_data,
        output [d_addr_bits-1:0] d_mem_addr,
        inout  [63:0]            d_mem_data

    );
    // AluCmd     AluFlags
    // 0000: R    0: zero
    // 0001: I    1: MSB 
    // 0010: S    2: overflow
    // 0011: SB
    // 0100: U
    // 0101: UJ  

parameter R = 4'b0000, I = 4'b0001, S = 4'b0010, SB = 4'b0011, U = 4'b0100, UJ = 4'b0101;
parameter zero = 0, MSB = 1, overflow = 2, n_usado_ainda = 3;  




/* Banco Registradores */
wire [4:0] Ra, Rb, Rw;
wire [63:0] dinR, douta, doutb;
/* Mux da entrada do banco de registradores */
assign dinR = rf_src ? d_mem_data : dout_ULA;

/* Conversor */
wire [63:0] imm_conv;

/* ULA */
wire [63:0] imm_ula;
wire [63:0] dout_ULA;
wire usa_imm_ula;
wire flag_maior_igual_u, flag_menor, flag_igual;

/* instrucoes */


wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
assign rd = i_mem_data[11:7];
assign rs1 = i_mem_data[19:15];
assign rs2 = i_mem_data[24:20];


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
            .flag_igual(alu_flags[0]), .flag_menor(flag_menor));

ProgramCounter pc(.clk(atualiza_pc), .din(doutULAPC), .dout(doutPC));
ULAPC ulapc(.din(doutPC), .imm(imm_pc), .soma_imm(soma_imm_PC), .dout(doutULAPC));

RegistradorIntrucao IR()

endmodule