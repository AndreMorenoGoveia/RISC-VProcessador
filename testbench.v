`timescale 1ns/100ps

module testbench;

    reg clk;
    reg [10:0] estado;

    /* BancoRegistradores */
    reg [4:0] Ra, Rb, Rw;
    reg [63:0] dinR;
    reg WeR;
    wire [63:0] douta, doutb;

    /* DataMemory */
    reg [63:0] dinM;
    wire [63:0] doutM;
    reg WeM;

    /* ULA */
    reg soma_ou_subtrai;
    reg subtraindo;
    reg imediato;
    reg [63:0] constanteULA;
    wire [63:0] doutULA;

    /* Program counter */
    reg [63:0] constantePC;
    wire [63:0] doutULAPC, doutPC;
    reg escolhe_constantePC;

    /* IntructionMemory */
    wire [31:0] instrTemp;
    wire [31:0] instr;

    /* Imediatos */
    wire [63:0] imediato_I;
    wire [63:0] imediato_J;
    wire [63:0] imediato_U;
    wire [63:0] imediato_B;
    wire [63:0] imediato_S;


    /* clock */
    always #500 clk = ~clk;

    initial 
    begin 

        $dumpfile("riscv.vcd");
        $dumpvars(0, testbench);
        estado <= inicio;
        clk <= 0;
        escolhe_constantePC <= 0;
        #1000000
        $finish;


    end

    /* Estados */
    parameter inicio = 0,
    loadInicialparte1 = 1, loadInicialparte2 = 2, load2parte1 = 3, load2parte2 = 4,
    load3parte1 = 5, load3parte2 = 6,
    store1 = 50,
    add1 = 100,
    sub1 = 200,
    subi1 = 250,
    addi1 = 300,
    jal1 = 350,
    jalr1 = 400,
    auipc1 = 450,
    fim = 500;

    /* Upcodes */
    parameter lw = 7'b0000011,
              sw = 7'b0100011,
              add_sub = 7'b0110011,
              branch = 7'b1100011,
              jal = 7'b1101111,
              jalr = 7'b1100111,
              auipc = 7'b0010111;

    /* funct7 */
    parameter add = 7'b0000000,
              sub = 7'b0100000;

    /* funct3 */



    always @ (posedge clk)
    begin
        #2
        case(instr[6:0])
            lw: /* rw = mem[imm + ra(x0)] */
                begin
                    /* Desabilitando escritas */
                    WeR = 0;
                    WeM = 0;


                    #1
                    Rw = instr[11:7];
                    Ra = instr[19:15];
                    soma_ou_subtrai = 1;
                    subtraindo = 0;
                    imediato = 1;
                    constanteULA = imediato_I;
                    #1
                    dinR = 171;
                    //dinR = doutM;
                    WeR = 1;
                end

            sw: /* mem[Ra + imm] = Rb */
                begin
                    /* Desabilitando escritas */
                    WeR = 0;
                    WeM = 0;

                    #1
                    Ra = instr[24:20];
                    Rb = instr[19:15];
                    soma_ou_subtrai = 1;
                    subtraindo = 0;
                    imediato = 1;
                    constanteULA = imediato_S;
                    #1
                    dinM = doutb;
                    WeM = 1;
                    
                end

            add_sub:
                begin
                    case (instr[31:25])
                        add:
                            begin
                                
                            end
                        sub:
                            begin
                                
                            end
                    endcase


                end


        endcase



    end




    BancoRegistradores RF(.Ra(Ra), .Rb(Rb), .clk(clk), .We(WeR), .din(dinR),
                         .Rw(Rw), .douta(douta), .doutb(doutb));

    MemoryData memoria(.endr(doutULA[7:3]), .We(WeM), .din(dinM), .clk(clk), .dout(doutM));

    ULA ula(.dina(douta), .dinb(doutb), .constante(constanteULA), .soma_ou_subtrai(soma_ou_subtrai),
            .subtraindo(subtraindo), .imediato(imediato), .dout(doutULA));

    

    MemoriaInstrucao instrM(.endr(doutPC[7:3]), .dout(instrTemp));

    RegistradorInstrucao instrR(.entrada(instrTemp), .saida(instr), .clk(clk));

    ImediatoI convI(.instr(instr), .saida(imediato_I));

    ImediatoJ convJ(.instr(instr), .saida(imediato_J));

    ImediatoU convU(.instr(instr), .saida(imediato_U));

    ImediatoB convB(.instr(instr), .saida(imediato_B));

    ImediatoS convS(.instr(instr), .saida(imediato_S));

    ULAPC ulapc(.din(doutPC), .constante(constantePC), .escolhe_constante(escolhe_constantePC), .dout(doutULAPC));

    ProgramCounter PC(.clk(clk), .din(doutULAPC), .dout(doutPC));


endmodule