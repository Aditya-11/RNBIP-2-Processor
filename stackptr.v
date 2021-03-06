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

    //assign address = stackptr;
    assign address = rw[1] ? stackptr+1 : stackptr;

    always @ (posedge clk)
    begin 
// disable stack
/*
    if (rw == 2'b00) stackptr <= stackptr;

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
    */

    case (rw)
    2'b00 :stackptr <= stackptr;
    2'b01 :stackptr <= stackptr - 1;
    2'b10 :stackptr <= stackptr + 1;
    2'b11 :stackptr <= r0;
    endcase
    end
endmodule