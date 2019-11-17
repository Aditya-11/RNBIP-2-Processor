
module dpreg 
(
  input      [7:0] data,       //data to be written
  input      [2:0] read_addr,  //address for read operation
  input      [2:0] write_addr, //address for write operation
  input            we,         //write enable signal
  input clk,
  output reg [7:0] q           //read data
);
    
  reg [7:0] ram [7:0]; // ** is exponentiation
    
  always @(posedge clk) begin //WRITE
    if (we) begin 
      ram[write_addr] <= data;
    end
  end
    
  always @(posedge clk) 
  begin //READ
    q <= ram[read_addr];
  end

endmodule