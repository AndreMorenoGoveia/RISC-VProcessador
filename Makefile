all: riscv exec

#BANCOREGISTRADORES
RF = $(REG) $(MUXCOD) Processador/DataFlow/BancoRegistradores/BancoRegistradores.v
REG = Processador/DataFlow/BancoRegistradores/Registrador.v Processador/DataFlow/BancoRegistradores/RegistradorZero.v
MUXCOD = Processador/DataFlow/BancoRegistradores/Codificador.v Processador/DataFlow/BancoRegistradores/Mux32x64bits.v

#CONVERSORESIMEDIATO
CONV = $(B) $(I) $(J) $(S) $(U) Processador/DataFlow/Conversores/Conversor.v
B = Processador/DataFlow/Conversores/ImediatoB.v
I = Processador/DataFlow/Conversores/ImediatoI.v
J = Processador/DataFlow/Conversores/ImediatoJ.v
S = Processador/DataFlow/Conversores/ImediatoS.v
U = Processador/DataFlow/Conversores/ImediatoU.v

#ULA
ULA = $(FLAGS) $(SOMA) Processador/DataFlow/ULA/ULA.v
FLAGS = Processador/DataFlow/ULA/Flags.v
SOMA = Processador/DataFlow/ULA/SomadorSubtrator.v

#PROGRAM COUNTER
PC = Processador/DataFlow/ProgramCounter/ProgramCounter.v Processador/DataFlow/ProgramCounter/ULAPC.v

# Instruction Register
IR = Processador/DataFlow/RegistradorInstrucao.v

#DATAFLOW
DF = $(RF) $(CONV) $(ULA) $(PC) $(IR) Processador/DataFlow/fd.v


# Emprestimo
DFE = fd.v
PROE = $(DFE) $(UC) Processador/polirv.v
AMBIENTEE = Ambiente.v $(PROE) $(MEM)


#UNIDADECONTROLE
UC =  Processador/UC/uc.v

#PROCESSADOR
PRO = $(DF) $(UC) Processador/polirv.v


#MEMORIA
MEM = $(IM) $(DM)  Memoria/Memoria.v
IM = Memoria/MemoriaInstrucao.v
DM = Memoria/MemoriaDados.v

AMBIENTE = Ambiente.v $(PRO) $(MEM)


# Floating Point
FP = UnidadePontoFlt/testbench.v UnidadePontoFlt/fpu.v

riscv:
	iverilog -o riscv.out $(AMBIENTE)

exec: riscv
	vvp riscv.out


clean:
	rm -f *.out *.vcd

E: riscvE execE
	

riscvE:
	iverilog -o riscvE.out $(AMBIENTEE)

execE:
	vvp riscvE.out

FP: float_cmp float_exec 

float_cmp:
	iverilog -o float_exec.out $(FP)


float_exec:
	vvp float_exec.out