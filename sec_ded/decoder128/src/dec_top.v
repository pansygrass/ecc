//
// decoder for Hsiao 128 bit SEC-DED
//
// Authors: Joseph Crowe and Matt Markwell
//


module corrector (input [136:0] IN, 
    input [8:0] SYN,
    output reg [136:0] OUT
);

reg [136:0] LOC;

    always @(*) begin
        case(SYN)
            9'b111000000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0001; 
            9'b110100000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0002;
            9'b011100000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0004;
            9'b101100000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0008;
            9'b011010000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0010;
            9'b101010000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0020;
            9'b110010000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0040;
            9'b010110000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0080;
            9'b100110000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0100;
            9'b001110000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0200;
            9'b011001000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0400;
            9'b101001000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_0800;
            9'b110001000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_1000;
            9'b100101000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_2000;
            9'b010101000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_4000;
            9'b001101000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0000_8000;
            9'b010011000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0001_0000;
            9'b100011000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0002_0000;
            9'b001011000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0004_0000;
            9'b000111000: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0008_0000;
            9'b011000100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0010_0000;
            9'b101000100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0020_0000;
            9'b110000100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0040_0000;
            9'b100100100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0080_0000;
            9'b010100100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0100_0000;
            9'b001100100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0200_0000;
            9'b001010100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0400_0000;
            9'b010010100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_0800_0000;
            9'b100010100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_1000_0000;
            9'b000110100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_2000_0000;
            9'b001001100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_4000_0000;
            9'b010001100: LOC <= 137'h000_0000_0000_0000_0000_0000_0000_8000_0000;
            9'b100001100: LOC <= 137'h000_0000_0000_0000_0000_0000_0001_0000_0000;
            9'b000101100: LOC <= 137'h000_0000_0000_0000_0000_0000_0002_0000_0000;
            9'b000011100: LOC <= 137'h000_0000_0000_0000_0000_0000_0004_0000_0000;
            9'b100100010: LOC <= 137'h000_0000_0000_0000_0000_0000_0008_0000_0000;
            9'b010100010: LOC <= 137'h000_0000_0000_0000_0000_0000_0010_0000_0000;
            9'b001100010: LOC <= 137'h000_0000_0000_0000_0000_0000_0020_0000_0000;
            9'b011000010: LOC <= 137'h000_0000_0000_0000_0000_0000_0040_0000_0000;
            9'b101000010: LOC <= 137'h000_0000_0000_0000_0000_0000_0080_0000_0000;
            9'b110000010: LOC <= 137'h000_0000_0000_0000_0000_0000_0100_0000_0000;
            9'b000110010: LOC <= 137'h000_0000_0000_0000_0000_0000_0200_0000_0000;
            9'b010010010: LOC <= 137'h000_0000_0000_0000_0000_0000_0400_0000_0000;
            9'b100010010: LOC <= 137'h000_0000_0000_0000_0000_0000_0800_0000_0000;
            9'b001010010: LOC <= 137'h000_0000_0000_0000_0000_0000_1000_0000_0000;
            9'b100001010: LOC <= 137'h000_0000_0000_0000_0000_0000_2000_0000_0000;
            9'b010001010: LOC <= 137'h000_0000_0000_0000_0000_0000_4000_0000_0000;
            9'b001001010: LOC <= 137'h000_0000_0000_0000_0000_0000_8000_0000_0000;
            9'b000101010: LOC <= 137'h000_0000_0000_0000_0000_0001_0000_0000_0000;
            9'b000011010: LOC <= 137'h000_0000_0000_0000_0000_0002_0000_0000_0000;
            9'b010000110: LOC <= 137'h000_0000_0000_0000_0000_0004_0000_0000_0000;
            9'b100000110: LOC <= 137'h000_0000_0000_0000_0000_0008_0000_0000_0000;
            9'b001000110: LOC <= 137'h000_0000_0000_0000_0000_0010_0000_0000_0000;
            9'b000100110: LOC <= 137'h000_0000_0000_0000_0000_0020_0000_0000_0000;
            9'b000010110: LOC <= 137'h000_0000_0000_0000_0000_0040_0000_0000_0000;
            9'b000001110: LOC <= 137'h000_0000_0000_0000_0000_0080_0000_0000_0000;
            9'b110000001: LOC <= 137'h000_0000_0000_0000_0000_0100_0000_0000_0000;
            9'b101000001: LOC <= 137'h000_0000_0000_0000_0000_0200_0000_0000_0000;
            9'b011000001: LOC <= 137'h000_0000_0000_0000_0000_0400_0000_0000_0000;
            9'b100100001: LOC <= 137'h000_0000_0000_0000_0000_0800_0000_0000_0000;
            9'b010100001: LOC <= 137'h000_0000_0000_0000_0000_1000_0000_0000_0000;
            9'b001100001: LOC <= 137'h000_0000_0000_0000_0000_2000_0000_0000_0000;
            9'b100010001: LOC <= 137'h000_0000_0000_0000_0000_4000_0000_0000_0000;
            9'b010010001: LOC <= 137'h000_0000_0000_0000_0000_8000_0000_0000_0000;
            9'b001010001: LOC <= 137'h000_0000_0000_0000_0001_0000_0000_0000_0000;
            9'b000110001: LOC <= 137'h000_0000_0000_0000_0002_0000_0000_0000_0000;
            9'b010001001: LOC <= 137'h000_0000_0000_0000_0004_0000_0000_0000_0000;
            9'b100001001: LOC <= 137'h000_0000_0000_0000_0008_0000_0000_0000_0000;
            9'b001001001: LOC <= 137'h000_0000_0000_0000_0010_0000_0000_0000_0000;
            9'b000101001: LOC <= 137'h000_0000_0000_0000_0020_0000_0000_0000_0000;
            9'b000011001: LOC <= 137'h000_0000_0000_0000_0040_0000_0000_0000_0000;
            9'b010000101: LOC <= 137'h000_0000_0000_0000_0080_0000_0000_0000_0000;
            9'b100000101: LOC <= 137'h000_0000_0000_0000_0100_0000_0000_0000_0000;
            9'b001000101: LOC <= 137'h000_0000_0000_0000_0200_0000_0000_0000_0000;
            9'b000100101: LOC <= 137'h000_0000_0000_0000_0400_0000_0000_0000_0000;
            9'b000010101: LOC <= 137'h000_0000_0000_0000_0800_0000_0000_0000_0000;
            9'b000001101: LOC <= 137'h000_0000_0000_0000_1000_0000_0000_0000_0000;
            9'b000100011: LOC <= 137'h000_0000_0000_0000_2000_0000_0000_0000_0000;
            9'b001000011: LOC <= 137'h000_0000_0000_0000_4000_0000_0000_0000_0000;
            9'b100000011: LOC <= 137'h000_0000_0000_0000_8000_0000_0000_0000_0000;
            9'b010000011: LOC <= 137'h000_0000_0000_0001_0000_0000_0000_0000_0000;
            9'b000010011: LOC <= 137'h000_0000_0000_0002_0000_0000_0000_0000_0000;
            9'b000001011: LOC <= 137'h000_0000_0000_0004_0000_0000_0000_0000_0000;
            9'b000000111: LOC <= 137'h000_0000_0000_0008_0000_0000_0000_0000_0000;
            9'b000011111: LOC <= 137'h000_0000_0000_0010_0000_0000_0000_0000_0000;
            9'b000101111: LOC <= 137'h000_0000_0000_0020_0000_0000_0000_0000_0000;
            9'b001001111: LOC <= 137'h000_0000_0000_0040_0000_0000_0000_0000_0000;
            9'b010001111: LOC <= 137'h000_0000_0000_0080_0000_0000_0000_0000_0000;
            9'b100001111: LOC <= 137'h000_0000_0000_0100_0000_0000_0000_0000_0000;
            9'b111110000: LOC <= 137'h000_0000_0000_0200_0000_0000_0000_0000_0000;
            9'b111101000: LOC <= 137'h000_0000_0000_0400_0000_0000_0000_0000_0000;
            9'b111100100: LOC <= 137'h000_0000_0000_0800_0000_0000_0000_0000_0000;
            9'b111100010: LOC <= 137'h000_0000_0000_1000_0000_0000_0000_0000_0000;
            9'b111100001: LOC <= 137'h000_0000_0000_2000_0000_0000_0000_0000_0000;
            9'b001111100: LOC <= 137'h000_0000_0000_4000_0000_0000_0000_0000_0000;
            9'b001111010: LOC <= 137'h000_0000_0000_8000_0000_0000_0000_0000_0000;
            9'b001111001: LOC <= 137'h000_0000_0001_0000_0000_0000_0000_0000_0000;
            9'b010111100: LOC <= 137'h000_0000_0002_0000_0000_0000_0000_0000_0000;
            9'b100111100: LOC <= 137'h000_0000_0004_0000_0000_0000_0000_0000_0000;
            9'b000110111: LOC <= 137'h000_0000_0008_0000_0000_0000_0000_0000_0000;
            9'b001010111: LOC <= 137'h000_0000_0010_0000_0000_0000_0000_0000_0000;
            9'b010010111: LOC <= 137'h000_0000_0020_0000_0000_0000_0000_0000_0000;
            9'b100010111: LOC <= 137'h000_0000_0040_0000_0000_0000_0000_0000_0000;
            9'b111011000: LOC <= 137'h000_0000_0080_0000_0000_0000_0000_0000_0000;
            9'b111010100: LOC <= 137'h000_0000_0100_0000_0000_0000_0000_0000_0000;
            9'b111010010: LOC <= 137'h000_0000_0200_0000_0000_0000_0000_0000_0000;
            9'b111010001: LOC <= 137'h000_0000_0400_0000_0000_0000_0000_0000_0000;
            9'b110000111: LOC <= 137'h000_0000_0800_0000_0000_0000_0000_0000_0000;
            9'b110001011: LOC <= 137'h000_0000_1000_0000_0000_0000_0000_0000_0000;
            9'b110010011: LOC <= 137'h000_0000_2000_0000_0000_0000_0000_0000_0000;
            9'b110100011: LOC <= 137'h000_0000_4000_0000_0000_0000_0000_0000_0000;
            9'b111000011: LOC <= 137'h000_0000_8000_0000_0000_0000_0000_0000_0000;
            9'b011101100: LOC <= 137'h000_0001_0000_0000_0000_0000_0000_0000_0000;
            9'b101101100: LOC <= 137'h000_0002_0000_0000_0000_0000_0000_0000_0000;
            9'b001101110: LOC <= 137'h000_0004_0000_0000_0000_0000_0000_0000_0000;
            9'b001101101: LOC <= 137'h000_0008_0000_0000_0000_0000_0000_0000_0000;
            9'b101100101: LOC <= 137'h000_0010_0000_0000_0000_0000_0000_0000_0000;
            9'b101010101: LOC <= 137'h000_0020_0000_0000_0000_0000_0000_0000_0000;
            9'b101001101: LOC <= 137'h000_0040_0000_0000_0000_0000_0000_0000_0000;
            9'b110011010: LOC <= 137'h000_0080_0000_0000_0000_0000_0000_0000_0000;
            9'b011011010: LOC <= 137'h000_0100_0000_0000_0000_0000_0000_0000_0000;
            9'b010111010: LOC <= 137'h000_0200_0000_0000_0000_0000_0000_0000_0000;
            9'b010110110: LOC <= 137'h000_0400_0000_0000_0000_0000_0000_0000_0000;
            9'b010110011: LOC <= 137'h000_0800_0000_0000_0000_0000_0000_0000_0000;
            9'b100101101: LOC <= 137'h000_1000_0000_0000_0000_0000_0000_0000_0000;
            9'b101101001: LOC <= 137'h000_2000_0000_0000_0000_0000_0000_0000_0000;
            9'b110010110: LOC <= 137'h000_4000_0000_0000_0000_0000_0000_0000_0000;
            9'b010111010: LOC <= 137'h000_8000_0000_0000_0000_0000_0000_0000_0000;
            9'b000000001: LOC <= 137'h001_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b000000010: LOC <= 137'h002_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b000000100: LOC <= 137'h004_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b000001000: LOC <= 137'h008_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b000010000: LOC <= 137'h010_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b000100000: LOC <= 137'h020_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b001000000: LOC <= 137'h040_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b010000000: LOC <= 137'h080_0000_0000_0000_0000_0000_0000_0000_0000;
            9'b100000000: LOC <= 137'h100_0000_0000_0000_0000_0000_0000_0000_0000;
            default: LOC <= 0;
        endcase
        OUT <= LOC ^ IN;
    end
