

def decimal_binario_12bits(decimal):
    if decimal >= 0:
        binario = bin(decimal)[2:].zfill(12)  
    else:
        binario = bin(decimal & 0xFFF)[2:]      
    return binario

def decimal_binario_13bits(decimal):
    if decimal >= 0:
        binario = bin(decimal)[2:].zfill(13)  
    else:
        binario = bin(decimal & 0b1111111111111)[2:]      
    return binario

def decimal_binario_20bits(decimal):
    if decimal >= 0:
        binario = bin(decimal)[2:].zfill(20)  
    else:
        binario = bin(decimal & 0b11111111111111111111)[2:]      
    return binario

def decimal_binario_21bits(decimal):
    if decimal >= 0:
        binario = bin(decimal)[2:].zfill(21)  
    else:
        binario = bin(decimal & 0b111111111111111111111)[2:]      
    return binario

class loadword:

    # lw rd, #const(rs1)
    # lw x2, #2(x0)

    rd = 2
    rs1 = 0
    const = 16



    upcode = "0000011"
    funct3 = "010"


    def faz_instrucao():
        instrucao = "32'b" + decimal_binario_12bits(loadword.const) + bin(loadword.rs1)[2:].zfill(5) + loadword.funct3 + bin(loadword.rd)[2:].zfill(5) + loadword.upcode
        print(instrucao)

class storeword:

    # sw rs1, #const(rs2)
    # sw x2, #1(x0)

    rs1 = 2
    rs2 = 0
    const = 8



    upcode = "0100011"
    funct3 = "010"


    def faz_instrucao():
        imm = decimal_binario_12bits(storeword.const)[::-1]
        instrucao = "32'b" + imm[5:12][::-1] + bin(storeword.rs2)[2:].zfill(5) + bin(storeword.rs1)[2:].zfill(5) + storeword.funct3 + imm[0:5][::-1] + storeword.upcode
        print(instrucao)


class add:

    # rd = rs1 + rs2
    # add rd, rs1, rs2
    # add x1, x0, x0

    rd = 1
    rs1 = 0
    rs2 = 0



    upcode = "0110011"
    funct3 = "000"
    funct7 = "0000000"


    def faz_instrucao():
        instrucao = "32'b" + add.funct7 + bin(add.rs2)[2:].zfill(5) + bin(add.rs1)[2:].zfill(5) + add.funct3 + bin(add.rd)[2:].zfill(5) + add.upcode
        print(instrucao)

class sub:

    # rd = rs1 - rs2
    # sub rd, rs1, rs2
    # sub x4, x2, x0

    rd = 2
    rs1 = 0
    rs2 = 1



    upcode = "0110011"
    funct3 = "000"
    funct7 = "0100000"


    def faz_instrucao():
        instrucao = "32'b" + sub.funct7 + bin(sub.rs2)[2:].zfill(5) + bin(sub.rs1)[2:].zfill(5) + sub.funct3 + bin(sub.rd)[2:].zfill(5) + sub.upcode
        print(instrucao)


class addi:
    # rd = rs1 + const
    # addi rd, rs1, #const
    # addi x4, x3, #-22

    rd = 4
    rs1 = 3
    const = -22



    upcode = "0010011"
    funct3 = "000"


    def faz_instrucao():
        instrucao = "32'b" + decimal_binario_12bits(addi.const) + bin(addi.rs1)[2:].zfill(5) + addi.funct3 + bin(addi.rd)[2:].zfill(5) + addi.upcode
        print(instrucao)

