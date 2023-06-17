module SomadorSubtrator #(parameter BITS = 64) 
(input subtraindo,
 input [BITS-1:0] A,
 input [BITS-1:0] B,
 output [BITS-1:0] S,
 output cout);


wire [BITS-1:0] BSigned;
wire W1, W2, W3, W4, W5, W6, W7, W8, W9, W10,
     W11, W12, W13, W14, W15, W16, W17, W18, W19, W20,
     W21, W22, W23, W24, W25, W26, W27, W28, W29, W30, 
     W31, W32, W33, W34, W35, W36, W37, W38, W39, W40, 
     W41, W42, W43, W44, W45, W46, W47, W48, W49, W50, 
     W51, W52, W53, W54, W55, W56, W57, W58, W59, W60, 
     W61, W62, W63;

assign BSigned = subtraindo ? ~B + 1'b1 : B; 

FullAdder_comb S0 (.a(A[0]), .b(BSigned[0]), .cin(1'b0), .s(S[0]), .cout(W1));
FullAdder_comb S1 (.a(A[1]), .b(BSigned[1]), .cin(W1), .s(S[1]), .cout(W2));
FullAdder_comb S2 (.a(A[2]), .b(BSigned[2]), .cin(W2), .s(S[2]), .cout(W3));
FullAdder_comb S3 (.a(A[3]), .b(BSigned[3]), .cin(W3), .s(S[3]), .cout(W4));
FullAdder_comb S4 (.a(A[4]), .b(BSigned[4]), .cin(W4), .s(S[4]), .cout(W5));
FullAdder_comb S5 (.a(A[5]), .b(BSigned[5]), .cin(W5), .s(S[5]), .cout(W6));
FullAdder_comb S6 (.a(A[6]), .b(BSigned[6]), .cin(W6), .s(S[6]), .cout(W7));
FullAdder_comb S7 (.a(A[7]), .b(BSigned[7]), .cin(W7), .s(S[7]), .cout(W8));
FullAdder_comb S8 (.a(A[8]), .b(BSigned[8]), .cin(W8), .s(S[8]), .cout(W9));
FullAdder_comb S9 (.a(A[9]), .b(BSigned[9]), .cin(W9), .s(S[9]), .cout(W10));
FullAdder_comb S10 (.a(A[10]), .b(BSigned[10]), .cin(W10), .s(S[10]), .cout(W11));
FullAdder_comb S11 (.a(A[11]), .b(BSigned[11]), .cin(W11), .s(S[11]), .cout(W12));
FullAdder_comb S12 (.a(A[12]), .b(BSigned[12]), .cin(W12), .s(S[12]), .cout(W13));
FullAdder_comb S13 (.a(A[13]), .b(BSigned[13]), .cin(W13), .s(S[13]), .cout(W14));
FullAdder_comb S14 (.a(A[14]), .b(BSigned[14]), .cin(W14), .s(S[14]), .cout(W15));
FullAdder_comb S15 (.a(A[15]), .b(BSigned[15]), .cin(W15), .s(S[15]), .cout(W16));
FullAdder_comb S16 (.a(A[16]), .b(BSigned[16]), .cin(W16), .s(S[16]), .cout(W17));
FullAdder_comb S17 (.a(A[17]), .b(BSigned[17]), .cin(W17), .s(S[17]), .cout(W18));
FullAdder_comb S18 (.a(A[18]), .b(BSigned[18]), .cin(W18), .s(S[18]), .cout(W19));
FullAdder_comb S19 (.a(A[19]), .b(BSigned[19]), .cin(W19), .s(S[19]), .cout(W20));
FullAdder_comb S20 (.a(A[20]), .b(BSigned[20]), .cin(W20), .s(S[20]), .cout(W21));
FullAdder_comb S21 (.a(A[21]), .b(BSigned[21]), .cin(W21), .s(S[21]), .cout(W22));
FullAdder_comb S22 (.a(A[22]), .b(BSigned[22]), .cin(W22), .s(S[22]), .cout(W23));
FullAdder_comb S23 (.a(A[23]), .b(BSigned[23]), .cin(W23), .s(S[23]), .cout(W24));
FullAdder_comb S24 (.a(A[24]), .b(BSigned[24]), .cin(W24), .s(S[24]), .cout(W25));
FullAdder_comb S25 (.a(A[25]), .b(BSigned[25]), .cin(W25), .s(S[25]), .cout(W26));
FullAdder_comb S26 (.a(A[26]), .b(BSigned[26]), .cin(W26), .s(S[26]), .cout(W27));
FullAdder_comb S27 (.a(A[27]), .b(BSigned[27]), .cin(W27), .s(S[27]), .cout(W28));
FullAdder_comb S28 (.a(A[28]), .b(BSigned[28]), .cin(W28), .s(S[28]), .cout(W29));
FullAdder_comb S29 (.a(A[29]), .b(BSigned[29]), .cin(W29), .s(S[29]), .cout(W30));
FullAdder_comb S30 (.a(A[30]), .b(BSigned[30]), .cin(W30), .s(S[30]), .cout(W31));
FullAdder_comb S31 (.a(A[31]), .b(BSigned[31]), .cin(W31), .s(S[31]), .cout(W32));
FullAdder_comb S32 (.a(A[32]), .b(BSigned[32]), .cin(W32), .s(S[32]), .cout(W33));
FullAdder_comb S33 (.a(A[33]), .b(BSigned[33]), .cin(W33), .s(S[33]), .cout(W34));
FullAdder_comb S34 (.a(A[34]), .b(BSigned[34]), .cin(W34), .s(S[34]), .cout(W35));
FullAdder_comb S35 (.a(A[35]), .b(BSigned[35]), .cin(W35), .s(S[35]), .cout(W36));
FullAdder_comb S36 (.a(A[36]), .b(BSigned[36]), .cin(W36), .s(S[36]), .cout(W37));
FullAdder_comb S37 (.a(A[37]), .b(BSigned[37]), .cin(W37), .s(S[37]), .cout(W38));
FullAdder_comb S38 (.a(A[38]), .b(BSigned[38]), .cin(W38), .s(S[38]), .cout(W39));
FullAdder_comb S39 (.a(A[39]), .b(BSigned[39]), .cin(W39), .s(S[39]), .cout(W40));
FullAdder_comb S40 (.a(A[40]), .b(BSigned[40]), .cin(W40), .s(S[40]), .cout(W41));
FullAdder_comb S41 (.a(A[41]), .b(BSigned[41]), .cin(W41), .s(S[41]), .cout(W42));
FullAdder_comb S42 (.a(A[42]), .b(BSigned[42]), .cin(W42), .s(S[42]), .cout(W43));
FullAdder_comb S43 (.a(A[43]), .b(BSigned[43]), .cin(W43), .s(S[43]), .cout(W44));
FullAdder_comb S44 (.a(A[44]), .b(BSigned[44]), .cin(W44), .s(S[44]), .cout(W45));
FullAdder_comb S45 (.a(A[45]), .b(BSigned[45]), .cin(W45), .s(S[45]), .cout(W46));
FullAdder_comb S46 (.a(A[46]), .b(BSigned[46]), .cin(W46), .s(S[46]), .cout(W47));
FullAdder_comb S47 (.a(A[47]), .b(BSigned[47]), .cin(W47), .s(S[47]), .cout(W48));
FullAdder_comb S48 (.a(A[48]), .b(BSigned[48]), .cin(W48), .s(S[48]), .cout(W49));
FullAdder_comb S49 (.a(A[49]), .b(BSigned[49]), .cin(W49), .s(S[49]), .cout(W50));
FullAdder_comb S50 (.a(A[50]), .b(BSigned[50]), .cin(W50), .s(S[50]), .cout(W51));
FullAdder_comb S51 (.a(A[51]), .b(BSigned[51]), .cin(W51), .s(S[51]), .cout(W52));
FullAdder_comb S52 (.a(A[52]), .b(BSigned[52]), .cin(W52), .s(S[52]), .cout(W53));
FullAdder_comb S53 (.a(A[53]), .b(BSigned[53]), .cin(W53), .s(S[53]), .cout(W54));
FullAdder_comb S54 (.a(A[54]), .b(BSigned[54]), .cin(W54), .s(S[54]), .cout(W55));
FullAdder_comb S55 (.a(A[55]), .b(BSigned[55]), .cin(W55), .s(S[55]), .cout(W56));
FullAdder_comb S56 (.a(A[56]), .b(BSigned[56]), .cin(W56), .s(S[56]), .cout(W57));
FullAdder_comb S57 (.a(A[57]), .b(BSigned[57]), .cin(W57), .s(S[57]), .cout(W58));
FullAdder_comb S58 (.a(A[58]), .b(BSigned[58]), .cin(W58), .s(S[58]), .cout(W59));
FullAdder_comb S59 (.a(A[59]), .b(BSigned[59]), .cin(W59), .s(S[59]), .cout(W60));
FullAdder_comb S60 (.a(A[60]), .b(BSigned[60]), .cin(W60), .s(S[60]), .cout(W61));
FullAdder_comb S61 (.a(A[61]), .b(BSigned[61]), .cin(W61), .s(S[61]), .cout(W62));
FullAdder_comb S62 (.a(A[62]), .b(BSigned[62]), .cin(W62), .s(S[62]), .cout(W63));
FullAdder_comb S63 (.a(A[63]), .b(BSigned[63]), .cin(W63), .s(S[63]), .cout(cout));

//assign S = A + BSigned;

endmodule
