module ULA  #(parameter BITS = 64)
            (dina, dinb, imm, subtraindo, alu_src,
             dout, flag_maior_igual_u, flag_igual, flag_menor);


    input [BITS-1:0] dina, dinb, imm;
    input alu_src;
    input subtraindo;

    output flag_maior_igual_u, flag_igual, flag_menor;
    output [BITS-1:0] dout;

    wire [BITS-1:0] fator_1, fator_2;

    assign fator_1 = dina;

    /* mux ula */
    assign fator_2 = alu_src ? imm : dinb;

    SomadorSubtrator soma_sub(.subtraindo(subtraindo), .A(fator_1), .B(fator_2), .S(dout));

    Flags flags(.dinA(dina), .dinB(dinb), .flag_maior_igual_u(flag_maior_igual_u),
                .flag_igual(flag_igual), .flag_menor(flag_menor));


endmodule