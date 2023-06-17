module ULA  #(parameter BITS = 64)
            (dina, dinb, imm, subtraindo, alu_src, operacao,
             dout, flag_maior_igual_u, flag_igual, flag_menor,
             flag_overflow);


    input [BITS-1:0] dina, dinb, imm;
    input alu_src;
    input subtraindo;
    input [1:0] operacao;
    parameter S = 0, AND = 1, OR = 2;

    output flag_maior_igual_u, flag_igual, flag_menor, flag_overflow;
    output [BITS-1:0] dout, dout_s, dout_and, dout_or;

    wire [BITS-1:0] fator_1, fator_2;

    assign fator_1 = dina;

    /* mux ula */
    assign fator_2 = alu_src ? imm : dinb;

    /* MUX saída */
    assign dout = operacao === S   ? dout_s   :
                  operacao === AND ? dout_and :
                  dout_or;

    /* AND */
    assign dout_and = fator_1 & fator_2;

    /* OR */
    assign dout_or = fator_1 | fator_2;

    SomadorSubtrator soma_sub(.subtraindo(subtraindo), .A(fator_1), .B(fator_2), .S(dout_s), .cout(flag_overflow));

    Flags flags(.dinA(dina), .dinB(dinb), .flag_maior_igual_u(flag_maior_igual_u),
                .flag_igual(flag_igual), .flag_menor(flag_menor));


endmodule