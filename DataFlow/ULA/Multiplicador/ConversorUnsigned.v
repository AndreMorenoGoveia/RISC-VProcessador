module ConversorUnsigned (input [7:0] A, input [7:0] B, input [15:0] RES,
                          output [7:0] AUnsigned, output [7:0] BUnsigned, output [15:0] RESFINAL);

    /* Deixa os números sem sinal */
    assign AUnsigned = (A[7] == 1) ?  ~A + 8'd1 : A;
    assign BUnsigned = (B[7] == 1) ?  ~B + 8'd1 : B;

    assign RESFINAL = ((A[7] == 1) & (B[7] == 1)) ? RES :
                      ((A[7] == 1) & (B[7] == 0)) ? ~RES + 1'b1:
                      ((A[7] == 0) & (B[7] == 1)) ? ~RES + 1'b1:
                      RES;

endmodule