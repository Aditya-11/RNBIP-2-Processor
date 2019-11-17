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

