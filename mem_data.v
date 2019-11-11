`timescale 1ns / 1ps

module DataMemory(
    input   [7:0]   SP_in,
    input   [7:0]   R0_in,
    input   [7:0]   dataIn,
    output  [7:0]   dataOut,
    input           RD,
    input           WR,
    input           S2,
    input           clk
);

    reg [7:0] dataMem[255:0];
    wire [7:0] address;
    
    assign address = S2 ? SP_in : R0_in;
    assign dataOut = dataMem[address];
    
    always @(posedge clk)
    begin
        if (WR)
            dataMem[address] <= dataIn;
    end

    initial begin
        
    end
    
endmodule // DataMemory