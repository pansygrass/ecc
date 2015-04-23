//
// Encoder for Hsiaod 32 bit DEC
//
// Authors: Joseph Crowe and Matt Markwell
//


module enc_top (
    input [30:0] IN, 
    output reg [40:0] OUT,
    input clk   
);

    always @(*) begin
        OUT[30:0] <= IN[30:0];
		OUT[31] <= IN[0]^ IN[1]^ IN[3]^ IN[5]^ IN[7]^ IN[8]^ IN[9]^ IN[10]^ IN[13]^ IN[16]^ IN[18]^ IN[21];
		OUT[32] <= IN[1]^ IN[2]^ IN[4]^ IN[6]^ IN[8]^ IN[9]^ IN[10]^ IN[11]^ IN[14]^ IN[17]^ IN[19]^ IN[22];
		OUT[33] <= IN[2]^ IN[3]^ IN[5]^ IN[7]^ IN[9]^ IN[10]^ IN[11]^ IN[12]^ IN[15]^ IN[18]^ IN[20]^ IN[23];
		OUT[34] <= IN[0]^ IN[1]^ IN[4]^ IN[5]^ IN[6]^ IN[7]^ IN[9]^ IN[11]^ IN[12]^ IN[18]^ IN[19]^ IN[24];
		OUT[35] <= IN[1]^ IN[2]^ IN[5]^ IN[6]^ IN[7]^ IN[8]^ IN[10]^ IN[12]^ IN[13]^ IN[19]^ IN[20]^ IN[25];
		OUT[36] <= IN[0]^ IN[1]^ IN[2]^ IN[5]^ IN[6]^ IN[10]^ IN[11]^ IN[14]^	IN[16]^ IN[18]^ IN[20]^ IN[26];
		OUT[37] <= IN[0]^ IN[2]^ IN[5]^ IN[6]^ IN[8]^ IN[9]^ IN[10]^ IN[11]^ IN[12]^ IN[13]^ IN[15]^ IN[16]^ IN[17]^ IN[18]^ IN[19]^ IN[27];
		OUT[38] <= IN[1]^ IN[3]^ IN[6]^ IN[7]^ IN[9]^ IN[10]^ IN[11]^ IN[12]^ IN[13]^ IN[14]^ IN[16]^ IN[17]^ IN[18]^ IN[19]^ IN[20]^ IN[28];
		OUT[39] <= IN[0]^ IN[1]^ IN[2]^ IN[3]^ IN[4]^ IN[5]^ IN[9]^ IN[11]^ IN[12]^ IN[14]^ IN[15]^	IN[16]^ IN[17]^ IN[19]^ IN[20]^ IN[29];
		OUT[40] <= IN[0]^ IN[2]^ IN[4]^ IN[6]^ IN[7]^ IN[8]^ IN[9]^ IN[12]^ IN[15]^	IN[17]^ IN[20]^ IN[30];

    end
endmodule


