module fpu (clk, rst, A, B, R, op, start, done);
    input  clk, rst;   // reset assíncrono
    input  [31:0] A,B; // Entradas
    output [31:0] R;   // Saída
    input  [1:0] op;   // 00:soma, 01:subtração, 10:multiplicação, 11:divisão
    input  start;      // 1: começa o cálculo, done vai pra zero
    output done;       // 1: cálculo terminado, fica em 1 até start ir de zero para um

wire multiplicando;
assign multiplicando = op[1];

/* Separando os sinais de entrada */
wire sinal_a, sinal_b;
assign sinal_a = A[31],
       sinal_b = B[31];

wire [7:0] exp_a, exp_b;
assign exp_a = A[30:23] - 127,
       exp_b = B[30:23] - 127;

wire [23:0] fract_a, fract_b;
assign fract_a[23] = 1, fract_b[23] = 1,
       fract_a[22:0] = A[22:0],
       fract_b[22:0] = B[22:0];

/* UC */
wire subtraindo;
wire escolhe_entrada_shift, escolhe_entrada_b;
wire escolhe_maior_exp;
wire subtraindo_ULA_exp;
wire opera;
UC uc(
    .clk(clk),
    .rst(rst),
    .start(start),
    .finish(done),
    .multiplicando(multiplicando),

    .sinal_exp(sinal_exp),
    .subtraindo_ULA_exp(subtraindo_ULA_exp),
    
    
    .escolhe_entrada_shift(escolhe_entrada_shift),
    .escolhe_entrada_b(escolhe_entrada_b),
    .bits_mult(bits_mult_reg),
    .load_bits_mult(load_bits_mult),
    .load_mult(load_mult),
    
    .c_out(c_out),
    .c_out_arr(c_out_arr),
    .retorna_arr(retorna_arr),
    .escolhe_maior_exp(escolhe_maior_exp),
    .usa_arredonda(usa_arredonda),
    .opera(opera),
    
    .float_s(float_s),
    .s(R)
);

/* ULA Exponente */
wire [7:0] exp_r;
ULA_exp ulaexp(
    .exp_a(exp_a),
    .exp_b(exp_b),
    .subtraindo(subtraindo_ULA_exp),
    .exp_r(exp_r)
);



/* Registrador do expoente */
Registrador #(8) r_exp(.din(exp_r), .clk(clk), .load(1'b1), .dout(reg_exp));
wire [7:0] reg_exp;
wire sinal_exp;
assign sinal_exp = reg_exp[7];


/* muxes entrada ULA_Seq */
wire [23:0] entrada_shift_ULA, entrada_ULA_b;
mux_ab #(24) entrada_a_ULA_Seq(
    .a(fract_a),
    .b(fract_b),
    .escolhe_a(escolhe_entrada_shift),
    .s(entrada_shift_ULA)
);

mux_ab #(24) entrada_b_ULA_Seq(
    .a(fract_a),
    .b(fract_b),
    .escolhe_a(escolhe_entrada_b),
    .s(entrada_ULA_b)
);


/* Shift para ULA_Seq */
wire [7:0] shift_ULA_Seq;
assign shift_ULA_Seq = 
       multiplicando ? 0 :
       (sinal_exp ? ~(reg_exp) + 1 : reg_exp);//Módulo do expoente

wire [23:0] entrada_ULA_a;


Shift #(24) Shift_ULA_Seq(
    .a(entrada_shift_ULA),
    .shift(shift_ULA_Seq),
    .s(entrada_ULA_a)
);


/* ULA_Seq */
wire load_mult;
wire load_bits_mult;
wire c_out_ula;
wire [4:0] bits_mult_reg;
wire [27:0] saida_ULA_Seq;
ULA_Seq ula_seq(
    .a(entrada_ULA_a),
    .b(entrada_ULA_b),
    .clk(clk),
    .multiplicando(multiplicando),
    .load_mult(load_mult),
    .load_bits_mult(load_bits_mult),
    .subtraindo(sinal_op),
    .bits_mult_reg(bits_mult_reg),
    .c_out(c_out_ula),
    .dout(saida_ULA_Seq)
);



/* Sinal da operação */
wire sinal_op;
assign sinal_op = sinal_a ^ sinal_b;

/* Mux expoentes (Escolhe o maior expoente) */
wire [7:0] maior_exp;
mux_ab #(8) mux_exp(
    .a(exp_a),
    .b(exp_b),
    .escolhe_a(escolhe_maior_exp),
    .s(maior_exp)
);

/* Mux expoente (ecolhe entre o expoente do
                 arredonda e o da ULA) */
wire [7:0] exp_atual;
wire [7:0] exp_arr;
mux_ab #(8) mux_exp_arr(
    .a(exp_arredonda),
    .b(maior_exp),
    .escolhe_a(usa_arredonda),
    .s(exp_atual)
);


