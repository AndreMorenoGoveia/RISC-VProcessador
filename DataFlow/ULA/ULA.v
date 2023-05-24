module ULA  #(parameter BITS = 64)
            (dina, dinb, constante, soma_ou_subtrai, subtraindo, imediato, dout);

    input [BITS-1:0] dina, dinb, constante;
    input soma_ou_subtrai, subtraindo, imediato;
    input [1:0] escolhe_entrada1, escolhe_entrada2;
    output [BITS-1:0] dout;

    wire [BITS-1:0] fator1, fator2;
    wire [BITS-1:0] outs;

    assign fator1 = dina;


    MuxBC mux1(.B(dinb), .C(constante), .imediato(imediato), .S(fator2));

    SomadorSubtrator S(.subtraindo(subtraindo), .A(fator1), .B(fator2), .S(outs));

    assign dout = soma_ou_subtrai ? outs : 0;

endmodule