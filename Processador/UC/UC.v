module UC(clk, reset, imm_pc, opcode, funct7, funct3, soma_ou_subtrai,
          doutPC, atualiza_pc, WeR, load);

input clk, reset;
reg[1:0] estado;
reg[1:0] prox_extado;
output reg WeR;

/* ProgramCounter */
output reg atualiza_pc;
wire escolhe_constante;
output [63:0] doutPC;
wire [63:0] doutULAPC;
input [63:0] imm_pc;
reg soma_imm_PC;

/* instrução */
input [6:0] opcode;
input [6:0] funct7;
input [2:0] funct3;

/* add/sub */
output [1:0] soma_ou_subtrai;
parameter nao = 0, soma = 1, subrtrai = 2;

/* load */
output load;

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
        if(reset)
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
                        WeR <= 0;
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
                            WeR <= 1;

                        prox_extado <= fetch;
                    end


            endcase
        end

        /* add/sub */
        assign soma_ou_subtrai = opcode === 7'b0110011 ? funct7 === 7'b0000000 ? soma : subrtrai : nao;

        /* load */
        assign load = opcode === 7'b0000011;

        ProgramCounter pc(.clk(atualiza_pc), .din(doutULAPC), .dout(doutPC));
        ULAPC ulapc(.din(doutPC), .imm(imm_pc), .soma_imm(soma_imm_PC), .dout(doutULAPC));


endmodule