module uc(
    input clk, rst_n,                       // clock borda subida, reset assíncrono ativo baixo
    input [6:0] opcode,                     // OpCode direto do IR no FD
    output d_mem_we, rf_we,                 // Habilita escrita na memória de dados e no banco de registradores
    input  [3:0] alu_flags,                 // Flags da ULA
    output [3:0] alu_cmd,                   // Operação da ULA
    output alu_src, pc_src, rf_src          // Seletor dos MUXes
);  

parameter R = 4'b0000, I = 4'b0001, S = 4'b0010, SB = 4'b0011, U = 4'b0100, UJ = 4'b0101;
parameter zero = 0, MSB = 1, overflow = 2, n_usado_ainda = 3;


parameter fetch = 0, decode = 1, ex = 2, wb = 3;
reg[1:0] estado;
reg[1:0] prox_extado;

reg rf_we_reg, d_mem_we_reg;


/** Alu_cmd **/
                 /* Tipo R (add e sub) */
assign alu_cmd = (opcode === 7'b0110011) ? R  :
                 /* Tipo I (lw e addi) */ 
                 (opcode === 7'b0000011) |
                 (opcode === 7'b0010011) ? I  :
                 /* Tipo S (sw) */ 
                 (opcode === 7'b0100011) ? S  :
                 /* Tipo SB (branch) */ 
                 (opcode === 7'b1100011) ? SB :
                 /* Tipo U (auipc) */
                 (opcode === 7'b0010111) ? U  :
                 /* tipo UJ (jal) */
                 UJ;
                 




initial
begin
    prox_extado <= fetch;
    rf_we_reg <= 0;
    d_mem_we_reg <= 0;
end

/* Mudança de estado */
always @ (posedge clk, rst_n)
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
    always @ (estado)
        begin
            case(estado)

                fetch:
                    begin
                        prox_extado <= decode;
                    end
                decode:
                    begin

                        prox_extado <= ex;
                    end
                ex:
                    begin
                        if(alu_cmd !== S)
                            rf_we_reg <= 1;
                        else
                            d_mem_we_reg <= 1;
                            
                        prox_extado <= wb;
                    end
                wb:
                    begin
                        rf_we_reg <= 0;
                        d_mem_we_reg <= 0;
                        prox_extado <= fetch;
                    end


            endcase
        end


/* Write Enable e src */
assign rf_we    = rf_we_reg,
       d_mem_we = d_mem_we_reg;

assign rf_src = (alu_cmd === S),
       pc_src = (alu_cmd === UJ) | (alu_cmd === SB & zero),
       alu_src = (alu_cmd === S) | (alu_cmd === I);


endmodule