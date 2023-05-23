module ULAPC (din, constante, escolhe_constante, dout);

    input [63:0] din;
    input [63:0] constante;
    input escolhe_constante;
    wire [63:0] parcela;

    assign parcela = escolhe_constante ? constante : 64'd4;

    assign dout = din + parcela;

    output [63:0] dout;

endmodule