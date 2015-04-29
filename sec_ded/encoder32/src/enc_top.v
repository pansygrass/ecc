//
// Encoder for 32 bit SEC-DED
//
// Authors: Joseph Crowe and Matt Markwell
//

module enc_top (
    input [31:0] IN, 
    output reg [38:0] OUT,
    input clk   
);

    always @(*) begin
       OUT[31:0] <= IN[31:0];
       OUT[32] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[8] ^ IN[13] ^ IN[17] ^ IN[26] ^ IN[27] ^ IN[29];
       OUT[33] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[12] ^ IN[16] ^ IN[18] ^ IN[21] ^ IN[22] ^ IN[23] ^ IN[24] ^ IN[25] ^ IN[28];
       OUT[34] <= IN[0] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[8] ^ IN[11] ^ IN[15] ^ IN[18] ^ IN[19] ^ IN[21] ^ IN[22] ^ IN[30] ^ IN[31];
       OUT[35] <= IN[1] ^ IN[5] ^ IN[10] ^ IN[14] ^ IN[18] ^ IN[19] ^ IN[20] ^ IN[23] ^ IN[24] ^ IN[26] ^ IN[27] ^ IN[28] ^ IN[29] ^ IN[30];
       OUT[36] <= IN[2] ^ IN[6] ^ IN[9] ^ IN[14] ^ IN[15] ^ IN[16] ^ IN[17] ^ IN[19] ^ IN[20] ^ IN[21] ^ IN[23] ^ IN[25] ^ IN[29] ^ IN[31];
       OUT[37] <= IN[3] ^ IN[7] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[20] ^ IN[22] ^ IN[24] ^ IN[25] ^ IN[27] ^ IN[31];
       OUT[38] <= IN[4] ^ IN[8] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[14] ^ IN[15] ^ IN[16] ^ IN[17] ^ IN[26] ^ IN[28] ^ IN[30];
    end
endmodule


