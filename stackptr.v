// Designed by Aditya Dubey
// module stack -> last in first out


// Stack starts for FF and goes till AF
// push -> stack ptr decreses by 1
// pop -> stack ptr increases by 1
// Stack depth is kept upto 80;

module stack 
(
    input wire clk,    
    input wire [7:0] r0,
    input wire [1:0] rw,
    output wire [7:0] address
);
    reg [7:0] stackptr = 8'hff; 

    assign address = stackptr;

    always @ (posedge clk )
    begin 
// disable stack

    if (rw == 2'b00) ;

// push
    else if (stackptr!= 8'haf && rw == 2'b01)
    begin 
    stackptr <= stackptr - 1;
    end
//pop
    else if (rw==2'b10 && stackptr!=8'hff) 
    begin 
    stackptr <= stackptr + 1;
    end
// take r0 value
    else if (rw == 2'b11)
    begin
    stackptr <= r0;
    end
    end

endmodule 

























