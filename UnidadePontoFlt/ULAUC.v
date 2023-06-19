module ULAUC(
    input [23:0]  a,
    input [23:0]  b,
    input clk,
    input multiplica,
    input start,
    output reg [23:0] dout,
    output reg c_out,
    output reg finish
);

reg [2:0] estado_atual;
reg [2:0] prox_estado;
parameter inicio = 0, somando = 1, teste_mult = 2, multiplicando = 3, fim = 4;

reg [4:0] bits_mult;
reg [23:0] parcela;

 

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
                                    dout <= 0;

                                end
                            else
                                prox_estado <= somando;


                        end
                end

            somando:
                begin
                    
                    dout <= a + b;
                    if(a[22] & b[22])
                        c_out <= 1;
                    else
                        c_out <= 0;
                    prox_estado <= fim;

                end
            
            teste_mult:
                begin
                    if(bits_mult > 22)
                        prox_estado <= fim;
                    else
                        begin
                            if(a[bits_mult] == 0)
                                parcela <= 0;
                            else
                                parcela <= b;
                                prox_estado <= multiplicando;
                        end
                    
                end
            
            multiplicando:
                begin
                    dout <= dout + parcela;
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