CC = iverilog
RUN = vvp

Dual: dualpreg1.v ./test/dualpreg1tb.v
	$(CC) -o dual dualpreg1.v ./test/dualpreg1tb.v
	$(RUN) ./dual
	
Reg:  register1.v ./test/register_tb.v
	$(CC) -o reg1 register1.v ./test/register_tb.v
	$(RUN) ./reg1

Stack: stackptr.v ./test/stack_tb.v
	$(CC) -o stack1 stackptr.v ./test/stack_tb.v
	$(RUN) ./stack1
RN2: top.v mem_prog.v FlagRegister.v Alubasic.v pipeControl_main.v dualpreg1.v stackptr.v ProgramCounter.v mem_data.v  stackptr.v
	$(CC) -o top top.v mem_prog.v FlagRegister.v Alubasic.v pipeControl_main.v dualpreg1.v stackptr.v ProgramCounter.v mem_data.v

toptb:
	$(CC) -o toptest test/top_tb.v topmodule_test.v ProgramCounter.v mem_prog.v mem_data.v ALUbasic.v FlagRegister.v dualPReg_tmt.v stackptr.v pipeControl_main.v
	$(RUN) toptest