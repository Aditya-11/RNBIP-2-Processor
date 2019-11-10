// Designed by Aditya Dubey
// module stack -> last in first out


// Stack starts for FF and goes till AF
// push -> stack ptr decreses by 1
// pop -> stack ptr increases by 1
// Stack depth is kept upto 80;


module stack 
(
    //input wire [3:0] dataInput,
    input wire clk,
    // input wire rst,
    input wire en,
    input wire rw,
    output reg [7:0] address
);

    //reg [3:0] stackmem [3:0];
    //initial begin 
    reg [7:0] stackptr = 8'hff; 
    //end

    integer i;

    always @ (*)
    begin 

    if (en == 0) ;

    else begin 

    /*
    if (rst == 1) 
    begin
    stackptr = 8'hff;
    address = stackptr; 
    end*/

    //else begin 

// push
    if (stackptr!= 8'haf && rw == 1'b0)
    begin 
    address = stackptr;
    stackptr = stackptr - 1;
    end

//pop
    else if (rw==1'b1 && stackptr!=8'hff) 
    begin 
    stackptr = stackptr + 1;
    address = stackptr;
    end

    //end

    end
    
    end

endmodule 

























