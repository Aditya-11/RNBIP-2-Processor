// Made by Aditya Dubey 
`timescale 1ns/10ps

module register_tb;
// inputs 
reg clk;
reg [7:0] OR2 ;
reg [7:0] ALU_IN ;
reg [2:0] mux_sel;
reg [2:0] reg_sel;
reg [1:0] enab;
reg [2:0] seg;
wire [7:0] dataout_A;
wire [7:0] dataout_B;


register1 reg1
(
    .clk (clk),
    .OR2 (OR2),
    .ALU_IN (ALU_IN),
    .mux_sel (mux_sel),
    .reg_sel (reg_sel),
    .enab (enab),
    .seg (seg),
    .dataout_A (dataout_A),
    .dataout_B (dataout_B)
); 

localparam period = 10;

always begin 
# 5
clk = 1'b1;
# 5
clk = 1'b0;
end

initial begin


$dumpfile("register.vcd");
$dumpvars(1,register_tb);
$monitor("dataout_A ->%d,dataout_B -> %d,enab -> %d,seg -> %d,mux_sel -> %d" ,dataout_A,dataout_B,enab,seg,mux_sel);

#period 
enab <= 2'b00;

#period 
enab <= 2'b11;
seg <= 3'b111;

#period // OR write
OR2 = 8'b101;
enab <= 2'b01;
mux_sel <= 3'b010;
seg <= 3'b010;

#period // read
enab <= 2'b11;
seg <= 3'b010;

#period // write 
enab <= 2'b01;
mux_sel <= 3'b001;
reg_sel <= 3'b010;
seg <= 3'b000;

#period // read
enab <= 2'b11;
seg <= 3'b010;

#period // write
enab <= 2'b01;
mux_sel <= 3'b001;
reg_sel <= 3'b010;
seg <= 3'b111;

#period 
enab <= 2'b11;
seg <= 3'b010; 

#period // ALU_IN
ALU_IN = 8'b111;
enab  <= 2'b01;
mux_sel <= 3'b011;
seg <= 3'b000;

#period 
enab <= 2'b11;
seg <= 3'b111;

end
endmodule


