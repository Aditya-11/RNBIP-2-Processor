// Dual port register

module dualpreg1 
(
  input  we,  
  input clr,  
  input clk,
  input [7:0] OR2,
  input [7:0] ALU_IN,
  input [1:0] mux_sel,
  input [2:0] read_seg ,
  input [2:0] write_seg,
  output reg [7:0] dataout_A,
  output reg [7:0] dataout_B
);

reg [7:0] regmemory [7:0] ;

  //WRITE  
always @(posedge clk) 
begin 

if (clr) begin
    // reset/clear the register 
    regmemory[3'b000] <= 1'b0;
    regmemory[3'b001] <= 1'b0;
    regmemory[3'b010] <= 1'b0;
    regmemory[3'b011] <= 1'b0;
    regmemory[3'b100] <= 1'b0;
    regmemory[3'b101] <= 1'b0;
    regmemory[3'b110] <= 1'b0;
    regmemory[3'b111] <= 1'b0;
end

// write into register
else if (we) begin

    if (mux_sel == 2'b00) // RN <- R0
    begin
    regmemory[write_seg] = regmemory[3'b000];
    end

    else if (mux_sel == 2'b01) // R0 <- RN 
    begin 
    regmemory[3'b000] = regmemory[write_seg];
    end

    else if (mux_sel == 2'b10) //OR2
    begin
    regmemory[write_seg] = OR2;
    end

    else if (mux_sel == 2'b11) // ALU_OUT
    begin
    regmemory[write_seg] = ALU_IN;
    end

 end
end

  //READ  
  always @(posedge clk) 
  begin 
   dataout_A <= regmemory[3'b000];
   dataout_B <= regmemory[read_seg]; 
  end

endmodule
