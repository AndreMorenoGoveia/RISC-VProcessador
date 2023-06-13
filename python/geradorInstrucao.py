


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


# rd = mem(rs1 + const)
def lw(rd, rs1, const):
    global i
    instrucao = "32'b" + decimal_binario_12bits(const) + bin(rs1)[2:].zfill(5) + "010" + bin(rd)[2:].zfill(5) + "0000011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1



# mem(rs1 + const) = rs2
def sw(rs1, rs2, const):
    global i
    imm = decimal_binario_12bits(const)[::-1]
    instrucao = "32'b" + imm[5:12][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "010" + imm[0:5][::-1] + "0100011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1




# rd = rs1 + rs2
def add(rd, rs1, rs2):
    global i
    instrucao = "32'b" + "0000000" + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "000" + bin(rd)[2:].zfill(5) + "0110011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1


# rd = rs1 - rs2
def sub(rd, rs1, rs2):
    global i
    instrucao = "32'b" + "0100000" + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "000" + bin(rd)[2:].zfill(5) + "0110011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1



# rd = rs1 + const
def addi(rd, rs1, const):
    global i
    instrucao = "32'b" + decimal_binario_12bits(const) + bin(rs1)[2:].zfill(5) + "000" + bin(rd)[2:].zfill(5) + "0010011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1


# if(rs1 == rs2) vai para PC + const
def beq(rs1, rs2, const):
    global i
    imm = decimal_binario_13bits(const)[::-1]
    instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "000" + imm[1:5][::-1] + imm[11] + "1100011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1


# if(rs1 != rs2) vai para PC + const
def bne(rs1, rs2, const):
    global i
    imm = decimal_binario_13bits(const)[::-1]
    instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "001" + imm[1:5][::-1] + imm[11] + "1100011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1



# if(rs1 < rs2) vai para PC + const
def blt(rs1, rs2, const):
    global i
    imm = decimal_binario_13bits(const)[::-1]
    instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "001" + imm[1:5][::-1] + imm[11] + "1100011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1




# if(rs1 >= rs2) vai para PC + const
def bge(rs1, rs2, const):
    global i
    imm = decimal_binario_13bits(const)[::-1]
    instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "101" + imm[1:5][::-1] + imm[11] + "1100011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1

    

# if(rs1 < rs2) vai para PC + const
def bltu(rs1, rs2, const):
    global i
    imm = decimal_binario_13bits(const)[::-1]
    instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "110" + imm[1:5][::-1] + imm[11] + "1100011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1
     

# if(rs1 >= rs2) vai para PC + const
def bgeu(rs1, rs2, const):
    global i
    imm = decimal_binario_13bits(const)[::-1]
    instrucao = "32'b" + imm[12] + imm[5:11][::-1] + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "111" + imm[1:5][::-1] + imm[11] + "1100011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1

# rd = PC + {const, 12'b0}
def auipc(rd, const):
    global i
    imm = decimal_binario_20bits(const)
    instrucao = "32'b" + imm + bin(rd)[2:].zfill(5) + "0010111"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1

# rd = PC + 4, PC = PC + const
def jal(rd, const):
        global i
        imm = decimal_binario_21bits(const)[::-1]
        instrucao = "32'b" + imm[20] + imm[1:11][::-1] + imm[11] + imm[12:20][::-1] + bin(rd)[2:].zfill(5) + "1101111"
        print(f'memoria[{i}] <= ' + instrucao + ';')
        i+=1

# rd = PC + 4, PC = PC + rs1 + const
def jalr(rd, rs1, const):
        global i
        imm = decimal_binario_12bits(const)
        instrucao = "32'b" + imm + bin(rs1)[2:].zfill(5) + "000" + bin(rd)[2:].zfill(5) + "1100111"
        print(f'memoria[{i}] <= ' + instrucao + ';')
        i+=1

i = 0

def OR(rd, rs1, rs2):
    global i
    instrucao = "32'b" + "0000000" + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "110" + bin(rd)[2:].zfill(5) + "0110011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1

def AND(rd, rs1, rs2):
    global i
    instrucao = "32'b" + "0000000" + bin(rs2)[2:].zfill(5) + bin(rs1)[2:].zfill(5) + "111" + bin(rd)[2:].zfill(5) + "0110011"
    print(f'memoria[{i}] <= ' + instrucao + ';')
    i+=1

lw(1, 0, 0)
lw(2,0,8)
add(4,2,0)
beq(4,1,36)
beq(4,1,16)
beq(4,0,20)
addi(4,4,-1)
beq(0,0,-12)
sub(2,2,1)
beq(0,0,-28)
sub(1,1,2)
beq(0,0,-36)
sw(0,1,16)