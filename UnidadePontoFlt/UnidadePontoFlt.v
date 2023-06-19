module UnidadePontoFlt(
    input clk,
    input [31:0] a,
    input [31:0] b,
    output [31:0] s
);

//Separando os sinais de entrada
wire sinal_a, sinal_b;
assign sinal_a = a[31],
       sinal_b = b[31];

wire [7:0] exp_a, exp_b;
assign exp_a = a[30:23],
       exp_b = b[30:23];

wire [22:0] fract_a, fract_b;
assign fract_a = a[22:0],
       fract_b = b[22:0];


//ULA Exponente
reg [7:0] reg_exp;
wire[7:0] resultado;
wire somando;
assign resultado = somando ? exp_a + exp_b : exp_a - exp_b;

always @ (posedge clk) reg_exp <= resultado;


//Multiplexador fract
wire escolhe_entrada1, escolhe_entrada2;
wire [7:0] shift_right;

wire [22:0] entrada1, entrada2;
assign entrada1 = (escolhe_entrada1 ? fract_a : fract_b) << shift_right;
assign entrada2 = escolhe_entrada2 ? fract_a : fract_b;






endmodule