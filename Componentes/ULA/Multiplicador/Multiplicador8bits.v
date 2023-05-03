module Multiplicador8bits(start, done, A, B, RESFINAL, clock, reset);

/* Elementos da multiplicação */
input [7:0] A;
input [7:0] B;
wire [7:0] AUnsigned;
wire [7:0] BUnsigned;
wire [15:0] RES;
output [15:0] RESFINAL;


/* Clock e reset */
input clock, reset;

/* Elementos de controle */
input start;
output reg done;
reg startAux;

/* Conversor Complemento de 2 */
ConversorUnsigned inst0(.A(A), .B(B), .RES(RES), .AUnsigned(AUnsigned),
                        .BUnsigned(BUnsigned), .RESFINAL(RESFINAL));

/* Bloqueador do start */
always @ (posedge start) startAux = 1'b1;


/* Divisor de bits da entrada */
wire [3:0] Ah;
wire [3:0] Al;
wire [3:0] Bh;
wire [3:0] Bl;

assign Ah = AUnsigned[7:4],
       Al = AUnsigned[3:0],
       Bh = BUnsigned[7:4],
       Bl = BUnsigned[3:0];


/* Constantes de soma */
wire [4:0] K3;
wire [4:0] K4;

assign K3 = Ah + Al,
       K4 = Bh + Bl;

/* Produto entre K3 e K4 */
reg [9:0] ProdutoK3K4;

/* Constantes de multiplicação */
reg [7:0] K1;
reg [7:0] K2; 

/* Resultado */
assign RES = K1 + {K2, 8'd0} + {ProdutoK3K4 - (K1 + K2), 4'd0};

/* Componente ROM */
wire [9:0] Produto;
reg [9:0] Fatores;
ROM inst1(.Fatores(Fatores), .Produto(Produto));

/* Estados */
reg [1:0] estado;
parameter idle = 2'b00, inicio = 2'b01, multiplica = 2'b10, termina = 2'b11;


initial
begin

    estado <= idle;
    $dumpfile("Mult.vcd");
    $dumpvars(0, Multiplicador8bits);

end


always @ (posedge clock)
    begin

        if(reset)
            begin
                estado <= idle;
            end

        else
            begin

                case (estado) 

                        idle:
                            begin
                                if(startAux)
                                    estado <= inicio;
                            end
                        inicio:
                            begin
                                estado <= multiplica;
                            end
                        multiplica:
                            begin
                                estado <= termina;
                            end
                        termina:
                            begin
                                estado <= idle;
                            end

                endcase

            end


    end

always @ (estado)
    begin
        
        case(estado)

            idle:
                begin
                    
                end
            inicio:
                begin
                    done <= 1'b0;
                    startAux <= 1'b0;
                end
            multiplica:
                begin
                    /* Multiplicando K1 */
                    Fatores = {{1'b0, Al}, {1'b0, Bl}};
                    K1 = Produto[7:0];

                    /* Multiplicando K2 */
                    Fatores = {{1'b0, Ah}, {1'b0, Bh}};
                    K2 = Produto[7:0];

                    /* Multiplicando K3 e K4 */
                    Fatores = {K3, K4};
                    ProdutoK3K4 = Produto;
                end
            termina:
                begin
                    done = 1'b1;
                end
            

        endcase

    end

endmodule