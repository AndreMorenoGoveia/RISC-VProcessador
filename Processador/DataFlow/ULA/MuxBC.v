module MuxBC #(parameter BITS = 64) (B, C, usa_imm, S);

    input usa_imm;
    input [BITS-1:0] B, C;
    output [BITS-1:0] S;

    assign S = usa_imm ? C : B;

endmodule