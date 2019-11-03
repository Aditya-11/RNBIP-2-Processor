`timescale 1ns / 1ps

module DataMemory(
    input [7:0] address,
    input [7:0] dataIn,
    output [7:0] dataOut,
    input RD,
    input WR,
    input clk
);

    reg [7:0] dataMem[255:0];
    
    assign dataOut = dataMem[address]; 
    
    always @(posedge clk)
    begin
        if (WR)
            dataMem[address] <= dataIn;
    end

    initial begin
        
    end
    
endmodule // DataMemory