`timescale 1 ns /1 ps

module enc_top_tb();

reg [63:0] IN;
wire [71:0] OUT;
reg clk;

// Fake clock does nothing
enc_top DUT0 (.IN(IN), .OUT(OUT), .clk(clk));

initial begin

$vcdpluson;
    IN <= 64'd0;
    #`CLOCK_PERIOD IN <= 64'd1280925896923972120;
    #`CLOCK_PERIOD IN <= 64'd3295280805934658495;
    #`CLOCK_PERIOD IN <= 64'd7216476017601297585;
    #`CLOCK_PERIOD IN <= 64'd5646662884424516485;
    #`CLOCK_PERIOD IN <= 64'd4835103080255084189;
    #`CLOCK_PERIOD IN <= 64'd6333147455735857710;
    #`CLOCK_PERIOD IN <= 64'd7685903850733424221;
    #`CLOCK_PERIOD IN <= 64'd4051759383644011499;
    #`CLOCK_PERIOD IN <= 64'd7855677469739239448;
$vcdplusoff;

end

initial begin
    $monitor($time, ": IN=%b, OUT=%b", IN, OUT);
end

endmodule

