`timescale 1 ns /1 ps

module enc_top_tb();

reg [126:0] IN;
wire [140:0] OUT;
reg clk;

// Fake clock does nothing
enc_top DUT0 (.IN(IN), .OUT(OUT), .clk(clk));

initial begin

$vcdpluson;
    IN <= 127'd0;
    #`CLOCK_PERIOD IN <= 127'd1;
    #`CLOCK_PERIOD IN <= 127'd2;
    #`CLOCK_PERIOD IN <= 127'd3;
    #`CLOCK_PERIOD IN <= 127'd4;
    #`CLOCK_PERIOD IN <= 127'd5;
    #`CLOCK_PERIOD IN <= 127'd6;
    #`CLOCK_PERIOD IN <= 127'd7;
    #`CLOCK_PERIOD IN <= 127'd8;
    #`CLOCK_PERIOD IN <= 127'd9;
$vcdplusoff;

end

initial begin
    $monitor($time, ": IN=%b, OUT=%b", IN, OUT);
end

endmodule

