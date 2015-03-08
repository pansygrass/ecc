module decoder(
  input [3:0] A,
  output [15:0] Z,
  input clk
);

	
// Only one output should ever be high.  For example,
// Z[2] = !A[3] & !A[2] & A[1] & !A[0], etc

// Hint: a 2 to 1 mux looks like:
// assign y = (sel) ? b : a;
// And you can replace "a" with a further condition
// assign y = (sel1) ? c
//          : (sel2) ? b
//          : a
// and sel1 can be a condition like:
// A == 4'd0

assign Z = (A == 4'd0)  ? 16'b0000000000000001
         : (A == 4'd1)  ? 16'b0000000000000010 
         : (A == 4'd2)  ? 16'b0000000000000100 
         : (A == 4'd3)  ? 16'b0000000000001000
         : (A == 4'd4)  ? 16'b0000000000010000
         : (A == 4'd5)  ? 16'b0000000000100000
         : (A == 4'd6)  ? 16'b0000000001000000
         : (A == 4'd7)  ? 16'b0000000010000000
         : (A == 4'd8)  ? 16'b0000000100000000
         : (A == 4'd9)  ? 16'b0000001000000000
         : (A == 4'd10) ? 16'b0000010000000000
         : (A == 4'd11) ? 16'b0000100000000000
         : (A == 4'd12) ? 16'b0001000000000000
         : (A == 4'd13) ? 16'b0010000000000000
         : (A == 4'd14) ? 16'b0100000000000000
         :                16'b1000000000000000;
         
endmodule





