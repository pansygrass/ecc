//
// decoder for Hsiaod 32 bit DEC
//
// Authors: Joseph Crowe and Matt Markwell
//


module corrector (input [38:0] IN, 
    input [6:0] SYN,
    input SGL,
    output [38:0] OUT);

wire [38:0] LOC;

    always @(*) begin
        if (SGL) begin
            LOC[0] <= SYN[0] & SYN[1] & SYN[2];
            LOC[1] <= SYN[0] & SYN[1] & SYN[3];
            LOC[2] <= SYN[0] & SYN[1] & SYN[4];
            LOC[3] <= SYN[0] & SYN[1] & SYN[5];
            LOC[4] <= SYN[0] & SYN[1] & SYN[6];
            LOC[5] <= SYN[0] & SYN[2] & SYN[3];
            LOC[6] <= SYN[0] & SYN[2] & SYN[4];
            LOC[7] <= SYN[0] & SYN[2] & SYN[5];
            LOC[8] <= SYN[0] & SYN[2] & SYN[6];
            LOC[9] <= SYN[4] & SYN[5] & SYN[6];
	    LOC[10] <= SYN[3] & SYN[5] & SYN[6];
	    LOC[11] <= SYN[2] & SYN[5] & SYN[6];
	    LOC[12] <= SYN[1] & SYN[5] & SYN[6];
	    LOC[13] <= SYN[0] & SYN[5] & SYN[6];
	    LOC[14] <= SYN[3] & SYN[4] & SYN[6];
	    LOC[15] <= SYN[2] & SYN[4] & SYN[6];
	    LOC[16] <= SYN[1] & SYN[4] & SYN[6];
	    LOC[17] <= SYN[0] & SYN[4] & SYN[6];
	    LOC[18] <= SYN[1] & SYN[2] & SYN[3];
	    LOC[19] <= SYN[2] & SYN[3] & SYN[4];
            LOC[20] <= SYN[3] & SYN[4] & SYN[5];
            LOC[21] <= SYN[1] & SYN[2] & SYN[4];
            LOC[22] <= SYN[1] & SYN[2] & SYN[5];
            LOC[23] <= SYN[1] & SYN[3] & SYN[4];
            LOC[24] <= SYN[1] & SYN[3] & SYN[5];
            LOC[25] <= SYN[1] & SYN[4] & SYN[5];
            LOC[26] <= SYN[0] & SYN[3] & SYN[6];
            LOC[27] <= SYN[0] & SYN[3] & SYN[5];
            LOC[28] <= SYN[1] & SYN[3] & SYN[6];
            LOC[29] <= SYN[0] & SYN[3] & SYN[4];
            LOC[30] <= SYN[2] & SYN[3] & SYN[6];
            LOC[31] <= SYN[2] & SYN[4] & SYN[5];
            LOC[32] <= SYN[0] & ~|SYN[6:1];
            LOC[33] <= SYN[1] & ~|SYN[6:2] & ~SYN[0];
            LOC[34] <= SYN[2] & ~|SYN[6:3] & ~|SYN[1:0];
            LOC[35] <= SYN[3] & ~|SYN[6:4] & ~|SYN[2:0];
            LOC[36] <= SYN[4] & ~|SYN[6:5] & ~|SYN[3:0];
            LOC[37] <= SYN[5] & ~|SYN[4:1] & ~SYN[6];
            LOC[38] <= SYN[6] & ~|SYN[5:1];

            OUT[0] <= LOC[0] ^ IN[0];
            OUT[1] <= LOC[1] ^ IN[1];
            OUT[2] <= LOC[2] ^ IN[2];
            OUT[3] <= LOC[3] ^ IN[3];
            OUT[4] <= LOC[4] ^ IN[4];
            OUT[5] <= LOC[5] ^ IN[5];
            OUT[6] <= LOC[6] ^ IN[6];
            OUT[7] <= LOC[7] ^ IN[7];
            OUT[8] <= LOC[8] ^ IN[8];
            OUT[9] <= LOC[9] ^ IN[9];
            OUT[10] <= LOC[10] ^ IN[10];
            OUT[11] <= LOC[11] ^ IN[11];
            OUT[12] <= LOC[12] ^ IN[12];
            OUT[13] <= LOC[13] ^ IN[13];
            OUT[14] <= LOC[14] ^ IN[14];
            OUT[15] <= LOC[15] ^ IN[15];
            OUT[16] <= LOC[16] ^ IN[16];
            OUT[17] <= LOC[17] ^ IN[17];
            OUT[18] <= LOC[18] ^ IN[18];
            OUT[19] <= LOC[19] ^ IN[19];
            OUT[20] <= LOC[20] ^ IN[20];
            OUT[21] <= LOC[21] ^ IN[21];
            OUT[22] <= LOC[22] ^ IN[22];
            OUT[23] <= LOC[23] ^ IN[23];
            OUT[24] <= LOC[24] ^ IN[24];
            OUT[25] <= LOC[25] ^ IN[25];
            OUT[26] <= LOC[26] ^ IN[26];
            OUT[27] <= LOC[27] ^ IN[27];
            OUT[28] <= LOC[28] ^ IN[28];
            OUT[29] <= LOC[29] ^ IN[29];
            OUT[30] <= LOC[30] ^ IN[30];
            OUT[31] <= LOC[31] ^ IN[31];
            OUT[32] <= LOC[32] ^ IN[32];
            OUT[33] <= LOC[33] ^ IN[33];
            OUT[34] <= LOC[34] ^ IN[34];
            OUT[35] <= LOC[35] ^ IN[35];
            OUT[36] <= LOC[36] ^ IN[36];
            OUT[37] <= LOC[37] ^ IN[37];
            OUT[38] <= LOC[38] ^ IN[38];
             
        end
        else begin
           OUT[38:0] <= IN[38:0];

        end
    end



