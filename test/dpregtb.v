`timescale 1ns/10ps

module dpregtb ;
  reg      [7:0] data;       //data to be written
  reg      [2:0] read_addr;  //address for read operation
  reg     [2:0] write_addr; //address for write operation
  reg           we;         //write enable signal
  reg clk;
  wire reg [7:0] q;

  dpreg dp1
  (
   .data (data),       //data to be written
   .read_addr (read_addr),  //address for read operation
   .write_addr (write_addr), //address for write operation
   .we (we),         //write enable signal
   .clk (clk),
   .q  (q)         //read data
  );

localparam period = 10;

always begin 
# 5
clk = 1'b1;
# 5
clk = 1'b0;
end

initial begin
$dumpfile("dpregtb.vcd");
$dumpvars(1,dpregtb);
$monitor("data ->%d,read_addr-> %d,write_addr-> %d,we-> %d,q -> %d" ,data,read_addr,write_addr,we,q);

#period
data <= 8'haa;
we <= 1'b1;
write_addr <= 3'b001;

#period
read_addr <= 3'b001;

#period
data <= 8'hfe;
we <= 1'b1;
write_addr <= 3'b011;

#period
data <= 8'h0f;
we <= 1'b1;
write_addr <= 3'b101;

#period
read_addr <= 3'b001;

#period
data <= 8'h0e;
we <= 1'b1;
write_addr <= 3'b011;
read_addr <= 3'b011;

#period
data <= 8'h03;
we <= 1'b1;
write_addr <= 3'b101;
read_addr <=  3'b101;

end
endmodule




