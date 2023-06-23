module testbench;

reg clk;
reg [31:0] a, b;
wire [31:0] s;
reg multiplicando;
wire finish;
reg start;



initial 
begin
    $dumpfile("float_wave.vcd");
    $dumpvars(0, testbench);

    clk <= 0;
    a <= 32'b11000000001000000000000000000000;//2.5
    b <= 32'b01000000010000000000000000000000;//3
    #1000 
    multiplicando <= 0;
    #10
    start <= 1;


    #1000000
    $finish;
end

always #500 clk <= ~clk;


FPUnit FP(.clk(clk), .a(a), .b(b), .start(start),
                   .multiplicando(multiplicando), .s(s),
                   .finish(finish));


endmodule