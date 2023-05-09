module SomadorSubtrator #(parameter BITS = 64) 
(input subtraindo,
 input [BITS-1:0] A,
 input [BITS-1:0] B,
 output [BITS-1:0] S);


wire [BITS-1:0] BSigned;

assign BSigned = subtraindo ? ~B + 1'b1 : B; 

assign S = A + BSigned;

endmodule