/* Subtrator de expoente */
wire [7:0] exp_sub;
wire retorna_arr;
assign exp_sub = retorna_arr ? exp_atual + opera : exp_atual - opera;

/* Mux fract (ecolhe entre o fract do
                 arredonda e o da ULA) */
wire [27:0] fract_atual;
wire [27:0] fract_arredonda;
mux_ab #(28) mux_fract_arr(
    .a(fract_arredonda),
    .b(saida_ULA_Seq),
    .escolhe_a(usa_arredonda),
    .s(fract_atual)
);

/* Shiftador de fract */
wire [27:0] fract_shift;
assign fract_shift = retorna_arr ? fract_atual >> opera : fract_atual << opera;


/* Arredondador */
wire [7:0] exp_arredonda;
wire c_out, c_out_arr;
wire [31:0] float_s;

Arrendonda arr(
    .clk(clk),

    .fract_in(fract_shift),
    .exp_in(exp_sub),

    .multiplicando(multiplicando),
    .reg_exp(reg_exp),

    .fract_a(fract_a),
    .fract_b(fract_b),
    .sinal_a(sinal_a),
    .sinal_b(sinal_b),

    .c_out_ula(c_out_ula),
    .c_out(c_out),
    .c_out_arr(c_out_arr),

    .fract_atual(fract_arredonda),
    .exp_s(exp_arredonda),

    .s(float_s)
);


wire sinal_s;
wire [7:0] exp_s;
wire[22:0] fract_s;


endmodule


module UC(
    input clk,
    input rst,
    input start,
    output reg finish,
    input multiplicando, //Entradas operação

    input sinal_exp, //ULA COMB
    output subtraindo_ULA_exp,

    output escolhe_entrada_shift, //ULA SEQ
    output escolhe_entrada_b, 
    input [4:0] bits_mult,
    output reg load_bits_mult,
    output reg load_mult,
    
    input c_out, //Arredonda
    input c_out_arr,
    output reg retorna_arr,    
    output escolhe_maior_exp,
    output reg usa_arredonda,
    output reg opera,

    input [31:0] float_s,
    output reg [31:0] s//Saída
);

/** Decisores combinatórios **/
/* Controle ULA_exp */
assign subtraindo_ULA_exp = ~multiplicando;

/* Controle muxes da ULA_Seq */
assign escolhe_entrada_shift =  sinal_exp,
       escolhe_entrada_b     = ~sinal_exp;


/* Controle mux expoente */
assign escolhe_maior_exp = ~sinal_exp;


/** Decisores sequenciais **/

/* Estados */
/* Estados */
reg [3:0] estado_atual;
reg [3:0] prox_estado;
parameter inicio = 0,  multiplica1 = 1, multiplica2 = 2, inicio_arredonda1 = 3,
 inicio_arredonda2 = 4, arredonda1 = 5, arredonda2 = 6, fim1 = 7, fim2 = 8;


/* Alternador de estado */
always @ (posedge clk, rst)
    begin
        if(rst)
        begin
            estado_atual <= inicio;
            prox_estado <= inicio;
            s <= 0;
        end
            
        else
            estado_atual <= prox_estado;
    end

/* Processo de início da operação */
always @ (posedge start)
    begin
        prox_estado <= inicio;
        finish <= 0;
        s <= 0;
    end

/* Máquina de estado */
always @ (estado_atual)
    begin
        case (estado_atual)

            inicio:
                begin
                    if(start & (~rst))
                        begin
                            finish <= 0;
                            if(multiplicando)
                                begin
                                    /* Iniciando os parâmetros da multiplicação */
                                    load_mult <= 0;
                                    load_bits_mult <= 0;
                                    prox_estado <= multiplica1;

                                end
                            else
                                prox_estado <= inicio_arredonda1;


                        end
                end
            
            multiplica1:
                begin
                    /* Testando para obter a operação atual
                       da multiplicação */
                    if(bits_mult > 23)
                        begin
                            load_mult <= 0;
                            load_bits_mult <= 0;
                            prox_estado <= inicio_arredonda1;
                        end
                        
                    else
                        begin
                            load_mult <= 1;
                            load_bits_mult <= 1;
                            prox_estado <= multiplica2;
                        end
                end
            multiplica2:
                begin
                    /* Testando para obter a operação atual
                       da multiplicação */
                    if(bits_mult > 23)
                        begin
                            load_mult <= 0;
                            load_bits_mult <= 0;
                            prox_estado <= inicio_arredonda1;
                        end
                        
                    else
                        begin
                            load_mult <= 1;
                            load_bits_mult <= 1;
                            prox_estado <= multiplica1;
                        end
                    
                end

            inicio_arredonda1:
                begin
                    retorna_arr <= 0;
                    usa_arredonda <= 0;
                    opera <= 0;
                    prox_estado <= inicio_arredonda2;
                end

            inicio_arredonda2:
                begin
                    usa_arredonda <= 1;
                    prox_estado <= arredonda1;
                end

            arredonda1:
                begin
                    usa_arredonda <= 1;
                    if(c_out_arr)
                        begin
                            retorna_arr <= 1;
                            prox_estado <= fim1;
                        end
                    else if(c_out)
                        begin
                            opera <= 0;
                            prox_estado <= fim1;
                        end
                    else
                        begin
                            opera <= 1;
                            prox_estado <= arredonda2;
                        end
                    
                end
            
            arredonda2:
                begin
                    if(c_out_arr)
                        begin
                            retorna_arr <= 1;
                            prox_estado <= arredonda1;
                        end
                    else if(c_out)
                        begin
                            opera <= 0;
                            prox_estado <= fim1;
                        end
                    else
                        begin
                            opera <= 1;
                            prox_estado <= arredonda1;
                        end
                    
                end

            fim1:
                begin
                    s <= float_s;
                    prox_estado <= fim2;
                end
            fim2:
                begin
                     /* Enviando a flag de finalizado */
                    finish <= 1;
                end

        endcase

    end

