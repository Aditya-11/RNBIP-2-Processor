`timescale 1ns / 1ps

module DataMemory(
    input   [7:0]   SP_in,
    input   [7:0]   R0_in,
    input   [7:0]   NPC_in,
    input   [7:0]   RN_in,
    output  [7:0]   dataOut,
    input           WR,
    input           S3,
    input           S2,
    input           S5,
    input           clk
);

    reg [7:0] dataMem[255:0];
    wire [7:0] address;
    wire [7:0] dataIn;

    assign address = S2 ? SP_in : R0_in;    //MUX2
    assign dataIn = S5 ? RN_in : NPC_in;    //MUX5
    assign dataOut = dataMem[address];

    always @(posedge clk)
    begin
        if (WR)
        begin
            dataMem[address] <= dataIn;
    end

endmodule // DataMemory
