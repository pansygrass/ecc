`timescale 1 ns /1 ps

module enc_top_tb();

reg clk;
reg CE1;
reg OEB1;
reg CSB1;
reg [9:0] A1;
reg CE2;
reg WEB2;
reg CSB2;
reg [9:0] A2;
reg [31:0] I2;
wire [31:0] O1;

// Fake clock does nothing
enc_top DUT0 (.A1(A1), .CE1(CE1), .OEB1(OEB1), .CSB1(CSB1), .O1(O1), .A2(A2), .CE2(CE2), .WEB2(WEB2), .CSB2(CSB2), .I2(I2), .clk(clk));

initial begin

$vcdpluson;
    #`CLOCK_PERIOD CE1 <= 0;
    #`CLOCK_PERIOD CE2 <= 0;
    #`CLOCK_PERIOD A1 <= 10'd4;
    #`CLOCK_PERIOD A2 <= 10'd4;
    #`CLOCK_PERIOD CSB1 <= 1;
    #`CLOCK_PERIOD CSB2 <= 0;
    #`CLOCK_PERIOD WEB2 <= 0;
    #`CLOCK_PERIOD OEB1 <= 1;
    #`CLOCK_PERIOD I2 <= 32'd454;
    #`CLOCK_PERIOD CE2 <= 32'd1;
    #`CLOCK_PERIOD CE1 <= 0;
    #`CLOCK_PERIOD CE2 <= 0;
    #`CLOCK_PERIOD A1 <= 10'd4;
    #`CLOCK_PERIOD A2 <= 10'd4;
    #`CLOCK_PERIOD CSB1 <= 0;
    #`CLOCK_PERIOD CSB2 <= 1;
    #`CLOCK_PERIOD WEB2 <= 1;
    #`CLOCK_PERIOD OEB1 <= 0;
    #`CLOCK_PERIOD I2 <= 32'd454;
    #`CLOCK_PERIOD CE1 <= 32'd1;
    #`CLOCK_PERIOD CE1 <= 0;
    #`CLOCK_PERIOD CE2 <= 0;
    #`CLOCK_PERIOD A1 <= 10'd11;
    #`CLOCK_PERIOD A2 <= 10'd11;
    #`CLOCK_PERIOD CSB1 <= 1;
    #`CLOCK_PERIOD CSB2 <= 0;
    #`CLOCK_PERIOD WEB2 <= 0;
    #`CLOCK_PERIOD OEB1 <= 1;
    #`CLOCK_PERIOD I2 <= 32'd898;
    #`CLOCK_PERIOD CE2 <= 32'd1;
    #`CLOCK_PERIOD CE1 <= 0;
    #`CLOCK_PERIOD CE2 <= 0;
    #`CLOCK_PERIOD A1 <= 10'd11;
    #`CLOCK_PERIOD A2 <= 10'd11;
    #`CLOCK_PERIOD CSB1 <= 0;
    #`CLOCK_PERIOD CSB2 <= 1;
    #`CLOCK_PERIOD WEB2 <= 1;
    #`CLOCK_PERIOD OEB1 <= 0;
    #`CLOCK_PERIOD I2 <= 32'd898;
    #`CLOCK_PERIOD CE1 <= 32'd1;
    #`CLOCK_PERIOD CE1 <= 0;
    #`CLOCK_PERIOD CE2 <= 0;
    #`CLOCK_PERIOD A1 <= 10'd4;
    #`CLOCK_PERIOD A2 <= 10'd4;
    #`CLOCK_PERIOD CSB1 <= 0;
    #`CLOCK_PERIOD CSB2 <= 1;
    #`CLOCK_PERIOD WEB2 <= 1;
    #`CLOCK_PERIOD OEB1 <= 0;
    #`CLOCK_PERIOD I2 <= 32'd454;
    #`CLOCK_PERIOD CE1 <= 32'd1;
$vcdplusoff;

end

initial begin
    $monitor($time, ": CE1=%b, CE2=%b, A1=%b, CSB1=%b, CSB2=%b, WEB2=%b, OEB1=%b, I2=%b, O1=%b", CE1, CE2, A1, CSB1, CSB2, WEB2, OEB1, I2, O1);
end

endmodule

