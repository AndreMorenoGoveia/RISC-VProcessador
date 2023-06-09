module Memoria 
    #(
        parameter i_addr_bits = 6,
        parameter d_addr_bits = 6
    )(
        input clk,
        input [i_addr_bits-1:0] i_mem_addr,
        output [31:0]           i_mem_data,
        input                   d_mem_we,
        input [d_addr_bits-1:0] d_mem_addr,
        inout [63:0]            d_mem_data
    );
    
    wire [63:0] data_in;
    assign data_in = d_mem_we ? 64'bz : d_mem_data;


    /* Dados */
    MemoriaDados DM(.addr(d_mem_addr[d_addr_bits-1:3]), .We(d_mem_we), .din(data_in), .clk(clk), .dout(d_mem_data));

    /* Instruções */
    MemoriaInstrucao IM(.addr(i_mem_addr[i_addr_bits-1:2]), .dout(i_mem_data));



endmodule