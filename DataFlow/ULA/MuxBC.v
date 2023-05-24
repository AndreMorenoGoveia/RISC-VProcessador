module MuxBC #(parameter BITS = 64) (B, C, imediato, S);

    input imediato;
    input [BITS-1:0] B, C;
    output [BITS-1:0] S;

    assign S = imediato ? C : B;

endmodule