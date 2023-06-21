module FPUnit(
    input clk,
    input [31:0] a,
    input [31:0] b,
    input start,
    input multiplicando,
    output [31:0] s,
    output wire finish
);

/* Separando os sinais de entrada */
wire sinal_a, sinal_b;
assign sinal_a = a[31],
       sinal_b = b[31];

wire [7:0] exp_a, exp_b;
assign exp_a = a[30:23] - 127,
       exp_b = b[30:23] - 127;

wire [23:0] fract_a, fract_b;
assign fract_a[23] = 1, fract_b[23] = 1,
       fract_a[22:0] = a[22:0],
       fract_b[22:0] = b[22:0];

/* UC */
wire subtraindo;
wire escolhe_entrada_shift, escolhe_entrada_b;
wire escolhe_maior_exp;
UC uc(
    .multiplicando(multiplicando),
    .sinal_exp(sinal_exp),
    .finish_ula(finish_ula),
    .clk(clk),
    .subtraindo(subtraindo),
    .escolhe_entrada_shift(escolhe_entrada_shift),
    .escolhe_entrada_b(escolhe_entrada_b),
    .escolhe_maior_exp(escolhe_maior_exp),
    .usa_arr(usa_arr)
);

/* ULA Exponente */
wire [7:0] exp_r;
ULA_exp ulaexp(
    .exp_a(exp_a),
    .exp_b(exp_b),
    .subtraindo(subtraindo),
    .exp_r(exp_r)
);



/* Registrador do expoente */
reg [7:0] reg_exp;
always @ (posedge clk) reg_exp <= exp_r;
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
wire finish_ula;
wire [27:0] saida_ULA_Seq;
ULA_Seq ula_seq(
    .a(entrada_ULA_a),
    .b(entrada_ULA_b),
    .clk(clk),
    .multiplica(multiplicando),
    .subtraindo(1'b0),
    .start(start),
    .dout(saida_ULA_Seq),
    .finish(finish_ula)
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

/* Mux expoente atual */
wire [7:0] exp_atual;
mux_ab #(8) mux_exp_atual(
    .a(maior_exp),
    .b(exp_s),
    .escolhe_a(usa_arr),
    .s(exp_atual)
);

/* Carry out */
wire c_out;
wire c_out_ula;
assign c_out = fract_shift[27],
       c_out_ula = saida_ULA_Seq[27];

/* Subtraindo 1 da saída do mux */
wire [7:0] exp_sub;
wire sub_habilitada;
assign exp_sub = exp_atual - ((~c_out) & (~c_out_ula));


/* mux fract atual */
wire [27:0] fract_shift;
mux_ab #(28) mux_fract_atual(
    .a(fract_in),
    .b(saida_ULA_Seq),
    .escolhe_a(usa_arr),
    .s(fract_shift)
);

/* Shift */
wire [27:0] fract_in;
assign fract_in = fract_shift >> (~c_out);

/* Regularizador da saída */
Arrendonda arr(
    .fract_in(fract_in),
    .reg_exp(reg_exp),
    .exp_sub(maior_exp),
    .multiplicando(multiplicando),
    .sinal_op(sinal_op),
    .sinal_s(sinal_s),
    .exp_arr(exp_arr),
    .fract_s(fract_s)
);


wire sinal_s;
wire [7:0] exp_s, exp_arr;
assign exp_s = exp_arr + 127;
wire[22:0] fract_s;
assign s = {sinal_s, exp_s, fract_s};


endmodule


module UC(
    input multiplicando,
    input sinal_exp,
    input finish_ula,
    input clk,
    output subtraindo,
    output escolhe_entrada_shift,
    output escolhe_entrada_b,
    output escolhe_maior_exp,
    output usa_arr,
    output reg finish
);

/* Controle ULA_exp */
assign subtraindo = ~multiplicando;

/* Controle muxes da ULA_Seq */
assign escolhe_entrada_shift =  sinal_exp,
       escolhe_entrada_b     = ~sinal_exp;

/* Controle mux expoente */
assign escolhe_maior_exp = ~sinal_exp;

/* Controle mux expoente atual/sub */
assign usa_arr = finish_ula;




/* Operação finalizada */
always @ (posedge clk)
    begin
        if(finish_ula)
            finish <= 1;
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
    input multiplica,
    input subtraindo,
    input start,
    output reg [27:0] dout,
    output reg finish
);

/* Estados */
reg [2:0] estado_atual;
reg [2:0] prox_estado;
parameter inicio = 0, somando = 1, teste_mult = 2, multiplicando = 3, fim = 4;


/* Parâmetros da multiplicação */
reg [4:0] bits_mult;
reg [26:0] parcela_mult;

wire [26:0] parcela_shift;
assign parcela_shift = {b,3'b0} >> (23 - bits_mult);


/* Alternador de estado */
always @ (posedge clk)
    begin
        estado_atual <= prox_estado;
    end

/* Processo de início da operação */
always @ (posedge start)
    begin
        prox_estado <= inicio;
        finish <= 0;
    end

/* Máquina de estado */
always @ (estado_atual)
    begin

        case (estado_atual)

            inicio:
                begin
                    if(start)
                        begin
                            finish <= 0;
                            if(multiplica)
                                begin
                                    /* Iniciando os parâmetros da multiplicação */
                                    prox_estado <= teste_mult;
                                    bits_mult <= 0;
                                    parcela_mult <= 0;
                                    dout <= 0;

                                end
                            else
                                prox_estado <= somando;


                        end
                end

            somando:
                begin
                    /* Somando/subtraindo */
                    if(subtraindo)
                        dout <= {{1'b0,a} - {1'b0,b}, 3'b0};
                    else
                        dout <= {{1'b0,a} + {1'b0,b}, 3'b0};
                    prox_estado <= fim;

                end
            
            teste_mult:
                begin
                    /* Testando para obter a operação atual
                       da multiplicação */
                    if(bits_mult > 23)
                        prox_estado <= fim;
                    else
                        begin
                            if(a[bits_mult] == 0)
                                parcela_mult <= 0;
                            else
                                begin
                                    parcela_mult <= parcela_shift; 
                                end
                            prox_estado <= multiplicando;
                        end
                    
                end
            
            multiplicando:
                begin
                    /* Adicionando as parcelas da multiplicação */
                    dout <= dout + {1'b0,parcela_mult};
                    bits_mult <= bits_mult + 1;
                    prox_estado <= teste_mult;

                end

            fim:
                begin
                    /* Enviando a flag de finalizado */
                    finish <= 1;
                end

        endcase

    end

endmodule


module Arrendonda(
    input [27:0] fract_in,
    input [7:0] reg_exp,
    input [7:0] exp_sub,
    input multiplicando,
    input sinal_op,
    output        sinal_s,
    output [7:0]  exp_arr,
    output [22:0] fract_s
);

wire c_out;
assign c_out = fract_in[27];

assign sinal_s = multiplicando ? sinal_op : 0;

assign exp_arr = (multiplicando ? reg_exp : (exp_sub + 2));


/* Arredondando a saída */
assign fract_s = fract_in[26:4] + fract_in[3];

endmodule