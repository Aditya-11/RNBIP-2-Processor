`timescale 1ns / 1ps

module Topmodule(
    input   clk,
    output  [15:0] led
	);

// wires for control signel 

// stackptr
wire [1:0] rw;
// PC
wire  L_PC , I_PC ;
wire  S11 , S10;
// Reg 
wire [1:0] enab;
wire [1:0] mux_sel;
// IR
wire L_IR;
//FlagReg
wire S_AL;
// ALU
wire [3:0] 	S_AF;    // Most significant 4 bits of the op code
wire sel_b;
wire sel_a;

//pipe Control 

// mem_data
wire    RD;
wire    WR;
wire    S5;
wire    S2;
// end of wires for control signal 

// i/os 

// ALU 
	wire [7:0]   Out;           // Output 8 bit
	wire [3:0]   flagArray;     // not holding only driving EDI
	wire Cin;          // Carry input bit
	wire [7:0] 	A_IN_0;
	wire [7:0]  B_IN_0;     // 8-bit data input
    wire [7:0]  OR2;   

//  Flag Reg
    wire [2:0]   OC_fl; //From IR
    wire [3:0]   inArray; //From ALU
    wire carry;  //Output to ALU
    wire FL;      //Output to Control Code Generator

// register Array 
    wire [7:0] OR2;
    wire [7:0] ALU_IN;
    wire [2:0] seg;
    wire [7:0] dataout_A;
    wire [7:0] dataout_B;

// memeory data
    wire    [7:0]   SP_in;
    wire    [7:0]   R0_in;
    wire    [7:0]   NPC;
    wire    [7:0]   R_N; 
    wire    [7:0]   dataOut;

// stack ptr
    input wire [7:0] r0,
    input wire [1:0] rw,
    output wire [7:0] address

// IR 
    wire     [7:0] PM_in,
    wire     [7:0] OC_ou

// PC
    wire	[7:0]	OR2_in,
	wire	[7:0]	R0_in,
	wire	[7:0]	DM_in,
    wire	[7:0]   PC_out

// end of i/os





























































