endmodule


module Registrador #(parameter BITS = 23) 
(
    input [BITS-1:0] din,
    input clk,
    input load,
    output [BITS-1:0] dout
);

reg [BITS-1:0] dado;
assign dout = dado;
initial dado <= 0;

always @ (posedge clk)
    begin
        if(load)
            dado <= din;
    end

endmodule


module ULA_exp(
    input [7:0] exp_a,
    input [7:0] exp_b,
    input subtraindo,
    output [7:0] exp_r
);

    assign exp_r = subtraindo ? exp_a - exp_b : exp_a + exp_b;

endmodule


module mux_ab #(parameter BITS = 24) (
    input [BITS-1:0] a,
    input [BITS-1:0] b,
    input escolhe_a,
    output [BITS-1:0] s
);

assign s = escolhe_a ? a : b;

endmodule


module Shift #(parameter BITS = 24) (
    input [BITS-1:0] a,
    input [7:0] shift,
    output [BITS-1:0] s
);

assign s = a >> shift;

endmodule


module ULA_Seq(
    input [23:0]  a,
    input [23:0]  b,
    input clk,
    input multiplicando,
    input load_mult,
    input load_bits_mult,
    input subtraindo,
    output [4:0] bits_mult_reg,
    output c_out,
    output [27:0] dout
);




/* Parâmetros da multiplicação */

wire [27:0] parcela_shift;
assign parcela_shift = {1'b0, b,3'b0} >> (23 - bits_mult_reg);

wire [27:0] parcela_mult;
assign parcela_mult = a[bits_mult_reg] ? parcela_shift : 0;
wire [27:0] mult_reg;
wire [27:0] mult_atual;
assign mult_atual = mult_reg + parcela_mult; 

wire [4:0] bits_atual;
assign bits_atual = bits_mult_reg + 1;


Registrador #(28) mult (.din(mult_atual), .clk(clk), .load(load_mult), .dout(mult_reg));
Registrador #(5) bits_mult (.din(bits_atual), .clk(clk), .load(load_bits_mult), .dout(bits_mult_reg));


/* Saída */
assign dout = multiplicando ? mult_reg :
              subtraindo ? a > b ?
              {{1'b0,a} - {1'b0,b}, 3'b0} :
              {{1'b0,b} - {1'b0,a}, 3'b0} :
              {{1'b0,a} + {1'b0,b}, 3'b0};


/* Carry out */
assign c_out = dout[27];


endmodule


module Arrendonda(
    input clk,

    input [27:0] fract_in,
    input [7:0] exp_in,

    input multiplicando,
    input [7:0] reg_exp,

    input [23:0] fract_a,
    input [23:0] fract_b,
    input sinal_a,
    input sinal_b,
    
    input c_out_ula,
    output c_out,
    output c_out_arr,

    output [27:0] fract_atual,
    output [7:0] exp_s,

    output [31:0] s
);

wire [22:0] fract_s;
wire sinal_s;

wire [25:0] fract_arredondado;

/* Arredondamento Round-to-Even */
assign fract_arredondado = fract_atual[27:3] + fract_atual[2];

assign c_out = fract_in[27];
assign c_out_arr = fract_arredondado[25];

assign sinal_s = multiplicando ? (sinal_a ^ sinal_b) : 
       reg_exp[7] ? sinal_b : 
       reg_exp === 0 ? (fract_a > fract_b ? sinal_a : sinal_b) :
       sinal_a;



Registrador #(28) fract_arr(.din(fract_in), .clk(clk), .load(1'b1), .dout(fract_atual));
Registrador #(8) exp_arr(.din(exp_in), .clk(clk), .load(1'b1), .dout(exp_s));


assign fract_s = fract_arredondado[23:1];
wire [7:0] exp_real;
assign exp_real = multiplicando ? (reg_exp + c_out_ula + c_out_arr + 127) : (exp_s + 128);
assign s = {sinal_s, exp_real, fract_s};

endmodule