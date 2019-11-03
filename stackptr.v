// Designed by Aditya Dubey
// module stack -> last in first out

module stack 
(
    input wire [3:0] dataInput,
    input wire clk ,
    input wire rst ,
    input wire en ,
    input wire rw,
    // rw == 0 // push
    // rw == 1 // pop
    output reg [3:0] POP,
    output reg [3:0] PUSH,
    output reg [3:0] dataOutput
);

    reg [3:0] stackmem [3:0];
    reg [3:0] stackptr; 
    integer i;

    always @ (posedge clk, dataInput ,rst , en ,rw)
    begin 

    if (en == 0) ;

    else begin 

    if (rst == 1) 
    begin
    stackptr = 4'd4;
    PUSH = 4'h0;
    POP = 4'h0;
    dataOutput = 4'h0; 
    end

    else if (rst == 0) begin 

    if (stackptr!=0 && rw == 1'b0)
    begin // push
    dataOutput = 4'd0;
    stackptr = stackptr - 1;
    stackmem[stackptr] = dataInput;
    POP = 0;
    PUSH = stackmem[stackptr];
    //$display("PUSH -> %d ",PUSH); 
    end

//pop
    else if (rw==1'b1 && stackptr!=4'd4) 
    begin 
    //assign dataInput = 4'h0;
    dataOutput = stackmem[stackptr];
    PUSH = 0;
    POP = stackmem[stackptr];
    stackmem[stackptr] = 0;
    stackptr = stackptr + 1;
    //$display("POP -> %d ",POP); 
    end

    end

    end
    end

endmodule 

























