module testbench;

reg clk;
reg rst;
reg [31:0] a, b;
wire [31:0] s;
reg [1:0] opcode;
wire done;
reg start;
reg [4:0] teste;


initial 
begin
    $dumpfile("float_wave.vcd");
    $dumpvars(0, testbench);

    clk <= 0;
    a <= 32'b01000010011110000000000000000000;//0.987
    b <= 32'b01000011011110010000000000000000;//1.02
    #1000 
    opcode <= 2'b10;
    #10
    start <= 1;
    

    #1000000
    $finish;
end

always #500 clk <= ~clk;


FPUnit FP(.clk(clk), .rst(rst), .a(a), .b(b), .start(start),
                   .opcode(opcode), .s(s),
                   .done(done));


endmodule