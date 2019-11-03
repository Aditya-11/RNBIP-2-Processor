module register 
(
    input wire [7:0] OR2;
    input wire [7:0] ALU_IN;
    input wire [2:0] mux_sel;
    input wire [2:0] reg_sel;
    input wire [1:0] enab;
    input wire [2:0] seg ;
    output wire [7:0] dataout_A;
    output wire [7:0] dataout_B;
)

reg [2:0] regmemory [7:0] ;

wire [7:0] datain;


always (@posedge clk,enab,datain)
begin 

// reset/clear the register
if (enab == 4'b00)
begin 
assign regmemory[3'b000] <= 1'b0;
assign regmemory[3'b001] <= 1'b0;
assign regmemory[3'b010] <= 1'b0;
assign regmemory[3'b011] <= 1'b0;
assign regmemory[3'b100] <= 1'b0;
assign regmemory[3'b101] <= 1'b0;
assign regmemory[3'b110] <= 1'b0;
assign regmemory[3'b111] <= 1'b1;
end

// write into register
else if (enab == 4'b01)
begin

if (mux_sel == 3'b000) // R0
begin
assign datain = regmemory[3'b000];
end

else if (mux_sel == 3'b001) // RN 

begin 
assign datain = regmemory[reg_sel];
end

else if (mux_sel == 3'b010) //OR2
begin
assign datain = OR2;
end

else if (mux_sel == 3'b011) // ALU_OUT
begin
assign datain = ALU_IN;
end

assign regmemory[seg] = datain;

end

// read value into register
else if (enab == 4'b002)
begin
assign dataout_A = regmemory[3'b000];
assign dataout_B = regmemory[seg]; 
end

end