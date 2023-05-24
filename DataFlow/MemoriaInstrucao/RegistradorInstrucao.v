module RegistradorInstrucao(entrada, saida, clk);

    input clk;
    input [31:0] entrada;
    output reg [31:0] saida;

    always @ (posedge clk)
        saida <= entrada;

endmodule