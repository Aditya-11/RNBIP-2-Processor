//testbench for stack 
`timescale 1ns/10ps

module stack_tb;
    reg clk;
    reg [7:0] r0;
    reg  [1:0] rw;
    wire [7:0] address;

stack st1
(
    .clk (clk),
    .r0 (r0),
    .rw (rw),
    .address (address)
);

localparam period = 10;

always 
begin
#5
clk = 1'b1;
#5
clk = 1'b0;
end

initial begin
$dumpfile("stack1.vcd");
$dumpvars(1,stack_tb);
$monitor("address -> %h , rw -> %b , r0 -> %h",address,rw,r0);

#period 
rw <= 2'b00;

#period 
rw <= 2'b00;

#period 
rw <= 2'b01; 

#period
rw <= 2'b00;

#period 
rw <= 2'b01;

#period
rw <= 2'b00;

#period 
rw <= 2'b10;

#period
rw <= 2'b00;

#period 
r0 <= 8'hfa;
rw <= 2'b00;

#period
//en <= 0;
rw <= 2'b11;

#period 
rw <= 2'b10;

#period 
r0 <= 8'hef;
rw <= 2'b00;

#period 
rw <= 2'b11;

#period
rw <= 2'b01;

#period 
rw <= 2'b10;

#period 
rw <= 2'b00;

#period
rw <= 2'b10;

#period 
rw <= 2'b00;

end
endmodule



















