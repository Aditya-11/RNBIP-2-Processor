`timescale 1ns / 1ps

module ProgramMemory(
    input [7:0] address,
    output [7:0] dataOC,
    output [7:0] dataOD
    //input RDP,
    //input WRP,
    //input clk
);
reg [15:0] progMem[255:0];

assign {dataOC, dataOD} = progMem[address];

endmodule // ProgramMemory