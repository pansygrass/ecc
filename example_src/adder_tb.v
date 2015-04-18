`timescale 1 ns /  100 ps

module adder_tb();

parameter n=4;
reg [n-1:0] A;
reg [n-1:0] B;
wire [n-1:0] Sum;
wire Cout;

// Create an adder that has equally named nets connected
adder A0 (.*)

defparam adder.n = n;
initial begin
    #0 A = 4'd0;
    #1 A<= 4'd1;
    #1 A<= 4'd2;
    #1 A<= 4'd3;
    #1 A<= 4'd4;
    #1 A<= 4'd5;
    #1 A<= 4'd6;
    #1 A<= 4'd7;
    #1 A<= 4'd8;
    #1 A<= 4'd9;
    #1 A<= 4'd10;
    #1 A<= 4'd11;
    #1 A<= 4'd12;
    #1 A<= 4'd13;
    #1 A<= 4'd14;
    #1 A<= 4'd15;

end

initial begin
  $monitor($time,": A=%b, Z=%b", A, Z);
end


endmodule
