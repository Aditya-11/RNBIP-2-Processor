// control module of 3 stage pipelined processor
//`timescale 1ns / 1ps
// ------------------------------------ //
// CCG - 1

module CCG1
(
    input             clk,
    input   [15 : 0]  segment,
    input   [7:0]     PC_in,
    output  [7:0]     opcode_in_1,
    output  [7:0]     OR1,
    output  [7:0]     NPC_in_1
);


/*
assign opcode_in_1 = segment[15:8];
assign OR1 = segment[7:0]; 
assign NPC_in_1 = PC_in;
*/
reg [7:0] NPC;
reg [7:0] OR;
reg [7:0] opcode;

always @  (posedge clk)
begin
NPC <= PC_in;
OR <= segment[7:0];
opcode <= segment[15:8];
end

assign opcode_in_1 = opcode;
assign OR1 = OR; 
assign NPC_in_1 = NPC;

endmodule 

// -------------------------------------- //

// CCG-2
module CCG2
(
    input   clk,
    input   [7:0]  opcode_in_1,
    input   flagCheck_1,
    input   [7:0]  OR1,
    input   [7:0] NPC_in_1,
    output  [2:0] read_address,
    output  [7:0] opcode,
    output  flagCheck,
    output  [7:0] NPC_in, 
    output  [2:0] write_address,
    output   [7:0]  OR2
    
);


reg [7:0] write ;
reg [7:0] OR ;
reg [7:0] NPC ;
reg [7:0] OC;
reg [7:0] flag1;

always @ (posedge clk)
begin 
write <= opcode_in_1[2:0];
OR <= OR1;
NPC <= NPC_in_1 ;
OC <= opcode_in_1 ; 
flag1 <= flagCheck_1; 
end

assign opcode = OC;
assign flagCheck = flag1;
assign write_address = write;
assign read_address = opcode_in_1[2:0];
assign NPC_in = NPC;
assign OR2 = OR;
endmodule 

// --------------------------------------- //

// CCG 3

module CCG3
(
    input clk,
    input   [7:0]   opcode,
    input       flagCheck,
    input  [2:0]     write_address,
    input  [7:0]     NPC_in,
    input  [7:0]     OR2,
    output wire RD,  WR,             //Data Memory
    output wire L_PC,                //PC
    output wire S_AL,
    output wire S11, S10,            //MUX1 - PC
    output wire S20,                 //MUX2 - DM (address selector)
    output wire S30, S40,            //MUX3, MUX4 - ALU inputs A, B
    output wire S50,                 //MUX5 - DM (input for write)

    output wire [1:0] rw, // SP 00-> none , 01 -> push ,10 -> pop , 11 -> r0
    output wire [2:0] mux_sel, // Reg control
    output wire clr , we    // Reg  control
);

reg [10:0] controlBits;
reg [5:0] muxBits;


assign {RD, WR, clr , we , mux_sel , rw , L_PC,S_AL} = controlBits;
assign {S11, S10, S20, S30, S40, S50} = muxBits;


