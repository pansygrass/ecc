`timescale 1 ns /100 ps

module dec_32_tb();

reg [38:0] IN;
wire [38:0] OUT;
wire [38:0] FINOUT;
wire [6:0] SYN;
wire ERR, SGL, DBL;

sec_ded_dec_top DUT0 (.IN(IN), .OUT(OUT), .SYN(SYN), .ERR(ERR), .SGL(SGL), .DBL(DBL));
corrector DUT1 (.IN(OUT), .SYN(SYN), .SGL(SGL), .OUT(FINOUT));
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
    $monitor($time, ": IN=%b, OUT=%b, FINOUT=%b, ERR=%b, SGL=%b, DBL=%b", IN, OUT, FINOUT, ERR, SGL, DBL);
end

endmodule

