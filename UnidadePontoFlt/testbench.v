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
    rst <= 0;
    a <= 32'b00111111101001100110011001100110;//0.987
    b <= 32'b10111111101100110011001100110011;//1.02
    #1000 
    opcode <= 2'b00;
    #10
    start <= 1;
    

    #1000000
    $finish;
end

always #500 clk <= ~clk;


fpu FP(.clk(clk), .rst(rst), .A(a), .B(b), .start(start),
                   .op(opcode), .R(s),
                   .done(done));


endmodule