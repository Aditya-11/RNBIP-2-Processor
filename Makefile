CC = iverilog
RUN = vvp

Reg:  register1.v register_tb.v
	$(CC) -o reg1 register1.v register_tb.v
	$(RUN) ./reg1