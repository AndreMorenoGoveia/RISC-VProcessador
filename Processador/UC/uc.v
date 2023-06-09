module uc(
    input clk, rst_n,                       // clock borda subida, reset assíncrono ativo baixo
    input [6:0] opcode,                     // OpCode direto do IR no FD
    output d_mem_we, rf_we,                 // Habilita escrita na memória de dados e no banco de registradores
    input  [3:0] alu_flags,                 // Flags da ULA
    output [3:0] alu_cmd,                   // Operação da ULA
    output alu_src, pc_src, rf_src          // Seletor dos MUXes
);  

parameter zero = 0, MSB = 1, overflow = 2, n_usado_ainda = 3;


parameter fetch = 0, decode = 1, ex = 2, wb = 3;
reg[1:0] estado;
reg[1:0] prox_extado;








initial
begin
    prox_extado <= fetch;
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
                        //rf_we <= 0;

                        prox_extado <= decode;
                    end
                decode:
                    begin

                        prox_extado <= ex;
                    end
                ex:
                    begin
                        

                        prox_extado <= wb;
                    end
                wb:
                    begin

                        prox_extado <= fetch;
                    end


            endcase
        end


        


endmodule