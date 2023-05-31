module UC(clk, reset, imm_PC, upcode, funct7, soma_ou_subtrai);

input clk, reset;
reg[3:0] estado;

/* ProgramCounter */
reg atualiza_pc;
wire escolhe_constante;
wire [63:0] doutPC;
wire [63:0] doutULAPC;
input [63:0] imm_PC;

/* instrução */
input [6:0] upcode;
input [6:0] funct7;

/* add/sub */
output [1:0] soma_ou_subtrai;
parameter nao = 0, soma = 1, subrtrai = 2;


parameter init = 0, fetch = 1, decode = 2, ex = 3, wb = 4;

initial
begin
    estado <= fetch;
    atualiza_pc <= 0;
end

/* Mudança de estado */
always @ (posedge clk)
    begin
        case(estado)

            init:
                begin
                    estado <= fetch;
                end

            fetch:
                begin
                    estado <= decode;
                end

            decode:
                begin
                    estado <= ex;
                end
            ex:
                begin
                    estado <= wb;
                end
            wb:
                begin
                    estado <= fetch;
                end

        endcase

    end

    /* Ações do estado */
    always @ (estado, reset)
        begin
            case(estado)

                fetch:
                    begin
                        atualiza_pc <= 1;
                    end
                decode:
                    begin
                        atualiza_pc <= 0;
                    end
                ex:
                    begin
                        
                    end
                wb:
                    begin
                        
                    end


            endcase
        end

        /* add / sub */
        assign soma_ou_subtrai = upcode === 7'b0110011 ? funct7 === 7'b0000000 ? soma : subrtrai : nao;

        ProgramCounter pc(.clk(atualiza_pc), .din(doutULAPC), .dout(doutPC));
        ULAPC ulapc(.din(doutPC), .imm(imm_PC), .soma_imm(soma_imm_PC), .dout(doutULAPC));


endmodule