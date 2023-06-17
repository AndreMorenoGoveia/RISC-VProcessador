`timescale 1ns/1ps

module SomadorSubtrator_tb;

reg [63:0] a;
reg [63:0] b;
reg subtraindo;

wire [63:0] s;
wire cout;
wire W1, W2, W3, W4, W5, W6, W7, W8, W9, W10,
     W11, W12, W13, W14, W15, W16, W17, W18, W19, W20,
     W21, W22, W23, W24, W25, W26, W27, W28, W29, W30, 
     W31, W32, W33, W34, W35, W36, W37, W38, W39, W40, 
     W41, W42, W43, W44, W45, W46, W47, W48, W49, W50, 
     W51, W52, W53, W54, W55, W56, W57, W58, W59, W60, 
     W61, W62, W63;

SomadorSubtrator S(.subtraindo(subtraindo), .A(a), .B(b), .S(s), .cout(cout));
FullAdder_comb S0 (.a(a[0]), .b(b[0]), .cin(1'b0), .s(s[0]), .cout(W1));
FullAdder_comb S1 (.a(a[1]), .b(b[1]), .cin(W1), .s(s[1]), .cout(W2));
FullAdder_comb S2 (.a(a[2]), .b(b[2]), .cin(W2), .s(s[2]), .cout(W3));
FullAdder_comb S3 (.a(a[3]), .b(b[3]), .cin(W3), .s(s[3]), .cout(W4));
FullAdder_comb S4 (.a(a[4]), .b(b[4]), .cin(W4), .s(s[4]), .cout(W5));
FullAdder_comb S5 (.a(a[5]), .b(b[5]), .cin(W5), .s(s[5]), .cout(W6));
FullAdder_comb S6 (.a(a[6]), .b(b[6]), .cin(W6), .s(s[6]), .cout(W7));
FullAdder_comb S7 (.a(a[7]), .b(b[7]), .cin(W7), .s(s[7]), .cout(W8));
FullAdder_comb S8 (.a(a[8]), .b(b[8]), .cin(W8), .s(s[8]), .cout(W9));
FullAdder_comb S9 (.a(a[9]), .b(b[9]), .cin(W9), .s(s[9]), .cout(W10));
FullAdder_comb S10 (.a(a[10]), .b(b[10]), .cin(W10), .s(s[10]), .cout(W11));
FullAdder_comb S11 (.a(a[11]), .b(b[11]), .cin(W11), .s(s[11]), .cout(W12));
FullAdder_comb S12 (.a(a[12]), .b(b[12]), .cin(W12), .s(s[12]), .cout(W13));
FullAdder_comb S13 (.a(a[13]), .b(b[13]), .cin(W13), .s(s[13]), .cout(W14));
FullAdder_comb S14 (.a(a[14]), .b(b[14]), .cin(W14), .s(s[14]), .cout(W15));
FullAdder_comb S15 (.a(a[15]), .b(b[15]), .cin(W15), .s(s[15]), .cout(W16));
FullAdder_comb S16 (.a(a[16]), .b(b[16]), .cin(W16), .s(s[16]), .cout(W17));
FullAdder_comb S17 (.a(a[17]), .b(b[17]), .cin(W17), .s(s[17]), .cout(W18));
FullAdder_comb S18 (.a(a[18]), .b(b[18]), .cin(W18), .s(s[18]), .cout(W19));
FullAdder_comb S19 (.a(a[19]), .b(b[19]), .cin(W19), .s(s[19]), .cout(W20));
FullAdder_comb S20 (.a(a[20]), .b(b[20]), .cin(W20), .s(s[20]), .cout(W21));
FullAdder_comb S21 (.a(a[21]), .b(b[21]), .cin(W21), .s(s[21]), .cout(W22));
FullAdder_comb S22 (.a(a[22]), .b(b[22]), .cin(W22), .s(s[22]), .cout(W23));
FullAdder_comb S23 (.a(a[23]), .b(b[23]), .cin(W23), .s(s[23]), .cout(W24));
FullAdder_comb S24 (.a(a[24]), .b(b[24]), .cin(W24), .s(s[24]), .cout(W25));
FullAdder_comb S25 (.a(a[25]), .b(b[25]), .cin(W25), .s(s[25]), .cout(W26));
FullAdder_comb S26 (.a(a[26]), .b(b[26]), .cin(W26), .s(s[26]), .cout(W27));
FullAdder_comb S27 (.a(a[27]), .b(b[27]), .cin(W27), .s(s[27]), .cout(W28));
FullAdder_comb S28 (.a(a[28]), .b(b[28]), .cin(W28), .s(s[28]), .cout(W29));
FullAdder_comb S29 (.a(a[29]), .b(b[29]), .cin(W29), .s(s[29]), .cout(W30));
FullAdder_comb S30 (.a(a[30]), .b(b[30]), .cin(W30), .s(s[30]), .cout(W31));
FullAdder_comb S31 (.a(a[31]), .b(b[31]), .cin(W31), .s(s[31]), .cout(W32));
FullAdder_comb S32 (.a(a[32]), .b(b[32]), .cin(W32), .s(s[32]), .cout(W33));
FullAdder_comb S33 (.a(a[33]), .b(b[33]), .cin(W33), .s(s[33]), .cout(W34));
FullAdder_comb S34 (.a(a[34]), .b(b[34]), .cin(W34), .s(s[34]), .cout(W35));
FullAdder_comb S35 (.a(a[35]), .b(b[35]), .cin(W35), .s(s[35]), .cout(W36));
FullAdder_comb S36 (.a(a[36]), .b(b[36]), .cin(W36), .s(s[36]), .cout(W37));
FullAdder_comb S37 (.a(a[37]), .b(b[37]), .cin(W37), .s(s[37]), .cout(W38));
FullAdder_comb S38 (.a(a[38]), .b(b[38]), .cin(W38), .s(s[38]), .cout(W39));
FullAdder_comb S39 (.a(a[39]), .b(b[39]), .cin(W39), .s(s[39]), .cout(W40));
FullAdder_comb S40 (.a(a[40]), .b(b[40]), .cin(W40), .s(s[40]), .cout(W41));
FullAdder_comb S41 (.a(a[41]), .b(b[41]), .cin(W41), .s(s[41]), .cout(W42));
FullAdder_comb S42 (.a(a[42]), .b(b[42]), .cin(W42), .s(s[42]), .cout(W43));
FullAdder_comb S43 (.a(a[43]), .b(b[43]), .cin(W43), .s(s[43]), .cout(W44));
FullAdder_comb S44 (.a(a[44]), .b(b[44]), .cin(W44), .s(s[44]), .cout(W45));
FullAdder_comb S45 (.a(a[45]), .b(b[45]), .cin(W45), .s(s[45]), .cout(W46));
FullAdder_comb S46 (.a(a[46]), .b(b[46]), .cin(W46), .s(s[46]), .cout(W47));
FullAdder_comb S47 (.a(a[47]), .b(b[47]), .cin(W47), .s(s[47]), .cout(W48));
FullAdder_comb S48 (.a(a[48]), .b(b[48]), .cin(W48), .s(s[48]), .cout(W49));
FullAdder_comb S49 (.a(a[49]), .b(b[49]), .cin(W49), .s(s[49]), .cout(W50));
FullAdder_comb S50 (.a(a[50]), .b(b[50]), .cin(W50), .s(s[50]), .cout(W51));
FullAdder_comb S51 (.a(a[51]), .b(b[51]), .cin(W51), .s(s[51]), .cout(W52));
FullAdder_comb S52 (.a(a[52]), .b(b[52]), .cin(W52), .s(s[52]), .cout(W53));
FullAdder_comb S53 (.a(a[53]), .b(b[53]), .cin(W53), .s(s[53]), .cout(W54));
FullAdder_comb S54 (.a(a[54]), .b(b[54]), .cin(W54), .s(s[54]), .cout(W55));
FullAdder_comb S55 (.a(a[55]), .b(b[55]), .cin(W55), .s(s[55]), .cout(W56));
FullAdder_comb S56 (.a(a[56]), .b(b[56]), .cin(W56), .s(s[56]), .cout(W57));
FullAdder_comb S57 (.a(a[57]), .b(b[57]), .cin(W57), .s(s[57]), .cout(W58));
FullAdder_comb S58 (.a(a[58]), .b(b[58]), .cin(W58), .s(s[58]), .cout(W59));
FullAdder_comb S59 (.a(a[59]), .b(b[59]), .cin(W59), .s(s[59]), .cout(W60));
FullAdder_comb S60 (.a(a[60]), .b(b[60]), .cin(W60), .s(s[60]), .cout(W61));
FullAdder_comb S61 (.a(a[61]), .b(b[61]), .cin(W61), .s(s[61]), .cout(W62));
FullAdder_comb S62 (.a(a[62]), .b(b[62]), .cin(W62), .s(s[62]), .cout(W63));
FullAdder_comb S63 (.a(a[63]), .b(b[63]), .cin(W63), .s(s[63]), .cout(cout));

initial
begin
    $dumpfile("test.vcd");
    $dumpvars(0,SomadorSubtrator_tb);

    $monitor ("time = %d \t a=%b \t b = %b \t s = %b \t cout = %b", $time, a, b, s, cout);

    subtraindo = 0;
    a = 64'b1001;
    b = 64'b1001;

    #50

    a = 64'b1010;
    b = 64'b1010;


end

endmodule

