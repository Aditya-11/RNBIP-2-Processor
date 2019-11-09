`timescale 1ns / 1ps

module ProgramMemory(
    input [7:0] address,
    output [7:0] opcode,
    output [7:0] operand
);
reg [15:0] progMem[255:0];

initial begin
    //$readmemh("/Users/sid/Code/Verilog/Pipeline-1/program.txt",progMem);
end

assign {opcode, operand} = progMem[address];

endmodule // ProgramMemory