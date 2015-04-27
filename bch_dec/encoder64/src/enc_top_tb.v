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
    #`CLOCK_PERIOD IN <= 63'd1280925896923972120;
    #`CLOCK_PERIOD IN <= 63'd3295280805934658495;
    #`CLOCK_PERIOD IN <= 63'd7216476017601297585;
    #`CLOCK_PERIOD IN <= 63'd5646662884424516485;
    #`CLOCK_PERIOD IN <= 63'd4835103080255084189;
    #`CLOCK_PERIOD IN <= 63'd6333147455735857710;
    #`CLOCK_PERIOD IN <= 63'd7685903850733424221;
    #`CLOCK_PERIOD IN <= 63'd4051759383644011499;
    #`CLOCK_PERIOD IN <= 63'd7855677469739239448;
$vcdplusoff;

end

initial begin
    $monitor($time, ": IN=%b, OUT=%b", IN, OUT);
end

endmodule

