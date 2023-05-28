module Flags(dinA, dinB, flag_maior_igual_u, flag_igual, flag_menor);

input [63:0] dinA;
input [63:0] dinB;

output flag_maior_igual_u, flag_igual, flag_menor;

assign flag_maior_igual_u = dinA >= dinB;
assign flag_igual = dinA == dinB;
assign flag_menor = dinA[63] != 1 ? dinB[63] != 1 ?
                    dinA < dinB : 0: dinB[63] != 1 ? 
                    1 : dinA < dinB;


endmodule