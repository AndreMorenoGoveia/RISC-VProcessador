all: riscv exec

# Banco Registradores
Codificador = Componentes/BancoRegistradores/Codificador.v
MUX32 = Componentes/BancoRegistradores/Mux32x64bits.v
REG = Componentes/BancoRegistradores/Registrador.v
BRpartes = $(Codificador) $(MUX32) $(REG)
BR = Componentes/BancoRegistradores/BancoRegistradores.v $(BRpartes)

#ULA
SOMA = Componentes/ULA/SomadorSubtrator.v
MUXAB = Componentes/ULA/MuxAB.v
ULA = $(SOMA) $(MUXAB) Componentes/ULA/ULA.v

#MemoryData
MD = Componentes/MemoryData/MemoryData.v

#UC
UC = testbench.v

Processador = $(UC) $(BR) $(MD) $(ULA)


riscv:
	iverilog -o riscv.out $(Processador)

exec: riscv
	vvp riscv.out


clean:
	rm -f riscv riscv.vcd