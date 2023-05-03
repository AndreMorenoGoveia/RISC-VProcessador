`timescale 1ns/100ps

module testbench;

    reg [4:0] Ra, Rb, Rw;
    reg WeR, WeM;
    reg clk;
    reg [63:0] dinR, dinM, constante;
    wire [63:0] douta, doutb, doutM;
    reg soma_ou_subtrai;
    reg subtraindo;
    reg [1:0] escolhe_entrada1, escolhe_entrada2;
    wire [63:0] doutULA;
    reg [10:0] estado;
    reg [4:0] endr;

    parameter A = 1, B = 0, C = 2;

    /* clock */
    always #5 clk = ~clk;

    initial 
    begin 

        $dumpfile("riscv.vcd");
        $dumpvars(0, testbench);
        estado <= inicio;
        clk <= 0;
        #10000
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
    fim = 350;

    /* Maquina de estados */
    always @ (posedge clk)
        begin
            case (estado)
                inicio:
                    begin
                        estado <= loadInicialparte1;
                    end
                loadInicialparte1:
                    begin
                        estado <= loadInicialparte2;
                    end
                loadInicialparte2:
                    begin
                        estado <= load2parte1;
                    end
 
                load2parte1:
                    begin
                        estado <= load2parte2;
                    end
                load2parte2:
                    begin
                        estado <= load3parte1;
                    end
                load3parte1:
                    begin
                        estado <= load3parte2;
                    end
                load3parte2:
                    begin
                        estado <= store1;
                    end
                store1:
                    begin
                        estado <= add1;
                    end
                add1:
                    begin
                        estado <= sub1;
                    end
                sub1:
                    begin
                        estado <= addi1;
                    end
                addi1:
                    begin
                        estado <= subi1;
                    end
                subi1:
                    begin
                        estado <= fim;
                    end


            endcase
        end

    always @ (estado)
    begin
        case(estado)
            inicio:
                begin
                    
                end
            loadInicialparte1:
                begin
                    /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    /* Carregando da memoria 0 para x0 */
                    constante = 0; // Constante para o endereço
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 0;// Declara que é uma adição
                    escolhe_entrada1 = C; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = C; // Deixa a constante na segunda entrada da ULA
                    Rw = 0; //Registrador a ser editado
                    Ra = 0; //Registrador a ser lido
                    
                end
            loadInicialparte2:
                begin
                    dinR = doutM; //Entrada registrador
                    WeR = 1; // Habilitando a escrita no registrador

                    /* Saídas da próxima instrução */
                    Rb = 0; // Saída doutb
                    Ra = 1; // Saída douta
                end
            load2parte1:
                begin
                    $display("O numero em x0 eh %d", $signed(doutb));
                    /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    /* Carregando da memória 1 (lw x1, #1(x0)) */
                    Rw = 1; // Registrador a ser escrito x1
                    constante = 1; // Constante para o endereço da memória
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 0;// Declara que é uma adição
                    escolhe_entrada1 = C; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = B; // Deixa o doutb como segunda entrada da ULA

                end

            load2parte2:
                begin
                    dinR = doutM; // Entrada do banco de registradores vinda da memória
                    WeR = 1; // Habilitando a escrita no registrador

                    /* Saídas da próxima instrução */
                    Rb = 0; // Saída doutb
                    Ra = 2; // Saída douta
                end
            
            load3parte1:
                begin
                    $display("O numero em x1 eh %d", $signed(doutM));
                    /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    /* Carregando da memória 1 (lw x1, #1(x0)) */
                    Rw = 2; // Registrador a ser escrito x1
                    constante = 2; // Constante para o endereço da memória
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 0;// Declara que é uma adição
                    escolhe_entrada1 = C; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = B; // Deixa o doutb como segunda entrada da ULA

                end

            load3parte2:
                begin
                    dinR = doutM; // Entrada do banco de registradores vinda da memória
                    WeR = 1; // Habilitando a escrita no registrador

                    /* Saídas da próxima instrução */
                    Rb = 0; // Saída doutb
                    Ra = 1; // Saída douta
                end
            
            store1:
                begin
                    $display("O numero em x2 eh %d", $signed(doutM));
                    /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    /* Carregando na memoria 5 (sw x1, #5(x0)) */
                    constante = 5; // Endereço da memória
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 0;// Declara que é uma adição
                    escolhe_entrada1 = B; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = C; // Deixa o douta como segunda entrada da ULA
                    dinM = douta; //Altera a entrada da memória
                    WeM = 1; //Habilitando a escrita na memória

                    /* Saídas da próxima instrução */
                    Ra = 1; // Saída doutb
                    Rb = 2; // Saída douta
                end
            add1:
                begin
                    $display("O numero na memoria 5 eh %d", $signed(doutM));
                    /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    escolhe_entrada1 = A; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = B; // Deixa o douta como segunda entrada da ULA
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 0;// Declara que é uma adição
                    Rw = 3;
                    #1
                    dinR = doutULA;
                    WeR = 1;
                   
                    /* Saídas da próxima instrução */
                    Ra = 1; // Saída doutb
                    Rb = 3; // Saída douta

                    
                end
            sub1:
                begin
                    
                    $display("O numero em x3 eh %d", $signed(doutb));
                    /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    escolhe_entrada1 = A; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = B; // Deixa o douta como segunda entrada da ULA
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 1;// Declara que é uma subtração
                    Rw = 4;
                    #1
                    dinR = doutULA;
                    WeR = 1;
                   
                    /* Saídas da próxima instrução */
                    Ra = 1; // Saída doutb
                    Rb = 4; // Saída douta
                    
                    
                end
            addi1:
                begin
                    $display("O numero em x4 eh %d", $signed(doutb));
                     /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    constante = 487;
                    escolhe_entrada1 = C; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = B; // Deixa o douta como segunda entrada da ULA
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 0;// Declara que é uma adição
                    Rw = 5;
                    #1
                    dinR = doutULA;
                    WeR = 1;
                   
                    /* Saídas da próxima instrução */
                    Ra = 1; // Saída doutb
                    Rb = 5; // Saída douta
                end
            subi1:
                begin
                    $display("O numero em x5 eh %d", $signed(doutb));
                     /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória

                    constante = 23;
                    escolhe_entrada1 = C; // Deixa a constante na primeira entrada da ULA
                    escolhe_entrada2 = B; // Deixa o douta como segunda entrada da ULA
                    soma_ou_subtrai = 1; // Declara que é uma adição ou uma subtração
                    subtraindo = 1;// Declara que é uma adição
                    Rw = 6;
                    #1
                    dinR = doutULA;
                    WeR = 1;
                   
                    /* Saídas da próxima instrução */
                    Ra = 1; // Saída doutb
                    Rb = 6; // Saída douta
                end
            fim:
                begin
                    $display("O numero em x6 eh %d", $signed(doutb));
                     /* Resetando os habilitadores */
                    WeR = 0; //Desabilitando a escrita no registrador
                    WeM = 0; //Desabilitando a escrita na memória
                end

        endcase



    end




    BancoRegistradores RF(.Ra(Ra), .Rb(Rb), .clk(clk), .We(WeR), .din(dinR),
                         .Rw(Rw), .douta(douta), .doutb(doutb));

    MemoryData memoria(.endr(doutULA[4:0]), .We(WeM), .din(dinM), .clk(clk), .dout(doutM));

    ULA ula(.dina(douta), .dinb(doutb), .constante(constante), .soma_ou_subtrai(soma_ou_subtrai),
            .subtraindo(subtraindo), .escolhe_entrada1(escolhe_entrada1), .escolhe_entrada2(escolhe_entrada2),
            .dout(doutULA));

    


endmodule