endmodule


module sec_ded_dec_top (input [38:0] IN, 
    output reg [38:0] OUT, 
    output reg [6:0] SYN, 
    output reg ERR, SGL, DBL);

wire [6:0] C;

C[6:0] = IN[38:32]; 


    always @(*) begin
       SYN[0] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[8] ^ IN[13] ^ IN[17] ^ IN[26] ^ IN[27] ^ IN[29] ^ C[0];
       SYN[1] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[12] ^ IN[16] ^ IN[18] ^ IN[21] ^ IN[22] ^ IN[23] ^ IN[24] ^ IN[25] ^ IN[28] ^ C[1];
       SYN[2] <= IN[0] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[8] ^ IN[11] ^ IN[15] ^ IN[18] ^ IN[19] ^ IN[21] ^ IN[22] ^ IN[30] ^ IN[31] ^ C[2];
       SYN[3] <= IN[1] ^ IN[5] ^ IN[10] ^ IN[14] ^ IN[18] ^ IN[19] ^ IN[20] ^ IN[23] ^ IN[24] ^ IN[26] ^ IN[27] ^ IN[28] ^ IN[29] ^ IN[30] ^ C[3];
       SYN[4] <= IN[2] ^ IN[6] ^ IN[9] ^ IN[14] ^ IN[15] ^ IN[16] ^ IN[17] ^ IN[19] ^ IN[20] ^ IN[21] ^ IN[23] ^ IN[25] ^ IN[29] ^ IN[31] ^ C[4];
       SYN[5] <= IN[3] ^ IN[7] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[20] ^ IN[22] ^ IN[24] ^ IN[25] ^ IN[27] ^ IN[31] ^ C[5];
       SYN[6] <= IN[4] ^ IN[8] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[14] ^ IN[15] ^ IN[16] ^ IN[17] ^ IN[26] ^ IN[28] ^ IN[30] ^ C[6];
    
       ERR <= |SYN;
       SGL <= ^SYN & ERR;
       DBL <= ~^SYN & ERR;
    end

    
endmodule



