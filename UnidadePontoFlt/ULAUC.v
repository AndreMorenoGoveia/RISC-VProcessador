module ULAUC(
    input [23:0]  a,
    input [23:0]  b,
    input clk,
    input multiplica,
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