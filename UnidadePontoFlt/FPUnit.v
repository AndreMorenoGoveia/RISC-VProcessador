module FPUnit(
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


//Sinal
wire sinal_op;
assign sinal_op = sinal_a ^ sinal_b;


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
            .multiplica(multiplicando), .subtraindo(sinal_op), .start(start),
            .dout(saida_ula), .finish(finish));


/* Regularização da saída */
wire c_out;
assign c_out = saida_ula[27];

wire [7:0] exp_s;
assign exp_s = (multiplicando ? reg_exp + c_out : (sinal_exp ?  exp_b : exp_a) - c_out) + 125;

wire sinal_s;
assign sinal_s = multiplicando ? sinal_op : ((sinal_a & sinal_b) | c_out);

wire[22:0] fract_s;
assign fract_s = saida_ula[25:3] + (saida_ula[2] & (saida_ula[1] | saida_ula[0]));

assign s = {sinal_s, exp_s, fract_s};


endmodule

module ULAUC(
    input [23:0]  a,
    input [23:0]  b,
    input clk,
    input multiplica,
    input subtraindo,
    input start,
    output reg [27:0] dout,
    output reg finish
);

reg [2:0] estado_atual;
reg [2:0] prox_estado;
parameter inicio = 0, somando = 1, teste_mult = 2, multiplicando = 3, fim = 4;

reg [4:0] bits_mult;
reg [26:0] parcela_mult;

wire [26:0] parcela_shift;
assign parcela_shift = {b,3'b0} >> (23 - bits_mult);


 

always @ (posedge clk)
    begin
        estado_atual <= prox_estado;
    end

always @ (posedge start) prox_estado <= inicio;

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
                    if(subtraindo)
                        dout <= {{1'b0,b} - {1'b0,a}, 3'b0};
                    else
                        dout <= {{1'b0,a} + {1'b0,b}, 3'b0};
                    prox_estado <= fim;

                end
            
            teste_mult:
                begin
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
                    dout <= dout + {1'b0,parcela_mult};
                    bits_mult <= bits_mult + 1;
                    prox_estado <= teste_mult;

                end

            fim:
                begin
                    finish <= 1;
                end




        endcase


    end



endmodule