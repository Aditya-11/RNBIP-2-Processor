`timescale 1ns/10ps

module dualpreg1tb ;
  reg we;
  reg clr;
  reg clk;
  reg [7:0] OR2;
  reg [7:0] A_in;
  reg [7:0] B_in;
  reg [7:0] ALU_IN;
  reg [1:0] mux_sel;
  reg [2:0] read_seg;
  reg [2:0] write_seg;
  wire reg [7:0] dataout_A;
  wire reg [7:0] dataout_B;

dualpreg1 dual11
(
  .we (we),  
  .clr (clr),  
  .clk (clk),
  .OR2 (OR2),
  .A_in (A_in),
  .B_in (B_in),
  .ALU_IN (ALU_IN),
  .mux_sel (mux_sel),
  .read_seg (read_seg),
  .write_seg (write_seg),
  .dataout_A (dataout_A),
  .dataout_B (dataout_B)
);

always begin 
# 5
clk = 1'b1;
# 5
clk = 1'b0;
end

localparam period = 10;
// clock 

initial begin 
$dumpfile("dualreg1tb.vcd");
$dumpvars(1,dual11);
$monitor("read_seg ->%d, write_seg -> %d,dataout_A-> %d,dataout_B -> %d,clr -> %d" ,read_seg,write_seg,dataout_A,dataout_B,clr);

#period 
clr <= 1;
ALU_IN <= 8'haf;

#period
clr <= 0; 
we <= 1;
mux_sel <= 2'b11;
write_seg <= 3'b001;
OR2 <= 8'hfe;

#period
we <= 1;
mux_sel <= 2'b10;
write_seg <= 3'b000;
A_in <= 8'hcf;

#period
we <= 1;
read_seg <= 3'b001;
mux_sel <= 2'b00;
write_seg <= 3'b001;
OR2 <= 8'hab;

#period
we <= 1;
read_seg <= 3'b001;
mux_sel <= 2'b10;
write_seg <= 3'b001;
B_in <= 8'hcc;

#period
we <= 1;
mux_sel <= 2'b01;
write_seg <= 3'b010;
read_seg <=3'b010;

#period
we <= 1;
mux_sel <= 2'b1;
write_seg <= 3'b010;
read_seg <=3'b010;

end

endmodule