`timescale 1ns / 1ps

module DataMemory
(
    input           clk,
    input           WR,
    input           S20,
    input           S50,
    input   [7:0]   SP_in,
    input   [7:0]   R0_in,
    input   [7:0]   NPC_in,
    input   [7:0]   RN_in,
    output  [7:0]   dataOut
    // input           RD,
);

    reg [7:0] dataMem[255:0];
    wire [7:0] address;
    wire [7:0] dataIn;

    assign address = S20 ? SP_in : R0_in;    //MUX2
    assign dataIn = S50 ? RN_in : NPC_in;    //MUX5
    assign dataOut = dataMem[address];

    always @(posedge clk)
    begin
    if (WR)
        dataMem[address] <= dataIn;
    end

endmodule 