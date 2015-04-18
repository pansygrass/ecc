`timescale 1 ns /1 ps

module enc_top_tb();

reg [31:0] IN;
wire [38:0] OUT;
reg clk;

// Fake clock does nothing
enc_top DUT0 (.IN(IN), .OUT(OUT), .clk(clk));

initial begin

$vcdpluson;
    IN <= 32'd0;
    #`CLOCK_PERIOD IN <= 32'd1;
    #`CLOCK_PERIOD IN <= 32'd2;
    #`CLOCK_PERIOD IN <= 32'd3;
    #`CLOCK_PERIOD IN <= 32'd4;
    #`CLOCK_PERIOD IN <= 32'd5;
    #`CLOCK_PERIOD IN <= 32'd6;
    #`CLOCK_PERIOD IN <= 32'd7;
    #`CLOCK_PERIOD IN <= 32'd8;
    #`CLOCK_PERIOD IN <= 32'd9;
$vcdplusoff;

end

initial begin
    $monitor($time, ": IN=%b, OUT=%b", IN, OUT);
end

endmodule

