module ULAPC (din, imm, soma_imm, dout);

    input [63:0] din;
    input [63:0] imm;
    input soma_imm;
    wire [63:0] parcela;
    output [63:0] dout;

    assign parcela = soma_imm ? imm : 64'd4;

    assign dout = din + parcela;

    

endmodule