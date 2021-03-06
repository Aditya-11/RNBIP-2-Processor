// 3 stage pipelined processor implementation
// top module
`timescale 1ns / 1ps

module Topmodule
   (
   input   clk//,
   );

wire [7:0] R0, R1, R2, R3, R4, R5, R6, R7;

    //CC1
    wire  [15:0] segment;
    wire           FL;
    wire  [7:0]    opcode_in_1;
    wire  [7:0]    NPC_in_1;
    wire           flagCheck_1;
    wire  [7:0]    OR1;

    // ------------------------------
    // CC2 
    wire [7:0] NPC_in;
    wire [2:0] read_address;
    wire [2:0] write_address;
    wire [7:0] opcode;
    wire flagCheck;
    wire [7:0] OR2;
    // ------------------------------ //
    //CC3
    wire RD,  WR;            //Data Memory
    wire I_PC , L_PC;              //PC
    wire  S_AL;  // Flag register
    wire S11, S10;           //MUX1 - PC
    wire S20;                 //MUX2 - DM (address selector)
    wire S30, S40;            //MUX3, MUX4 - ALU inputs A, B
    wire S50;                 //MUX5 - DM (input for write)

    wire [1:0] rw; // SP 00-> none , 01 -> push ,10 -> pop , 11 -> r0
    wire [2:0] mux_sel; // Reg control
    wire clr , we;   // Reg  control
    // --------------------------------- //
// ALU 
	wire [7:0]   Out;           // Output 8 bit
	wire [3:0]   flagArray;     // not holding only driving EDI
	wire Cin;          // Carry input bit
// register Array 
    wire [2:0] seg;
    wire [7:0] dataout_A;
    wire [7:0] dataout_B;
// memeory data
    wire  [7:0]   dataOut ;
// stack ptr
    wire [7:0] address;
// PC
    wire	[7:0]   PC_out;

// Flag Register
    wire  [2:0]   OC_fl;
    wire     carry ;
 //   wire     FL    ;

// end of wires for i/os and control signal

    assign I_PC = 1'b1 ;

    reg [7:0] A_in;
    reg [7:0] B_in;
    wire [7:0] A;
    wire [7:0] B;

    reg  [7:0] Out2;
    wire [7:0] Out1;

    assign Out1 = Out;

    assign A = dataout_A;
    assign B = dataout_B;

// modules 

// PC
ProgramCounter modPC
(
    .CLK (clk),
	.I_PC (I_PC), 
    .L_PC  (L_PC),
	.S11 (S11),
    .S10 (S10),
    .OR2_in (OR2),
	.R0_in (A),
	.DM_in (dataOut),
    .PC_out (PC_out)
);

//control units
    CCG1    mod1
    (
    .clk        (clk),
    .segment (segment),
    .PC_in        (PC_out),
    .opcode_in_1 (opcode_in_1),
    .OR1        (OR1),
    .NPC_in_1   (NPC_in_1) 
    );

    CCG2     mod2 
    (
    .clk   (clk),
    .opcode_in_1 (opcode_in_1),
    .flagCheck_1 (FL), 
    .OR1 (OR1),
    .NPC_in_1 (NPC_in_1),
    .read_address (read_address),
    .opcode (opcode),
    .flagCheck (flagCheck),
    .NPC_in (NPC_in), 
    .write_address (write_address),
    .OR2 (OR2)
    );

    CCG3     mod3 
    (
    .clk (clk),   
    .opcode (opcode),
    .flagCheck (flagCheck),
    .write_address (write_address),
    .NPC_in (NPC_in),
    .OR2 (OR2),
    .RD(RD),  
    .WR (WR),             
    .L_PC (L_PC), 
    .S_AL (S_AL),               
    .S11  (S11), 
    .S10 (S10),            
    .S20 (S20),                 
    .S30 (S30), 
    .S40 (S40),            
    .S50 (S50),                 
    .rw (rw), 
    .mux_sel (mux_sel), 
    .clr (clr), 
    .we (we)
    );

// Register

dualpreg_tm_test modRA
(
  .clk (clk),  
  .we (we),  
  .clr (clr),  
  .OR2 (OR2),
  .A_in (A),
  .B_in (B),
  .ALU_IN (Out1),
  .SP (address),
  .mem (dataOut),
  .mux_sel (mux_sel),
  .read_seg (read_address),
  .write_seg (write_address),
  .dataout_A (dataout_A),
  .dataout_B (dataout_B),
  .R0(R0),
  .R1(R1),
  .R2(R2),
  .R3(R3),
  .R4(R4),
  .R5(R5),
  .R6(R6),
  .R7(R7)
);

// memory 

// ALU 

ALUbasic modALU
(
	.Out (Out),           // Output 8 bit
	.flagArray (flagArray),     // not holding only driving EDI
	.Cin (Cin),          // Carry input bit
	.A_IN_0 (A),
	.B_IN_0 (B),     // 8-bit data input
    .OR2 (OR2),   
	.S_AF (opcode[7:4]),  
    //.S_AF (alubits), 
    .S30 (S30),
    .S40 (S40)
 );

// stackptr 

stack modSP
(
    .clk(clk),    
    .r0 (A),
    .rw (rw),
    .address (address)
);

// flag register

FlagRegister modFR
(
    .clk (clk),
    .OC_fl (opcode_in_1[2:0]), 
    .inArray (flagArray),
    .S_AL (S_AL),
    .carry (Cin),
    .FL     (FL)
);

ProgramMemory modPM
(
    .address (PC_out),
    .segment (segment)
);


DataMemory modDM
(
    .clk (clk),
    .WR (WR),
    .S20 (S20),
    .S50 (S50),
    .SP_in (address),
    .R0_in (A),
    .NPC_in (NPC_in),
    .RN_in (B),
    .dataOut (dataOut)
    // input           RD,
);

endmodule