class beq:
    # if(rs1 == rs2) vai para PC+64
    # beq rs1, rs2, #const
    # beq x2, x1, #8

    rs1 = 2
    rs2 = 1
    const = 8



    upcode = "1100011"
    funct3 = "000"


    def faz_instrucao():
        imm = decimal_binario_13bits(beq.const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(beq.rs2)[2:].zfill(5) + bin(beq.rs1)[2:].zfill(5) + beq.funct3 + imm[1:5][::-1] + imm[11] + beq.upcode
        print(instrucao)

class bne:
    # if(rs1 != rs2) vai para PC+64
    # bne rs1, rs2, #const
    # bne x4, x2, #8

    rs1 = 4
    rs2 = 2
    const = 12



    upcode = "1100011"
    funct3 = "001"


    def faz_instrucao():
        imm = decimal_binario_13bits(bne.const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(bne.rs2)[2:].zfill(5) + bin(bne.rs1)[2:].zfill(5) + bne.funct3 + imm[1:5][::-1] + imm[11] + bne.upcode
        print(instrucao)


class blt:
    # if(rs1 < rs2) vai para PC+64
    # blt rs1, rs2, #const
    # blt x4, x2, #64

    rs1 = 4
    rs2 = 2
    const = 16



    upcode = "1100011"
    funct3 = "001"


    def faz_instrucao():
        imm = decimal_binario_13bits(blt.const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(blt.rs2)[2:].zfill(5) + bin(blt.rs1)[2:].zfill(5) + blt.funct3 + imm[1:5][::-1] + imm[11] + blt.upcode
        print(instrucao)


class bge:
    # if(rs1 >= rs2) vai para PC+64
    # bge rs1, rs2, #const
    # bge x2, x4, #20

    rs1 = 2
    rs2 = 4
    const = 20



    upcode = "1100011"
    funct3 = "101"


    def faz_instrucao():
        imm = decimal_binario_13bits(bge.const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(bge.rs2)[2:].zfill(5) + bin(bge.rs1)[2:].zfill(5) + bge.funct3 + imm[1:5][::-1] + imm[11] + bge.upcode
        print(instrucao)


class bltu:
    # if(rs1 < rs2) vai para PC+64
    # bltu rs1, rs2, #const
    # bltu x4, x2, #64

    rs1 = 4
    rs2 = 2
    const = 64



    upcode = "1100011"
    funct3 = "110"


    def faz_instrucao():
        imm = bin(bltu.const)[2:].zfill(13)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(bltu.rs2)[2:].zfill(5) + bin(bltu.rs1)[2:].zfill(5) + bltu.funct3 + imm[1:5][::-1] + imm[11] + bltu.upcode
        print(instrucao)

class bgeu:
    # if(rs1 >= rs2) vai para PC+64
    # bgeu rs1, rs2, #const
    # bgeu x2, x1, #64

    rs1 = 2
    rs2 = 1
    const = 8



    upcode = "1100011"
    funct3 = "111"


    def faz_instrucao():
        imm = bin(bgeu.const)[2:].zfill(13)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(bgeu.rs2)[2:].zfill(5) + bin(bgeu.rs1)[2:].zfill(5) + bgeu.funct3 + imm[1:5][::-1] + imm[11] + bgeu.upcode
        print(instrucao)


class auipc:
    # rd = PC + {const, 12'b0}
    # auipc rd, #const
    # auipc x4, #1

    rd = 4
    const = 1 #8192



    upcode = "0010111"


    def faz_instrucao():
        imm = decimal_binario_20bits(auipc.const)
        instrucao = "32'b" + imm + bin(auipc.rd)[2:].zfill(5) + auipc.upcode
        print(instrucao)

class jal:
    # rd = PC + 4
    # PC = PC + {const, 1'b0}
    # jal rd, #const
    # jal x4, #64

    rd = 4
    const = -4164



    upcode = "1101111"


    def faz_instrucao():
        imm = decimal_binario_21bits(jal.const)[::-1]
        instrucao = "32'b" + imm[20] + imm[1:11][::-1] + imm[11] + imm[12:20][::-1] + bin(jal.rd)[2:].zfill(5) + jal.upcode
        print(instrucao)

class jalr:
    # rd = PC + 4
    # PC = rs1 + const
    # jalr rd, rs1, #const
    # jalr x4, x12, #64

    rd = 4
    rs1 = 12
    const = 64



    upcode = "1100111"
    funct3 = "000"


    def faz_instrucao():
        imm = decimal_binario_12bits(jalr.const)
        instrucao = "32'b" + imm + bin(jalr.rs1)[2:].zfill(5) + jalr.funct3 + bin(jalr.rd)[2:].zfill(5) + jalr.upcode
        print(instrucao)




add.faz_instrucao()
sub.faz_instrucao()

