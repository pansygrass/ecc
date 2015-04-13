`timescale 1 ns /  100 ps

module decoder_tb();

reg [3:0] A;
wire [15:0] Z;
reg clk;

// Fake clock does nothing
decoder DUT0 (.A(A), .Z(Z), .clk(clk));

initial begin

$vcdpluson;
  A <= 4'd0;
 #`CLOCK_PERIOD A<= 4'd1;
 #`CLOCK_PERIOD A<= 4'd2;
 #`CLOCK_PERIOD A<= 4'd3;
 #`CLOCK_PERIOD A<= 4'd4;
 #`CLOCK_PERIOD A<= 4'd5;
 #`CLOCK_PERIOD A<= 4'd6;
 #`CLOCK_PERIOD A<= 4'd7;
 #`CLOCK_PERIOD A<= 4'd8;
 #`CLOCK_PERIOD A<= 4'd9;
 #`CLOCK_PERIOD A<= 4'd10;
 #`CLOCK_PERIOD A<= 4'd11;
 #`CLOCK_PERIOD A<= 4'd12;
 #`CLOCK_PERIOD A<= 4'd13;
 #`CLOCK_PERIOD A<= 4'd14;
 #`CLOCK_PERIOD A<= 4'd15;
$vcdplusoff;

end

initial begin
  $monitor($time,": A=%b, Z=%b", A, Z);
end


endmodule
