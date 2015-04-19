//
// decoder for Hsiaod 32 bit DEC
//
// Authors: Joseph Crowe and Matt Markwell
//


module corrector (input [38:0] IN, 
    input [6:0] SYN,
    output reg [38:0] OUT
);

reg [38:0] LOC;

    always @(*) begin
       case (SYN)
           7'b0000111: LOC <= 39'h00_0000_0001; 
           7'b0001011: LOC <= 39'h00_0000_0002;
           7'b0010011: LOC <= 39'h00_0000_0004;
           7'b0100011: LOC <= 39'h00_0000_0008;
           7'b1000011: LOC <= 39'h00_0000_0010;
           7'b0001101: LOC <= 39'h00_0000_0020;
           7'b0010101: LOC <= 39'h00_0000_0040;
           7'b0100101: LOC <= 39'h00_0000_0080;
           7'b1000101: LOC <= 39'h00_0000_0100;
           7'b1110000: LOC <= 39'h00_0000_0200;
           7'b1101000: LOC <= 39'h00_0000_0400;
           7'b1100100: LOC <= 39'h00_0000_0800;
           7'b1100010: LOC <= 39'h00_0000_1000;
           7'b1100001: LOC <= 39'h00_0000_2000;
           7'b1011000: LOC <= 39'h00_0000_4000;
           7'b1010100: LOC <= 39'h00_0000_8000;
           7'b1010010: LOC <= 39'h00_0001_0000;
           7'b1010001: LOC <= 39'h00_0002_0000;
           7'b0001110: LOC <= 39'h00_0004_0000;
           7'b0011100: LOC <= 39'h00_0008_0000;
           7'b0111000: LOC <= 39'h00_0010_0000;
           7'b0010110: LOC <= 39'h00_0020_0000;
           7'b0100110: LOC <= 39'h00_0040_0000;
           7'b0011010: LOC <= 39'h00_0080_0000;
           7'b0101010: LOC <= 39'h00_0100_0000;
           7'b0110010: LOC <= 39'h00_0200_0000;
           7'b1001001: LOC <= 39'h00_0400_0000;
           7'b0101001: LOC <= 39'h00_0800_0000;
           7'b1001010: LOC <= 39'h00_1000_0000;
           7'b0011001: LOC <= 39'h00_2000_0000;
           7'b1001100: LOC <= 39'h00_4000_0000;
           7'b0110100: LOC <= 39'h00_8000_0000;
           7'b0000001: LOC <= 39'h01_0000_0000;
           7'b0000010: LOC <= 39'h02_0000_0000;
           7'b0000100: LOC <= 39'h04_0000_0000;
           7'b0001000: LOC <= 39'h08_0000_0000;
           7'b0010000: LOC <= 39'h10_0000_0000;
           7'b0100000: LOC <= 39'h20_0000_0000;
           7'b1000000: LOC <= 39'h40_0000_0000; 
           default: LOC <= 0;
        endcase
       OUT <= LOC ^ IN;
    end
endmodule


module dec_top (input [38:0] IN, 
    output wire [38:0] OUT, 
    output reg [6:0] SYN, 
    output reg ERR, SGL, DBL,
    input clk 
);


    wire [6:0] CHK;
    assign CHK = IN[38:32];


    always @(*) begin
       SYN[0] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[8] ^ IN[13] ^ IN[17] ^ IN[26] ^ IN[27] ^ IN[29] ^ CHK[0];
       SYN[1] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[12] ^ IN[16] ^ IN[18] ^ IN[21] ^ IN[22] ^ IN[23] ^ IN[24] ^ IN[25] ^ IN[28] ^ CHK[1];
       SYN[2] <= IN[0] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[8] ^ IN[11] ^ IN[15] ^ IN[18] ^ IN[19] ^ IN[21] ^ IN[22] ^ IN[30] ^ IN[31] ^ CHK[2];
       SYN[3] <= IN[1] ^ IN[5] ^ IN[10] ^ IN[14] ^ IN[18] ^ IN[19] ^ IN[20] ^ IN[23] ^ IN[24] ^ IN[26] ^ IN[27] ^ IN[28] ^ IN[29] ^ IN[30] ^ CHK[3];
       SYN[4] <= IN[2] ^ IN[6] ^ IN[9] ^ IN[14] ^ IN[15] ^ IN[16] ^ IN[17] ^ IN[19] ^ IN[20] ^ IN[21] ^ IN[23] ^ IN[25] ^ IN[29] ^ IN[31] ^ CHK[4];
       SYN[5] <= IN[3] ^ IN[7] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[20] ^ IN[22] ^ IN[24] ^ IN[25] ^ IN[27] ^ IN[31] ^ CHK[5];
       SYN[6] <= IN[4] ^ IN[8] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[14] ^ IN[15] ^ IN[16] ^ IN[17] ^ IN[26] ^ IN[28] ^ IN[30] ^ CHK[6];
    
       ERR <= |SYN;
       SGL <= ^SYN & ERR;
       DBL <= ~^SYN & ERR;
    end

corrector corr_mod (.IN(IN), .SYN(SYN), .OUT(OUT));
    
endmodule



