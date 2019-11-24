`timescale 1ns / 1ps

module top_test();

reg clk;

Topmodule mytop(
    .clk(clk)
);

initial begin
    $dumpfile("toptest.vcd");
    $dumpvars(0,top_test);
    clk = 1'b0;
end

always #10 clk = ~clk;
always #400 $stop;

endmodule // top_test