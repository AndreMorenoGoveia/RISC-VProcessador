module MuxAB #(parameter BITS = 64) (A, B, C, seleciona_entrada, S);

    input [1:0] seleciona_entrada;
    input [BITS-1:0] A, B, C;
    output [BITS-1:0] S;

    assign S = seleciona_entrada == 2 ? C : seleciona_entrada == 1 ? A : B;

endmodule