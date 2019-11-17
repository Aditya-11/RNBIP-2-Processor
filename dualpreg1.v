// Dual port register

module dualpreg1 
(
  input  we,  
  input clr,  
  input clk,
  input [7:0] OR2,
  input [7:0] A_in ,
  input [7:0] B_in ,
  input [7:0] ALU_IN,
  input [7:0] SP,
  input [7:0] mem,
  input [2:0] mux_sel,
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

    if (mux_sel == 3'b000) // RN <- A
    begin
    regmemory[write_seg] = A_in;
    end

    else if (mux_sel == 3'b001) // RN <- B
    begin 
    regmemory[write_seg] = B_in;
    end

    else if (mux_sel == 3'b010) //OR2
    begin
    regmemory[write_seg] = OR2;
    end

    else if (mux_sel == 3'b011) // ALU_OUT
    begin
    regmemory[write_seg] = ALU_IN;
    end

    else if (mux_sel == 3'b100) // [R0] <- [SP]
    begin 
    regmemory [3'b000] = SP ;
    end

    else if (mux_sel == 3'b101) // R0 <= B 
    begin
    regmemory[3'b000] = B_in;
    end

    else if (mux_sel == 3'b110) // RN <- mem
    begin
    regmemory[write_seg] = mem;
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
