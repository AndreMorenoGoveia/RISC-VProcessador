

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

    upcode = "0000011"
    funct3 = "010"

    # rd = mem(rs1 + const)
    def faz_instrucao(rd, rs1, const):
        instrucao = "32'b" + decimal_binario_12bits(const) + bin(rs1)[2:].zfill(5) + loadword.funct3 + bin(rd)[2:].zfill(5) + loadword.upcode
        print(instrucao)

class storeword:

    upcode = "0100011"
    funct3 = "010"

    # mem(rs2 + const) = rs1
    def faz_instrucao(rs1, rs2, const):
        imm = decimal_binario_12bits(const)[::-1]
        instrucao = "32'b" + imm[5:12][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + storeword.funct3 + imm[0:5][::-1] + storeword.upcode
        print(instrucao)


class add:

    upcode = "0110011"
    funct3 = "000"
    funct7 = "0000000"

    # rd = rs1 + rs2
    def faz_instrucao(rd, rs1, rs2):
        instrucao = "32'b" + add.funct7 + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + add.funct3 + bin(rd)[2:].zfill(5) + add.upcode
        print(instrucao)

class sub:

    upcode = "0110011"
    funct3 = "000"
    funct7 = "0100000"

    # rd = rs1 - rs2
    def faz_instrucao(rd, rs1, rs2):
        instrucao = "32'b" + sub.funct7 + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + sub.funct3 + bin(rd)[2:].zfill(5) + sub.upcode
        print(instrucao)


class addi:

    upcode = "0010011"
    funct3 = "000"

    # rd = rs1 + const
    def faz_instrucao(rd, rs1, const):
        instrucao = "32'b" + decimal_binario_12bits(const) + bin(rs1)[2:].zfill(5) + addi.funct3 + bin(rd)[2:].zfill(5) + addi.upcode
        print(instrucao)

class beq:

    upcode = "1100011"
    funct3 = "000"

    # if(rs1 == rs2) vai para PC + const
    def faz_instrucao(rs1, rs2, const):
        imm = decimal_binario_13bits(const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + beq.funct3 + imm[1:5][::-1] + imm[11] + beq.upcode
        print(instrucao)

class bne:

    upcode = "1100011"
    funct3 = "001"

    # if(rs1 != rs2) vai para PC + const
    def faz_instrucao(rs1, rs2, const):
        imm = decimal_binario_13bits(const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + bne.funct3 + imm[1:5][::-1] + imm[11] + bne.upcode
        print(instrucao)


class blt:

    upcode = "1100011"
    funct3 = "001"


    # if(rs1 < rs2) vai para PC + const
    def faz_instrucao(rs1, rs2, const):
        imm = decimal_binario_13bits(const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + blt.funct3 + imm[1:5][::-1] + imm[11] + blt.upcode
        print(instrucao)


class bge:

    upcode = "1100011"
    funct3 = "101"


    # if(rs1 >= rs2) vai para PC + const
    def faz_instrucao(rs1, rs2, const):
        imm = decimal_binario_13bits(const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + bge.funct3 + imm[1:5][::-1] + imm[11] + bge.upcode
        print(instrucao)


class bltu:

    upcode = "1100011"
    funct3 = "110"


    # if(rs1 < rs2) vai para PC + const
    def faz_instrucao(rs1, rs2, const):
        imm = decimal_binario_13bits(const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + bltu.funct3 + imm[1:5][::-1] + imm[11] + bltu.upcode
        print(instrucao)

class bgeu:

    upcode = "1100011"
    funct3 = "111"

     # if(rs1 >= rs2) vai para PC + const
    def faz_instrucao(rs1, rs2, const):
        imm = decimal_binario_13bits(const)[::-1]
        instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + bgeu.funct3 + imm[1:5][::-1] + imm[11] + bgeu.upcode
        print(instrucao)


class auipc:

    upcode = "0010111"

    # rd = PC + {const, 12'b0}
    def faz_instrucao(rd, const):
        imm = decimal_binario_20bits(const)
        instrucao = "32'b" + imm + bin(rd)[2:].zfill(5) + auipc.upcode
        print(instrucao)

class jal:

    upcode = "1101111"

    # rd = PC + 4, PC = PC + {const, 1'b0}
    def faz_instrucao(rd, const):
        imm = decimal_binario_21bits(const)[::-1]
        instrucao = "32'b" + imm[20] + imm[1:11][::-1] + imm[11] + imm[12:20][::-1] + bin(rd)[2:].zfill(5) + jal.upcode
        print(instrucao)

class jalr:

    upcode = "1100111"
    funct3 = "000"

    # rd = PC + 4, PC = rs1 + const
    def faz_instrucao(rd, rs1, const):
        imm = decimal_binario_12bits(const)
        instrucao = "32'b" + imm + bin(rs1)[2:].zfill(5) + jalr.funct3 + bin(rd)[2:].zfill(5) + jalr.upcode
        print(instrucao)






