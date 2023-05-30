module DataFlow(clk);

input clk;


wire [4:0] Ra, Rb, Rw;
wire WeR;
wire [63:0] dinR, douta, doutb;



BancoRegistradores RF(.Ra(Ra), .Rb(Rb), .clk(clk), .We(WeR), .din(dinR),
                         .Rw(Rw), .douta(douta), .doutb(doutb));


endmodule