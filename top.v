`timescale 1ns / 1ps

module Topmodule(
    input   clk,
    output  [15:0] led
	);

// wires for control signel 

// stackptr
wire [1:0] rw ;
// PC
wire  L_PC , I_PC ;
wire  S11 , S10;
// Reg 
wire [1:0] enab ;
wire [2:0] reg_sel;
wire [1:0] mux_sel ;
// IR
wire L_IR;
//FlagReg
wire S_AL;
// ALU
wire [3:0] 	S_AF;    // Most significant 4 bits of the op code
wire sel_b;
wire sel_a;

//pipe Control 

//



// end of wires for control signal 

























































































































