module UnidadePontoFlt(
    input clk,
    input [31:0] a,
    input [31:0] b,
    input start,
    input multiplicando,
    output [31:0] s,
    output wire finish
);

//Separando os sinais de entrada
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


//ULA Exponente
reg [7:0] reg_exp;
wire[7:0] resultado;
assign resultado = multiplicando ? exp_a + exp_b : exp_a - exp_b;
wire sinal_exp;
assign sinal_exp = reg_exp[7];

always @ (posedge clk) reg_exp <= resultado;


//Multiplexador fract
wire escolhe_entrada1, escolhe_entrada2;
parameter A = 1, B = 0;
assign escolhe_entrada1 = sinal_exp ? A : B;
assign escolhe_entrada2 = sinal_exp ? B : A;
wire [7:0] shift_right;
assign shift_right = multiplicando ? 0 : (sinal_exp ? ~(reg_exp) + 1 : reg_exp);

wire [23:0] entrada1, entrada2;
assign entrada1 = (escolhe_entrada1 ? fract_a : fract_b) >> shift_right;
assign entrada2 = escolhe_entrada2 ? fract_a : fract_b;

wire [27:0] saida_ula;

ULAUC ulauc(.a(entrada1), .b(entrada2), .clk(clk),
            .multiplica(multiplicando), .start(start),
            .dout(saida_ula), .finish(finish));


/* Regularização da saída */
wire c_out;
assign c_out = saida_ula[27];

wire [7:0] exp_s;
assign exp_s = (multiplicando ? reg_exp : (sinal_exp ?  exp_b : exp_a)) + c_out + 127;

wire sinal_s;
assign sinal_s = 0;

wire[22:0] fract_s;
assign fract_s = saida_ula[25:3] + (saida_ula[2] & (saida_ula[1] | saida_ula[0]));

assign s = {sinal_s, exp_s, fract_s};


endmodule