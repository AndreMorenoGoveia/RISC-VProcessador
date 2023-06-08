module polirv  
    #(
        parameter i_addr_bits = 6,
        parameter d_addr_bits = 6
    ) (
        input clk, rst_n,                       // clock borda subida, reset assíncrono ativo baixo
        output [i_addr_bits-1:0] i_mem_addr,
        input  [31:0]            i_mem_data,
        output                   d_mem_we,
        output [d_addr_bits-1:0] d_mem_addr,
        inout  [63:0]            d_mem_data
    );

    
  
  



    /* Conexoes entre uc e fd */
    wire [6:0] opcode;
    wire d_mem_we;
    wire rf_we;
    wire [3:0] alu_cmd;
    wire [3:0] alu_flags;
    wire alu_src, pc_src, rf_src;

    
    wire [63:0] imm_pc;
    
    
    


    uc UC(.clk(clk), .rst_n(rst_n),
          .opcode(opcode),
          .d_mem_we(d_mem_we), .rf_we(rf_we),
          .alu_flags(alu_flags),
          .alu_cmd(alu_cmd),
          .alu_src(alu_src), .pc_src(pc_src), .rf_src(rf_src));


    
    fd DF(.clk(clk), .rst_n(rst_n),
          .opcode(opcode),
          .d_mem_we(d_mem_we), .rf_we(rf_we),
          .alu_flags(alu_flags),
          .alu_cmd(alu_cmd),
          .alu_src(alu_src),
          .pc_src(pc_src),
          .rf_src(rf_src),
          .i_mem_addr(i_mem_addr),
          .i_mem_data(i_mem_data),
          .d_mem_addr(d_mem_addr),
          .d_mem_data(d_mem_data));


endmodule