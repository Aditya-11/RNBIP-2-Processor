`timescale 1ns / 1ps

module ProgramMemory(
    input [7:0] address,
    //output [7:0] opcode,
    output [15:0] segment
);
reg [15:0] progMem[255:0];

initial begin
    //$readmemh("instruct.txt",progMem);
    $readmemh("test/program.txt",progMem);
end

//assign {opcode, operand} = progMem[address];

assign segment = progMem[address];

endmodule // ProgramMemory