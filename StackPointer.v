`timescale 1ns / 1ps

module StackPointer(
input			I_SP,
input			D_SP,
input			clk,
input	[7:0]   R0_in,
output	[7:0]	SP_address
);

reg [7:0] SP_reg;

initial SP_reg = 8'hFF;

assign SP_address = I_SP ? (SP_reg+1) : SP_reg;

always @(posedge clk)
begin
	case({I_SP,D_SP})
	2'b00:	SP_reg <= SP_reg;	// No Stack operation
	2'b10:	SP_reg <= SP_reg+1;	// I_SP = 1 
	2'b01:	SP_reg <= SP_reg-1;	// D_SP = 1
    2'b11: 	SP_reg <= R0_in;
	endcase
end                                         

endmodule