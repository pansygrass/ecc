//
// decoder for Hsiaod 64 bit DEC
//
// Authors: Joseph Crowe and Matt Markwell
//


module corrector (input [71:0] IN, 
    input [7:0] SYN,
    input SGL,
    output reg [71:0] OUT
);

reg [71:0] LOC;

    always @(*) begin
        if (SGL) begin
            LOC[0] <= SYN[0] & SYN[1] & SYN[5];
            LOC[1] <= SYN[0] & SYN[1] & SYN[6];
            LOC[2] <= SYN[0] & SYN[1] & SYN[7];
            LOC[3] <= SYN[0] & SYN[2] & SYN[3] & SYN[4] & SYN[5];
            LOC[4] <= SYN[0] & SYN[2] & SYN[6];
            LOC[5] <= SYN[0] & SYN[2] & SYN[7];
            LOC[6] <= SYN[0] & SYN[3] & SYN[7];
            LOC[7] <= SYN[0] & SYN[3] & SYN[6];
            LOC[8] <= SYN[1] & SYN[2] & SYN[6];
            LOC[9] <= SYN[1] & SYN[2] & SYN[7];
    	    LOC[10] <= SYN[0] & SYN[1] & SYN[2];
            LOC[11] <= SYN[1] & SYN[3] & SYN[4] & SYN[5] & SYN[6];
    	    LOC[12] <= SYN[1] & SYN[3] & SYN[7];
    	    LOC[13] <= SYN[0] & SYN[1] & SYN[3];
    	    LOC[14] <= SYN[0] & SYN[1] & SYN[4];
    	    LOC[15] <= SYN[1] & SYN[4] & SYN[7];
    	    LOC[16] <= SYN[2] & SYN[3] & SYN[7];
    	    LOC[17] <= SYN[0] & SYN[2] & SYN[3];
    	    LOC[18] <= SYN[1] & SYN[2] & SYN[3];
            LOC[19] <= SYN[2] & SYN[4] & SYN[5] & SYN[6] & SYN[7];
            LOC[20] <= SYN[0] & SYN[2] & SYN[4];
            LOC[21] <= SYN[1] & SYN[2] & SYN[4];
            LOC[22] <= SYN[1] & SYN[2] & SYN[5];
            LOC[23] <= SYN[0] & SYN[2] & SYN[5];
            LOC[24] <= SYN[0] & SYN[3] & SYN[4];
            LOC[25] <= SYN[1] & SYN[3] & SYN[4];
            LOC[26] <= SYN[2] & SYN[3] & SYN[4];
            LOC[27] <= SYN[0] & SYN[3] & SYN[5] & SYN[6] & SYN[7];
            LOC[28] <= SYN[1] & SYN[3] & SYN[5];
            LOC[29] <= SYN[2] & SYN[3] & SYN[5];
            LOC[30] <= SYN[2] & SYN[3] & SYN[6];
            LOC[31] <= SYN[1] & SYN[3] & SYN[6];
            LOC[32] <= SYN[1] & SYN[4] & SYN[5];
            LOC[33] <= SYN[2] & SYN[4] & SYN[5];
            LOC[34] <= SYN[3] & SYN[4] & SYN[5];
            LOC[35] <= SYN[0] & SYN[1] & SYN[4] & SYN[6] & SYN[7];
            LOC[36] <= SYN[2] & SYN[4] & SYN[6];
            LOC[37] <= SYN[3] & SYN[4] & SYN[6];
            LOC[38] <= SYN[3] & SYN[4] & SYN[7];
            LOC[39] <= SYN[2] & SYN[4] & SYN[7];
            LOC[40] <= SYN[2] & SYN[5] & SYN[6];
            LOC[41] <= SYN[3] & SYN[5] & SYN[6];
    	    LOC[42] <= SYN[4] & SYN[5] & SYN[6];
            LOC[43] <= SYN[0] & SYN[1] & SYN[2] & SYN[5] & SYN[7];
    	    LOC[44] <= SYN[3] & SYN[5] & SYN[7];
    	    LOC[45] <= SYN[4] & SYN[5] & SYN[6];
    	    LOC[46] <= SYN[0] & SYN[4] & SYN[5];
    	    LOC[47] <= SYN[0] & SYN[3] & SYN[5];
    	    LOC[48] <= SYN[3] & SYN[6] & SYN[7];
    	    LOC[49] <= SYN[4] & SYN[6] & SYN[7];
    	    LOC[50] <= SYN[5] & SYN[6] & SYN[7];
            LOC[51] <= SYN[0] & SYN[1] & SYN[2] & SYN[3] & SYN[6];
            LOC[52] <= SYN[0] & SYN[4] & SYN[6];
            LOC[53] <= SYN[0] & SYN[5] & SYN[6];
            LOC[54] <= SYN[1] & SYN[5] & SYN[6];
            LOC[55] <= SYN[1] & SYN[4] & SYN[6];
            LOC[56] <= SYN[0] & SYN[4] & SYN[7];
            LOC[57] <= SYN[0] & SYN[5] & SYN[7];
            LOC[58] <= SYN[0] & SYN[6] & SYN[7];
            LOC[59] <= SYN[1] & SYN[2] & SYN[3] & SYN[4] & SYN[7];
            LOC[60] <= SYN[1] & SYN[5] & SYN[7];
            LOC[61] <= SYN[1] & SYN[6] & SYN[7];
            LOC[62] <= SYN[2] & SYN[6] & SYN[7];
            LOC[63] <= SYN[2] & SYN[5] & SYN[7];
            LOC[64] <= SYN[0] & ~|SYN[7:1];
            LOC[65] <= SYN[1] & ~|SYN[7:2] & ~SYN[0];
            LOC[66] <= SYN[2] & ~|SYN[7:3] & ~|SYN[1:0];
            LOC[67] <= SYN[3] & ~|SYN[7:4] & ~|SYN[2:0];
            LOC[68] <= SYN[4] & ~|SYN[7:5] & ~|SYN[3:0];
            LOC[69] <= SYN[5] & ~|SYN[4:1] & ~|SYN[7:6];
            LOC[70] <= SYN[6] & ~|SYN[5:1] & ~SYN[7];
            LOC[71] <= SYN[7] & ~|SYN[6:1];


            OUT <= LOC ^ IN;
        end
        else begin
           OUT[71:0] <= IN[71:0];

        end
    end



