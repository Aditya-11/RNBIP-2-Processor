`timescale 1ns / 1ps

module ProgramCounter(
	input			I_PC, L_PC,
	input			S11, S10,
    input			CLK,
    input	[7:0]	OR2_in,
	input	[7:0]	R0_in,
	input	[7:0]	DM_in,
    output	[7:0]   PC_out
);

wire	[7:0]	PC_in;
reg		[7:0]	PC_reg;			// = [PC]

initial
begin
	PC_reg = 8'h00;
end

// ---- MUX 1 ----
parameter [1:0] PC_OD = 2'b01;
parameter [1:0] PC_DM = 2'b10;
parameter [1:0] PC_R0 = 2'b11;

assign PC_in =	({S11,S10}==PC_OD)	?	OR2_in	: (
				({S11,S10}==PC_DM)	?	DM_in	: (
				({S11,S10}==PC_R0)	?	R0_in	: PC_reg ));
// end MUX1

assign PC_out = PC_reg;

always @ (posedge CLK)
begin
	if (L_PC) begin
		PC_reg <= PC_in;
	end
	else if (I_PC) begin
		PC_reg <= PC_reg + 1;
	end
end

endmodule
