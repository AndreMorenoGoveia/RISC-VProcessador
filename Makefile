all: riscv exec

# Banco Registradores
Codificador = DataFlow/BancoRegistradores/Codificador.v
MUX32 = DataFlow/BancoRegistradores/Mux32x64bits.v
REG = DataFlow/BancoRegistradores/Registrador.v
BRpartes = $(Codificador) $(MUX32) $(REG)
BR = DataFlow/BancoRegistradores/BancoRegistradores.v $(BRpartes)

#ULA
SOMA = DataFlow/ULA/SomadorSubtrator.v
MUXAB = DataFlow/ULA/MuxBC.v
FLAGS = DataFlow/ULA/Flags.v
ULA = $(SOMA) $(MUXAB) $(FLAGS) DataFlow/ULA/ULA.v

#MemoryData
MD = DataFlow/MemoryData/MemoryData.v

#InstructionMemory
IR = DataFlow/MemoriaInstrucao/RegistradorInstrucao.v
I = DataFlow/MemoriaInstrucao/Conversores/ImediatoI.v
J = DataFlow/MemoriaInstrucao/Conversores/ImediatoJ.v
U = DataFlow/MemoriaInstrucao/Conversores/ImediatoU.v
B = DataFlow/MemoriaInstrucao/Conversores/ImediatoB.v
CONV = $(I) $(J) $(U) $(B)
IM = $(CONV) $(IR) DataFlow/MemoriaInstrucao/MemoriaInstrucao.v 

#PC
PC = DataFlow/ProgramCounter/ProgramCounter.v DataFlow/ProgramCounter/ULAPC.v

#UC
UC = testbench.v $(IM) $(PC)

Processador = $(UC) $(BR) $(MD) $(ULA)


riscv:
	iverilog -o riscv.out $(Processador)

exec: riscv
	vvp riscv.out


clean:
	rm -f riscv riscv.vcd