endmodule


module dec_top (input [71:0] IN, 
    output wire [71:0] OUT, 
    output reg [7:0] SYN, 
    output reg ERR, SGL, DBL,
    input clk 
);


    wire [7:0] CHK;
    assign CHK = IN[71:64];


    always @(*) begin
       SYN[0] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[10] ^ IN[13] ^ IN[14] ^ IN[17] ^ IN[20] ^ IN[23] ^ IN[24] ^ IN[27] ^ IN[35] ^ IN[43] ^ IN[46] ^ IN[47] ^ IN[51] ^ IN[52] ^ IN[53] ^ IN[56] ^ IN[57] ^ IN[58] ^ CHK[0];
       SYN[1] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[8] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[14] ^ IN[15] ^ IN[18] ^ IN[21] ^ IN[22] ^ IN[25] ^ IN[28] ^ IN[31] ^ IN[32] ^ IN[35] ^ IN[43] ^ IN[51] ^ IN[54] ^ IN[55] ^ IN[59] ^ IN[60] ^ IN[61] ^ CHK[1];
       SYN[2] <= IN[3] ^ IN[4] ^ IN[5] ^ IN[8] ^ IN[9] ^ IN[10] ^ IN[16] ^ IN[17] ^ IN[18] ^ IN[19] ^ IN[20] ^ IN[21] ^ IN[22] ^ IN[23] ^ IN[26] ^ IN[29] ^ IN[30] ^ IN[33] ^ IN[36] ^ IN[39] ^ IN[40] ^ IN[43] ^ IN[51] ^ IN[59] ^ IN[62] ^ IN[63] ^ CHK[2];
       SYN[3] <= IN[3] ^ IN[6] ^ IN[7] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[16] ^ IN[17] ^ IN[18] ^ IN[24] ^ IN[25] ^ IN[26] ^ IN[27] ^ IN[28] ^ IN[29] ^ IN[30] ^ IN[31] ^ IN[34] ^ IN[37] ^ IN[38] ^ IN[41] ^ IN[44] ^ IN[47] ^ IN[48] ^ IN[51] ^ IN[59] ^ CHK[3];
       SYN[4] <= IN[3] ^ IN[11] ^ IN[14] ^ IN[15] ^ IN[19] ^ IN[20] ^ IN[21] ^ IN[24] ^ IN[25] ^ IN[26] ^ IN[32] ^ IN[33] ^ IN[34] ^ IN[35] ^ IN[36] ^ IN[37] ^ IN[38] ^ IN[39] ^ IN[42] ^ IN[45] ^ IN[46] ^ IN[49] ^ IN[52] ^ IN[55] ^ IN[56] ^ IN[59] ^ CHK[4];
       SYN[5] <= IN[0] ^ IN[3] ^ IN[11] ^ IN[19] ^ IN[22] ^ IN[23] ^ IN[27] ^ IN[28] ^ IN[29] ^ IN[32] ^ IN[33] ^ IN[34] ^ IN[40] ^ IN[41] ^ IN[42] ^ IN[43] ^ IN[44] ^ IN[45] ^ IN[46] ^ IN[47] ^ IN[50] ^ IN[53] ^ IN[54] ^ IN[57] ^ IN[60] ^ IN[63] ^ CHK[5];
       SYN[6] <= IN[1] ^ IN[4] ^ IN[7] ^ IN[8] ^ IN[11] ^ IN[19] ^ IN[27] ^ IN[30] ^ IN[31] ^ IN[35] ^ IN[36] ^ IN[37] ^ IN[40] ^ IN[41] ^ IN[42] ^ IN[48] ^ IN[49] ^ IN[50] ^ IN[51] ^ IN[52] ^ IN[53] ^ IN[54] ^ IN[55] ^ IN[58] ^ IN[61] ^ IN[62] ^ CHK[6];
       SYN[7] <= IN[2] ^ IN[5] ^ IN[6] ^ IN[9] ^ IN[12] ^ IN[15] ^ IN[16] ^ IN[19] ^ IN[27] ^ IN[35] ^ IN[38] ^ IN[39] ^ IN[43] ^ IN[44] ^ IN[45] ^ IN[48] ^ IN[49] ^ IN[50] ^ IN[56] ^ IN[57] ^ IN[58] ^ IN[59] ^ IN[60] ^ IN[61] ^ IN[62] ^ IN[63] ^ CHK[7];
    
       ERR <= |SYN;
       SGL <= ^SYN & ERR;
       DBL <= ~^SYN & ERR;
    end

corrector corr_mod (.IN(IN), .SYN(SYN), .SGL(SGL), .OUT(OUT));
    
endmodule



