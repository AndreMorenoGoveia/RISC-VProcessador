module uc(clk, rst_n, opcode, d_mem_we, rf_we,
          alu_flags, alu_cmd, alu_src, pc_src,
          rf_src);



parameter zero = 0, MSB = 1, overflow = 2, n_usado_ainda = 3;  
input clk, rst_n;
reg[1:0] estado;
reg[1:0] prox_extado;
output reg rf_we;

/* ProgramCounter */
wire escolhe_constante;
wire [63:0] doutULAPC;
reg soma_imm_PC;

input alu_src, pc_src, rf_src; 
input [31:0] i_mem_data;
output [i_addr_bits - 1: 0] i_mem_addr;
output [d_addr_bits - 1: 0] d_mem_addr;
inout [63: 0] d_mem_data;


/* instrução */
input [6:0] opcode;


parameter fetch = 0, decode = 1, ex = 2, wb = 3;

initial
begin
    prox_extado <= fetch;
    atualiza_pc <= 0;
    soma_imm_PC <= 0;
end

/* Mudança de estado */
always @ (posedge clk)
    begin
        if(rst_n)
            begin
                estado <= fetch;
            end
        else
            begin
                estado <= prox_extado;
            end

    end

    /* Ações do estado */
    always @ (estado, reset)
        begin
            case(estado)

                fetch:
                    begin
                        rf_we <= 0;
                        atualiza_pc <= 1;

                        prox_extado <= decode;
                    end
                decode:
                    begin
                        atualiza_pc <= 0;

                        prox_extado <= ex;
                    end
                ex:
                    begin
                        

                        prox_extado <= wb;
                    end
                wb:
                    begin
                        if(soma_ou_subtrai | load)
                            rf_we <= 1;

                        prox_extado <= fetch;
                    end


            endcase
        end


        /*add e sub */
        assign soma_ou_subtrai = 


        /* load */
        assign load = opcode === 7'b0000011;

        ProgramCounter pc(.clk(atualiza_pc), .din(doutULAPC), .dout(doutPC));
        ULAPC ulapc(.din(doutPC), .imm(imm_pc), .soma_imm(soma_imm_PC), .dout(doutULAPC));


endmodule