module adder(A, B, Sum, Cout);
parameter n=4;

input [n-1:0] A;
input [n-1:0] B;
output [n-1:0] Sum;
output Cout;

wire [n:0] Result;

assign Result = A + B;
assign Sum = Result[n-1:0];
assign Cout = Result[n];

endmodule





