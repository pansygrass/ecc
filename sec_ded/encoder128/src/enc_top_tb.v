`timescale 1 ns /1 ps

module enc_top_tb();

reg [127:0] IN;
wire [136:0] OUT;
reg clk;

// Fake clock does nothing
enc_top DUT0 (.IN(IN), .OUT(OUT), .clk(clk));

initial begin

$vcdpluson;
    IN <= 128'd0;
    #`CLOCK_PERIOD IN <= 128'd1;
    #`CLOCK_PERIOD IN <= 128'd2;
    #`CLOCK_PERIOD IN <= 128'd3;
    #`CLOCK_PERIOD IN <= 128'd4;
    #`CLOCK_PERIOD IN <= 128'd5;
    #`CLOCK_PERIOD IN <= 128'd6;
    #`CLOCK_PERIOD IN <= 128'd7;
    #`CLOCK_PERIOD IN <= 128'd8;
    #`CLOCK_PERIOD IN <= 128'd9;
$vcdplusoff;

end

initial begin
    $monitor($time, ": IN=%b, OUT=%b", IN, OUT);
end

endmodule

