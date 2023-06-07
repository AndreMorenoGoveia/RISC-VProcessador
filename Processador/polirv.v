module polirv #(parameter i_addr_bits = 6, 
                  parameter d_addr_bits = 6)
(clk, rst_n, i_mem_data, i_mem_addr, d_mem_we, d_mem_addr, d_mem_data);


    input clk, rst_n;
    input [31:0] i_mem_data;
    wire [63:0] doutPC;
    output d_mem_we;

      input [31:0] i_mem_data;
      output [i_addr_bits - 1: 0] i_mem_addr;
      output [d_addr_bits - 1: 0] d_mem_addr;
      inout [63: 0] d_mem_data;


    wire [63:0] doutPC;
    wire [63:0] imm_pc;
    wire [6:0] opcode;
    wire [3:0] alu_cmd;
    wire [3:0] alu_flags;
    wire rf_we;


    UC uc(.clk(clk), .reset(reset), .imm_pc(imm_pc), .opcode(opcode),
          .funct7(funct7), .funct3(funct3), .soma_ou_subtrai(soma_ou_subtrai),
          .doutPC(doutPC), .atualiza_pc(atualiza_pc), .WeR(WeR));


    
    DataFlow df(.clk(clk), .instr(instr), .soma_ou_subtrai(soma_ou_subtrai),
                .imm(imm_pc), .opcode(opcode), .funct7(funct7), .funct3(funct3),
                .WeR(WeR), .doutULA(doutULA));


endmodule