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

/* flags da ULA */
assign alu_flags[zero] = dout_ULA === 0;
assign alu_flags[MSB] = dout_ULA[63];
assign alu_flags[overflow] = 0;
assign alu_flags[n_usado_ainda] = 0;


/* Banco Registradores */
wire [63:0] dinR, douta, doutb;
/* Mux da entrada do banco de registradores */
assign dinR = rf_src ? d_mem_data : dout_ULA;

/* Conversor */
wire [63:0] imm_conv;

/* ULA */
wire [63:0] dout_ULA;
wire subtraindo;
wire usa_imm_ula;
wire flag_maior_igual_u, flag_menor, flag_igual;

/* instrucoes */
wire [31:0] instr;
wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
wire [2:0] funct3;
wire [6:0] funct7;
assign rd = instr[11:7];
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign opcode = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];

/* program counter */
wire [63:0] dout_PC;
wire [63:0] dout_ULAPC;
assign atualiza_pc = d_mem_we | rf_we;


/* Decidindo se subtrai */
assign subtraindo = ((alu_cmd === R) & (funct7 === 7'b0100000) & (funct3 === 3'b000)) |
                    (alu_cmd === SB);


/* Endereços de memória */
assign i_mem_addr = dout_PC[i_addr_bits-1:0];
assign d_mem_addr = dout_ULA[d_addr_bits-1:0];




BancoRegistradores RF(.Ra(rs1), .Rb(rs2), .clk(clk), .We(rf_we), .din(dinR),
                         .Rw(rd), .douta(douta), .doutb(doutb));

Conversor conv(.instr(instr), .select_imm(alu_cmd), .imm(imm_conv));

ULA ula(.dina(douta), .dinb(doutb), .imm(imm_conv), .subtraindo(subtraindo),
        .alu_src(alu_src), .dout(dout_ULA), .flag_maior_igual_u(flag_maior_igual_u),
        .flag_igual(flag_igual), .flag_menor(flag_menor));

ProgramCounter pc(.clk(atualiza_pc), .din(dout_ULAPC), .dout(dout_PC));

ULAPC ulapc(.din(dout_PC), .imm(imm_conv), .soma_imm(pc_src), .dout(dout_ULAPC));

RegistradorInstrucao IR(.din(i_mem_data), .dout(instr), .clk(clk));

endmodule