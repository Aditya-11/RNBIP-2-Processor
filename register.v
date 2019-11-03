module register (
    input wire [1:0] enab;
    input wire [7:0] datain;
    input wire [2:0] seg ;
    output wire [7:0] dataout;
)

reg [2:0] regmemory [7:0] ;

always (@posedge clk,enab,datain)
begin 

// reset/clear the register
if (enab == 4'b00)
begin 


end

// write into register
else if (enab == 4'b01)
begin





end

// read value into register
else if (enab == 4'b002)
begin





end



end