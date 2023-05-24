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
    jal = 350,
    jalr = 400,
    auipc = 450,
    fim = 500;

    /* Maquina de estados */
    always @ (posedge clk)
        begin
            case (estado)
                inicio:
                    estado <= auipc;
                auipc:
                    estado <= jalr;
                jalr:
                    estado <= jal;
                jal:
                    estado <= fim;


            endcase
        end

    always @ (estado)
    begin
        case(estado)
            inicio:
                begin
                    
                end

            auipc:
                begin
                    // x4 = PC + 4196
                    $display("PC eh igual a %d", doutPC);
                    Rw = 4;
                    Ra = 4;
                    #2
                    dinR = doutPC + imediato_U;
                    WeR = 1;
                    

                end

            jalr:
                begin
                    WeR = 0;
                    #1
                    // x5 = PC, PC = PC + x4 + 64
                    Rw = 5;
                    Rb = 5;
                    dinR = doutPC;
                    #2
                    WeR = 1;
                    escolhe_constantePC = 1;
                    constantePC = imediato_I + douta;
        
                    
                end

            jal:
                begin
                    $display("O valor em x4 eh %d", $signed(douta));
                    $display("O valor em x5 eh %d", $signed(doutb));
                    $display("O valor em PC eh %d", $signed(doutPC));
                    WeR = 0;
                    escolhe_constantePC = 0;
                    #1
                    //x6 = PC, PC = PC + (-)
                    Rw = 6;
                    Ra = 6;
                    dinR = doutPC;
                    #2
                    WeR = 1;
                    escolhe_constantePC = 1;
                    constantePC = imediato_J;

                end
            
            fim:
                begin
                    $display("O valor em x6 eh %d", $signed(douta));
                    $display("O valor em PC eh %d", $signed(doutPC));
                     /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória
                    escolhe_constantePC = 0;
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

    ImediatoI conv1(.instr(instr), .saida(imediato_I));

    ImediatoJ conv2(.instr(instr), .saida(imediato_J));

    ImediatoU conv3(.instr(instr), .saida(imediato_U));

    ImediatoB conv4(.instr(instr), .saida(imediato_B));

    ULAPC ulapc(.din(doutPC), .constante(constantePC), .escolhe_constante(escolhe_constantePC), .dout(doutULAPC));

    ProgramCounter PC(.clk(clk), .din(doutULAPC), .dout(doutPC));


endmodule