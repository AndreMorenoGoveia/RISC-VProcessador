module UC(clk, reset, imm_PC)

input clk, reset;
reg[2:0] estado;

/* ProgramCounter */
reg atualiza_pc;
wire escolhe_constante;
wire [63:0] doutPC;
wire [63:0] doutULAPC;
input [63:0] imm_PC;


parameter fetch = 0, decode = 1, ex = 2, wb = 3;

initial
begin
    estado <= fetch;
    atualiza_pc <= 0;
end

/* Mudança de estado */
always @ (posedge clk)
    begin
        case(estado)

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
                    estado <= fetch
                end

        endcase

    end

    /* Ações do estado */
    always @ (estado, reset)
        begin
            case(estado)

                fetch:
                    begin
                        atualiza_pc <= 1
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


        ProgramCounter pc(.clk(atualiza_pc), .din(doutULAPC), .dout(doutPC));
        ULAPC ulapc(.din(doutPC), .imm(imm_PC), .soma_imm(soma_imm_PC), .dout(doutULAPC));


endmodule