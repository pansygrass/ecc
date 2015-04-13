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
            LOC[32] <= SYN[0] & ~|SYN[6:1];
            // Finish this...

            OUT[0] <= LOC[0] ^ IN[0];
            // Finish this...
             
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
       //OUT[31:0] <= IN[31:0];
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