endmodule


module dec_top (input [136:0] IN, 
    output wire [136:0] OUT, 
    output reg [8:0] SYN, 
    output reg ERR, SGL, DBL,
    input clk 
);


    wire [8:0] CHK;
    assign CHK = IN[136:128];


    always @(*) begin


        SYN[0] <= IN[56] ^ IN[57] ^ IN[58] ^ IN[59] ^ IN[60] ^ IN[61] ^ IN[62] ^ IN[63] ^ IN[64] ^
                    IN[65] ^ IN[66] ^ IN[67] ^ IN[68] ^ IN[69] ^ IN[70] ^ IN[71] ^ IN[72] ^ IN[73] ^ 
                    IN[74] ^ IN[75] ^ IN[76] ^ IN[77] ^ IN[78] ^ IN[79] ^ IN[80] ^ IN[81] ^ IN[82] ^ 
                    IN[83] ^ IN[84] ^ IN[85] ^ IN[86] ^ IN[87] ^ IN[88] ^ IN[93] ^ IN[96] ^ IN[99] ^ 
                    IN[100] ^ IN[101] ^ IN[102] ^ IN[106] ^ IN[107] ^ IN[108] ^ IN[109] ^ IN[110] ^ 
                    IN[111] ^ IN[115] ^ IN[116] ^ IN[117] ^ IN[118] ^ IN[123] ^ IN[124] ^ IN[125] ^ CHK[0];
        
        SYN[1] <= IN[35] ^ IN[36] ^ IN[37] ^ IN[38] ^ IN[39] ^ IN[40] ^ IN[41] ^ IN[42] ^ IN[43] ^ 
                    IN[44] ^ IN[45] ^ IN[46] ^ IN[47] ^ IN[48] ^ IN[49] ^ IN[50] ^ IN[51] ^ IN[52] ^ 
                    IN[53] ^ IN[54] ^ IN[55] ^ IN[77] ^ IN[78] ^ IN[79] ^ IN[80] ^ IN[81] ^ IN[82] ^ 
                    IN[83] ^ IN[84] ^ IN[85] ^ IN[86] ^ IN[87] ^ IN[88] ^ IN[92] ^ IN[95] ^ IN[99] ^ 
                    IN[100] ^ IN[101] ^ IN[102] ^ IN[105] ^ IN[107] ^ IN[108] ^ IN[109] ^ IN[110] ^ 
                    IN[111] ^ IN[114] ^ IN[119] ^ IN[120] ^ IN[121] ^ IN[122] ^ IN[123] ^ IN[126] ^ IN[127] ^ CHK[1];


        SYN[2] <= IN[20] ^ IN[21] ^ IN[22] ^ IN[23] ^ IN[24] ^ IN[25] ^ IN[26] ^ IN[27] ^ IN[28] ^ 
                    IN[29] ^ IN[30] ^ IN[31] ^ IN[32] ^ IN[33] ^ IN[34] ^ IN[50] ^ IN[51] ^ IN[52] ^ 
                    IN[53] ^ IN[54] ^ IN[55] ^ IN[71] ^ IN[72] ^ IN[73] ^ IN[74] ^ IN[75] ^ IN[76] ^ 
                    IN[83] ^ IN[84] ^ IN[85] ^ IN[86] ^ IN[87] ^ IN[88] ^ IN[91] ^ IN[94] ^ IN[97] ^ 
                    IN[98] ^ IN[99] ^ IN[100] ^ IN[101] ^ IN[102] ^ IN[104] ^ IN[107] ^ IN[112] ^ 
                    IN[113] ^ IN[114] ^ IN[115] ^ IN[116] ^ IN[117] ^ IN[118] ^ IN[122] ^ IN[124] ^ IN[126] ^ CHK[2];


        SYN[3] <= IN[10] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[14] ^ IN[15] ^ IN[16] ^ IN[17] ^ IN[18] ^ 
                    IN[19] ^ IN[30] ^ IN[31] ^ IN[32] ^ IN[33] ^ IN[34] ^ IN[45] ^ IN[46] ^ IN[47] ^ 
                    IN[48] ^ IN[49] ^ IN[55] ^ IN[66] ^ IN[67] ^ IN[68] ^ IN[69] ^ IN[70] ^ IN[76] ^ 
                    IN[82] ^ IN[84] ^ IN[85] ^ IN[86] ^ IN[87] ^ IN[88] ^ IN[90] ^ IN[94] ^ IN[95] ^ 
                    IN[96] ^ IN[97] ^ IN[98] ^ IN[103] ^ IN[108] ^ IN[112] ^ IN[113] ^ IN[114] ^ 
                    IN[115] ^ IN[118] ^ IN[119] ^ IN[120] ^ IN[121] ^ IN[124] ^ IN[125] ^ IN[127] ^ CHK[3];
 
        SYN[4] <= IN[4] ^ IN[5] ^ IN[6] ^ IN[7] ^ IN[8] ^ IN[9] ^ IN[16] ^ IN[17] ^ IN[18] ^ IN[19] ^ 
                    IN[26] ^ IN[27] ^ IN[28] ^ IN[29] ^ IN[34] ^ IN[41] ^ IN[42] ^ IN[43] ^ IN[44] ^ 
                    IN[49] ^ IN[54] ^ IN[62] ^ IN[63] ^ IN[64] ^ IN[65] ^ IN[70] ^ IN[75] ^ IN[81] ^ 
                    IN[84] ^ IN[89] ^ IN[94] ^ IN[95] ^ IN[96] ^ IN[97] ^ IN[98] ^ IN[99] ^ IN[100] ^ 
                    IN[101] ^ IN[102] ^ IN[103] ^ IN[104] ^ IN[105] ^ IN[106] ^ IN[109] ^ IN[117] ^ 
                    IN[119] ^ IN[120] ^ IN[121] ^ IN[122] ^ IN[123] ^ IN[126] ^ IN[127] ^ CHK[4];

        SYN[5] <= IN[1] ^ IN[2] ^ IN[3] ^ IN[7] ^ IN[8] ^ IN[9] ^ IN[13] ^ IN[14] ^ IN[15] ^ IN[19] ^ 
                    IN[23] ^ IN[24] ^ IN[25] ^ IN[29] ^ IN[33] ^ IN[35] ^ IN[36] ^ IN[37] ^ IN[41] ^ 
                    IN[48] ^ IN[53] ^ IN[59] ^ IN[60] ^ IN[61] ^ IN[65] ^ IN[69] ^ IN[74] ^ IN[77] ^ 
                    IN[85] ^ IN[89] ^ IN[90] ^ IN[91] ^ IN[92] ^ IN[93] ^ IN[94] ^ IN[95] ^ IN[96] ^ 
                    IN[97] ^ IN[98] ^ IN[99] ^ IN[110] ^ IN[112] ^ IN[113] ^ IN[114] ^ IN[115] ^ 
                    IN[116] ^ IN[121] ^ IN[122] ^ IN[123] ^ IN[124] ^ IN[125] ^ IN[127] ^ CHK[5];

        SYN[6] <= IN[0] ^ IN[2] ^ IN[3] ^ IN[4] ^ IN[5] ^ IN[9] ^ IN[10] ^ IN[11] ^ IN[15] ^ IN[18] ^ 
                    IN[20] ^ IN[21] ^ IN[25] ^ IN[26] ^ IN[30] ^ IN[37] ^ IN[38] ^ IN[39] ^ IN[44] ^ 
                    IN[47] ^ IN[52] ^ IN[57] ^ IN[58] ^ IN[61] ^ IN[64] ^ IN[68] ^ IN[73] ^ IN[78] ^ 
                    IN[86] ^ IN[89] ^ IN[90] ^ IN[91] ^ IN[92] ^ IN[93] ^ IN[94] ^ IN[95] ^ IN[96] ^ 
                    IN[100] ^ IN[103] ^ IN[104] ^ IN[105] ^ IN[106] ^ IN[111] ^ IN[112] ^ IN[113] ^ 
                    IN[114] ^ IN[115] ^ IN[116] ^ IN[117] ^ IN[118] ^ IN[120] ^ IN[125] ^ CHK[6];

        SYN[7] <= IN[0] ^ IN[1] ^ IN[2] ^ IN[4] ^ IN[6] ^ IN[7] ^ IN[10] ^ IN[12] ^ IN[14] ^ IN[16] ^ 
                    IN[20] ^ IN[22] ^ IN[24] ^ IN[27] ^ IN[31] ^ IN[36] ^ IN[38] ^ IN[40] ^ IN[42] ^ 
                    IN[46] ^ IN[50] ^ IN[56] ^ IN[58] ^ IN[60] ^ IN[63] ^ IN[66] ^ IN[71] ^ IN[80] ^ 
                    IN[87] ^ IN[89] ^ IN[90] ^ IN[91] ^ IN[92] ^ IN[93] ^ IN[97] ^ IN[101] ^ IN[103] ^ 
                    IN[104] ^ IN[105] ^ IN[106] ^ IN[107] ^ IN[108] ^ IN[109] ^ IN[110] ^ IN[111] ^ 
                    IN[112] ^ IN[119] ^ IN[120] ^ IN[121] ^ IN[122] ^ IN[123] ^ IN[126] ^ IN[127] ^ CHK[7];

        SYN[8] <= IN[0] ^ IN[1] ^ IN[3] ^ IN[5] ^ IN[6] ^ IN[8] ^ IN[11] ^ IN[12] ^ IN[13] ^ IN[17] ^ 
                    IN[21] ^ IN[22] ^ IN[23] ^ IN[28] ^ IN[32] ^ IN[35] ^ IN[39] ^ IN[40] ^ IN[43] ^ 
                    IN[45] ^ IN[51] ^ IN[56] ^ IN[57] ^ IN[59] ^ IN[62] ^ IN[67] ^ IN[72] ^ IN[79] ^ 
                    IN[88] ^ IN[89] ^ IN[90] ^ IN[91] ^ IN[92] ^ IN[93] ^ IN[98] ^ IN[102] ^ IN[103] ^ 
                    IN[104] ^ IN[105] ^ IN[106] ^ IN[107] ^ IN[108] ^ IN[109] ^ IN[110] ^ IN[111] ^ 
                    IN[113] ^ IN[116] ^ IN[117] ^ IN[118] ^ IN[119] ^ IN[124] ^ IN[125] ^ IN[126] ^ CHK[8];
       
        ERR <= |SYN;
        SGL <= ^SYN & ERR;
        DBL <= ~^SYN & ERR;
    end

corrector corr_mod (.IN(IN), .SYN(SYN), .OUT(OUT));
    
endmodule


