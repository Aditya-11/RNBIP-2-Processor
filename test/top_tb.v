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

always #200 clk = ~clk;
always #4000000 $stop;

endmodule // top_test