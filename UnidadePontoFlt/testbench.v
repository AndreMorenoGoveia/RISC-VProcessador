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
    a <= 32'b00111110100110011001100110011010;//0.3
    b <= 32'b00111110010011001100110011001101;//0.2
    #1000 
    multiplicando <= 1;
    #10
    start <= 1;


    #1000000
    $finish;
end

always #500 clk <= ~clk;


UnidadePontoFlt FP(.clk(clk), .a(a), .b(b), .start(start),
                   .multiplicando(multiplicando), .s(s),
                   .finish(finish));


endmodule