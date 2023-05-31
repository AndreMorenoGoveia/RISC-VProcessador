module ULA  #(parameter BITS = 64)
            (dina, dinb, imm, soma_ou_subtrai, usa_imm,
             dout, flag_maior_igual_u, flag_igual, flag_menor);

    parameter nao = 0, soma = 1, subrtrai = 2;

    input [BITS-1:0] dina, dinb, imm;
    input usa_imm;
    input [1:0] soma_ou_subtrai;

    output flag_maior_igual_u, flag_igual, flag_menor;
    output [BITS-1:0] dout;

    wire subtraindo;
    wire [BITS-1:0] fator1, fator2;
    wire [BITS-1:0] outs;

    assign subtraindo = soma_ou_subtrai === subrtrai ? 1 : 0;

    assign fator1 = dina;


    MuxBC mux1(.B(dinb), .C(imm), .usa_imm(usa_imm), .S(fator2));

    SomadorSubtrator soma_sub(.subtraindo(subtraindo), .A(fator1), .B(fator2), .S(outs));

    Flags flags(.dinA(dina), .dinB(dinb), .flag_maior_igual_u(flag_maior_igual_u),
                .flag_igual(flag_igual), .flag_menor(flag_menor));

    assign dout = outs;

endmodule