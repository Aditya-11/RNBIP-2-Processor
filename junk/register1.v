module register1 
(
    input clk,
    input [7:0] OR2,
    input [7:0] ALU_IN,
    input [1:0] mux_sel,
    //input [2:0] reg_sel,
    input [1:0] enab,
    input [2:0] seg ,
    output [7:0] dataout_A,
    output [7:0] dataout_B

); 

reg [7:0] regmemory [7:0] ;


reg [7:0] dataout_A1 ;
reg [7:0] dataout_B1 ;

//reg [7:0] datain;

always @ *
begin 

// reset/clear the register
if (enab == 2'b00)
begin 
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
else if (enab == 2'b01)
begin

if (mux_sel == 2'b00) // RN <- R0
begin
regmemory[seg] = regmemory[3'b000];
end

else if (mux_sel == 2'b01) // R0 <- RN 

begin 
regmemory[3'b000] = regmemory[seg];
end

else if (mux_sel == 2'b10) //OR2
begin
regmemory[seg] = OR2;
end

else if (mux_sel == 2'b11) // ALU_OUT
begin
regmemory[seg] = ALU_IN;
end
end
// read value into register
else if (enab == 2'b11)
begin
dataout_A1 = regmemory[3'b000];
dataout_B1 = regmemory[seg]; 
end

end

assign dataout_A = dataout_A1 ;
assign dataout_B = dataout_B1 ;

endmodule