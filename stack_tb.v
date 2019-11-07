//testbench for stack 

`timescale 1ns/10ps

module stack_tb;

    reg [3:0] dataInput;
    reg clk;
    reg rst;
    reg en;
    reg rw;
    wire [3:0] POP;
    wire [3:0] PUSH;
    wire [3:0] dataOutput;


stack st1(
    .dataInput (dataInput),
    .clk (clk),
    .rst (rst),
    .en (en),
    .rw (rw),
    .PUSH (PUSH),
    .POP (POP),
    .dataOutput (dataOutput)
);


localparam period = 5;

always 
begin
#5
clk = 1'b1;
#5 
clk = 1'b0;
end

//rw = 0 push
//rw = 1  pop

initial begin

$dumpfile("stack1.vcd");
$dumpvars(1,stack_tb);
$monitor("dataInput -> %h , dataOutput -> %h , en -> %b, rst -> %b, rw -> %b, POP -> %h , PUSH -> %h",dataInput,dataOutput,en,rst,rw,POP,PUSH);


#period
en <= 1;
rst <= 1;

#period 
rst <= 0;

#period 
rw <= 0;
dataInput <= 4'h7;

#period
en <= 0;

#period 
en <= 1;
rw <= 0;
dataInput <= 4'h8;

#period
en <= 0;

#period 
en <= 1;
rw <= 1;

#period
en <= 0;

#period 
en <= 1;
rw <= 0;
dataInput <= 4'ha;

#period
en <= 0;

#period 
en <= 1;
rw <= 1;


end
endmodule




















