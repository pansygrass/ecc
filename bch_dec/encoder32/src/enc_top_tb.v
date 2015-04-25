`timescale 1 ns /1 ps

module enc_top_tb();

reg [30:0] IN;
wire [40:0] OUT;
reg clk;

// Fake clock does nothing
enc_top DUT0 (.IN(IN), .OUT(OUT), .clk(clk));

initial begin

$vcdpluson;
    IN <= 31'd0;
    #`CLOCK_PERIOD IN <= 32'd1979398776;
    #`CLOCK_PERIOD IN <= 32'd1010226197;
    #`CLOCK_PERIOD IN <= 32'd3597602390;
    #`CLOCK_PERIOD IN <= 32'd1658316396;
    #`CLOCK_PERIOD IN <= 32'd3482235205;
    #`CLOCK_PERIOD IN <= 32'd4270230797;
    #`CLOCK_PERIOD IN <= 32'd2855215760;
    #`CLOCK_PERIOD IN <= 32'd374275781 ;
    #`CLOCK_PERIOD IN <= 32'd56948382  ;
    #`CLOCK_PERIOD IN <= 32'd1429955813;
$vcdplusoff;

end

initial begin
    $monitor($time, ": IN=%b, OUT=%b", IN, OUT);
end

endmodule

