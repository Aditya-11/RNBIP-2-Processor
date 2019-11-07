//testbench for stack 
`timescale 1ns/10ps
module stack_tb;

    reg clk;
    reg rst;
    reg en;
    reg rw;
    wire [7:0] address;

stack st1(
    .clk (clk),
    .rst (rst),
    .en (en),
    .rw (rw),
    .address (address)
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
$monitor("address -> %h , en -> %b, rst -> %b, rw -> %b",address,en,rst,rw);

#period
en <= 1;
rst <= 1;

#period 
rst <= 0;

#period 
rw <= 0;

#period
en <= 0;

#period 
en <= 1;
rw <= 0;

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

#period
en <= 0;

#period 
en <= 1;
rw <= 0;

#period 
en <= 0;

#period 
en <= 1;
rw <= 0;

#period
en <= 0;

#period 
en <= 1;
rst <= 1;

#period
en <= 0;

end
endmodule




















