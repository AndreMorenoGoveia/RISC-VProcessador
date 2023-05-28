module ULA  #(parameter BITS = 64)
            (dina, dinb, constante, soma_ou_subtrai, subtraindo, imediato,
             dout, flag_maior_u, flag_igual, flag_menor);

    input [BITS-1:0] dina, dinb, constante;
    input soma_ou_subtrai, subtraindo, imediato;

    output flag_maior_u, flag_igual, flag_menor;
    output [BITS-1:0] dout;

    wire [BITS-1:0] fator1, fator2;
    wire [BITS-1:0] outs;

    assign fator1 = dina;


    MuxBC mux1(.B(dinb), .C(constante), .imediato(imediato), .S(fator2));

    SomadorSubtrator soma_sub(.subtraindo(subtraindo), .A(fator1), .B(fator2), .S(outs));

    Flags flags(.dinA(dina), .dinB(dinb), .flag_maior_u(flag_maior_u),
          .flag_igual(flag_igual), .flag_menor(flag_menor));

    assign dout = soma_ou_subtrai ? outs : 0;

endmodule