always @ (negedge clk)
begin
    casex (opcode)
    8'b0000_0_000 : begin           //NOP
        //controlBits <= 8'b00000000;
        controlBits <= 11'b00_00000_00_0_0;
        //muxBits <= 9'b00_0000_000;
        muxBits <= 6'b00_0000;
    end
    
    8'b0000_0_001 : begin           //CLR
        //controlBits <= 8'b00111000;
        controlBits <= 11'b00_10000_00_0_0;
        //muxBits <= 9'b00_0000_001;
       muxBits <= 6'b00_0001; 
    end

    8'b0000_0_010 : begin           //CLC
        //controlBits <= 8'b00001000;
        //controlBits <= 9'
        controlBits <= 11'b00_00000_00_0_1;
        //muxBits <= 9'b00_0000_000;
         muxBits <= 6'b00_0000;
    end

    8'b0000_0_011 : begin           //JUD_od
        //controlBits <= 8'b00000001;
         controlBits <= 11'b00_00000_00_1_0;
        //muxBits <= 9'b01_0000_000;
        muxBits <= 6'b01_0000;
    end

    8'b0000_0_100 : begin           //JUA
        //controlBits <= 8'b00000001;
         controlBits <= 11'b00_00000_00_1_0;
        //muxBits <= 9'b11_0000_000;
         muxBits <= 6'b11_0000;
    end

    8'b0000_0_101 : begin           //CUD_od
        //controlBits <= 8'b01000011;
        controlBits <= 11'b01_00000_01_1_0;
        //muxBits <= 9'b01_1000_000;
         muxBits <= 6'b01_1000;
    end
    8'b0000_0_110 : begin           //CUA
        //controlBits <= 8'b01000011;
         controlBits <= 11'b01_00000_01_1_0;
       //muxBits <= 9'b11_1000_000;
         muxBits <= 6'b11_1000;
    end
    8'b0000_0_111 : begin           //RTU
        //controlBits <= 8'b10000101;
         controlBits <= 11'b10_00000_10_1_0;
        //muxBits <= 9'b10_1000_000;
         muxBits <= 6'b10_1000;
    end
    8'b0000_1_xxx : begin           //JCD_fl_od
        if (flagCheck) begin
            //controlBits <= 8'b00000001;
             controlBits <= 11'b00_00000_00_1_0; 
             muxBits <= 6'b01_0000;
        end else begin
            //controlBits <= 8'b00000000;
             controlBits <= 11'b00_00000_00_0_0;
             muxBits <= 6'b00_0000;
        end
    end
    8'b0001_0_000 : begin           //LSP
        //controlBits <= 8'b00000110;
       controlBits <= 11'b00_00000_11_0_0;
       muxBits <= 6'b00_0000;
    end
    8'b0001_0_xxx : begin           //MVD_rn*
        //controlBits <= 8'b00010000;
        controlBits <= 11'b00_01000_00_0_0;
        muxBits <= 6'b00_0000;
    end
    8'b0001_1_000 : begin           //RSP
       //controlBits <= 8'b00100000;
         controlBits <= 11'b00_01100_00_0_0;
         muxBits <= 6'b00_0000;
    end
    8'b0001_1_xxx : begin           //MVS_rn*
        //controlBits <= 8'b00100000;
         controlBits <= 11'b00_01101_00_0_0;
         muxBits <= 6'b00_0000;
    end


    8'b0010_0_xxx : begin           //NOT_rn --
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0100;
    end


    8'b0010_1_xxx : begin           //JCA_fl
        if (flagCheck) begin
            //controlBits <= 8'b00000001;
             controlBits <= 11'b00_00000_00_1_0;
             muxBits <= 6'b11_0000;
        end else begin
             controlBits <= 11'b00_00000_00_0_0;
             muxBits <= 6'b00_0000;
        end
    end

    8'b0011_0_xxx : begin           //CCD_fl_od **
        if (flagCheck) begin
            //controlBits <= 8'b01000011;
             controlBits <= 11'b01_00000_01_1_0;
             muxBits <= 6'b01_1000;
        end else begin
             controlBits <= 11'b00_00000_00_0_0;
             muxBits <= 6'b00_0000;
        end
    end

    8'b0011_1_xxx : begin           //CCA_fl
        if (flagCheck) begin
            //controlBits <= 8'b01000011;
             controlBits <= 11'b01_00000_01_1_0;
             muxBits <= 6'b11_1000;
        end else begin
             controlBits <= 11'b00_00000_00_0_0;
             muxBits <= 6'b00_0000;
        end
    end

    8'b0100_0_xxx : begin           //INC_rn
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0100;
    end
    8'b0100_1_xxx : begin           //RTC_fl
        if (flagCheck) begin
            //controlBits <= 8'b10000101;
             controlBits <= 11'b10_00000_10_1_0;
             muxBits <= 6'b10_1000;
        end else begin
             controlBits <= 11'b00_00000_00_0_0;
             muxBits <= 6'b00_0000;
        end
    end
    8'b0101_0_xxx : begin           //DCR_rn
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_0111_00_0_1;
         muxBits <= 6'b00_0100;
    end
    8'b0101_1_xxx : begin           //MVI_rn_od
        //controlBits <= 8'b00010000;
         controlBits <= 11'b00_01010_00_0_0;
         muxBits <= 6'b00_0000;
    end
    8'b0110_0_000 : begin           //RLA
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0000;
    end
    8'b0110_0_xxx : begin           //STA_rn*
        //controlBits <= 8'b01010000;
        controlBits <= 11'b01_00000_00_0_0;
         muxBits <= 6'b00_0001;
    end
    8'b0110_1_xxx : begin           //PSH_rn
        //controlBits <= 8'b01010010;
         controlBits <= 11'b01_00000_01_0_0;
         muxBits <= 6'b00_1001;
    end
    8'b0111_0_000 : begin           //RRA
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0000;
    end
    8'b0111_0_xxx : begin           //LDA_rn*
        //controlBits <= 8'b10010000;
        //controlBits <= 9'b10010000;
         controlBits <= 11'b10_01110_00_0_0;
         muxBits <= 6'b00_0000;
    end
    8'b0111_1_xxx : begin           //POP_rn
        //controlBits <= 8'b10010100;
         controlBits <= 11'b10_01110_10_0_0;
         muxBits <= 6'b00_1000;
    end
    8'b1000_0_xxx : begin           //ADA_rn
        //controlBits <= 8'b00101000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0000;
    end
    8'b1000_1_xxx : begin           //ADI_rn_od
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0110;
    end
    8'b1001_0_xxx : begin           //SBA_rn
        //controlBits <= 8'b00101000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0000;
    end
    8'b1001_1_xxx : begin           //SBI_rn_od
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0110;
    end
    8'b1010_0_xxx : begin           //ACA_rn
        //controlBits <= 'b00101000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0000;
    end
    8'b1010_1_xxx : begin           //ACI_rn_od
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0110;
    end
    8'b1011_0_xxx : begin           //SCA_rn
        //controlBits <= 8'b00101000;
         controlBits <= 11'b00_01011_00_0_1;
         muxBits <= 6'b00_0000;
    end
    8'b1011_1_xxx : begin           //SCI_rn_od
        //controlBits <= 8'b00011000;
         controlBits <= 11'b00_01011_00_0_1;
        muxBits <= 6'b00_0110;
    end
    8'b1100_0_xxx : begin           //ANA_rn
        //controlBits <= 8'b00101000;
        controlBits <= 11'b00_01011_00_0_1;
        muxBits <=6'b00_0000;
    end
    8'b1100_1_xxx : begin           //ANI_rn_od
        //controlBits <= 8'b00011000;
        controlBits <= 11'b00_01011_00_0_1; 
        muxBits <= 6'b00_0110;
    end
    8'b1101_0_xxx : begin           //ORA_rn
        //controlBits <= 8'b00101000;
        controlBits <= 11'b00_01011_00_0_1; 
        muxBits <= 6'b00_0000;
    end
    8'b1101_1_xxx : begin           //ORI_rn_od
        //controlBits <= 8'b00011000;
        controlBits <= 11'b00_01011_00_0_1;  
        muxBits <= 6'b00_0110;
    end
    8'b1110_0_xxx : begin           //XRA_rn
        //controlBits <= 8'b00101000;
        controlBits <= 11'b00_01011_00_0_1; 
        muxBits <= 6'b00_0000;
    end
    8'b1110_1_xxx : begin           //XRI_rn_od
        //controlBits <= 8'b00011000;
        controlBits <= 11'b00_01011_00_0_1;  
        muxBits <= 6'b00_0110;
    end
    //8'b1111_0_xxx :               //INA_pn
    //8'b1111_1_xxx :               //OUT_pn
    endcase
end

endmodule // CCG2
