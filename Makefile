all: riscv exec

# Banco Registradores
Codificador = DataFlow/BancoRegistradores/Codificador.v
MUX32 = DataFlow/BancoRegistradores/Mux32x64bits.v
REG = DataFlow/BancoRegistradores/Registrador.v
BRpartes = $(Codificador) $(MUX32) $(REG)
BR = DataFlow/BancoRegistradores/BancoRegistradores.v $(BRpartes)

#ULA
SOMA = DataFlow/ULA/SomadorSubtrator.v
MUXAB = DataFlow/ULA/MuxAB.v
FLAGS = DataFlow/ULA/Flags.v
ULA = $(SOMA) $(MUXAB) $(FLAGS) DataFlow/ULA/ULA.v

#MemoryData
MD = DataFlow/MemoryData/MemoryData.v

#InstructionMemory
IR = DataFlow/MemoriaInstrucao/RegistradorInstrucao.v
CONV = DataFlow/MemoriaInstrucao/Conversor12bits64bitsCP2.v
IM = $(CONV) DataFlow/MemoriaInstrucao/MemoriaInstrucao.v 

#UC
UC = testbench.v $(IM)

Processador = $(UC) $(BR) $(MD) $(ULA)


riscv:
	iverilog -o riscv.out $(Processador)

exec: riscv
	vvp riscv.out


clean:
	rm -f riscv riscv.vcd