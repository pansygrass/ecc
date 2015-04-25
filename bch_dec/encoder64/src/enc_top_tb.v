`timescale 1 ns /1 ps

module enc_top_tb();

reg [62:0] IN;
wire [74:0] OUT;
reg clk;

// Fake clock does nothing
enc_top DUT0 (.IN(IN), .OUT(OUT), .clk(clk));

initial begin

$vcdpluson;
    IN <= 63'd0;
    #`CLOCK_PERIOD IN <= 63'd1;
    #`CLOCK_PERIOD IN <= 63'd2;
    #`CLOCK_PERIOD IN <= 63'd3;
    #`CLOCK_PERIOD IN <= 63'd4;
    #`CLOCK_PERIOD IN <= 63'd5;
    #`CLOCK_PERIOD IN <= 63'd6;
    #`CLOCK_PERIOD IN <= 63'd7;
    #`CLOCK_PERIOD IN <= 63'd8;
    #`CLOCK_PERIOD IN <= 63'd9;
$vcdplusoff;

end

initial begin
    $monitor($time, ": IN=%b, OUT=%b", IN, OUT);
end

endmodule

