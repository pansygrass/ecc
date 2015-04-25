//
// Encoder for Hsiaod 64 bit DEC
//
// Authors: Joseph Crowe and Matt Markwell
//

module enc_top (
    input [62:0] IN, 
    output reg [74:0] OUT,
    input clk   
);

    always @(*) begin
       OUT[62:0] <= IN[62:0];
 
 OUT[63] <= IN[0]^ IN[2]^ IN[6]^ IN[7]^ IN[9]^ IN[11]^ IN[12]^ IN[13]^ IN[16]^ IN[19]^ IN[22]^ IN[23]^
              IN[24]^ IN[25]^ IN[26]^ IN[27]^ IN[29]^ IN[30]^ IN[34]^ IN[35]^ IN[39]^ IN[41]^ IN[42]^ IN[45]^
              IN[46]^ IN[47]^ IN[48]^ IN[51];

 OUT[64] <= IN[1]^ IN[3]^ IN[7]^ IN[8]^ IN[10]^ IN[12]^ IN[13]^ IN[14]^ IN[17]^ IN[20]^ IN[23]^ IN[24]^
              IN[25]^ IN[26]^ IN[27]^ IN[28]^ IN[30]^ IN[31]^ IN[35]^ IN[36]^ IN[40]^ IN[42]^ IN[43]^
              IN[46]^ IN[47]^ IN[48]^ IN[49]^ IN[52];

 OUT[65] <= IN[2]^ IN[4]^ IN[8]^ IN[9]^ IN[11]^ IN[13]^ IN[14]^ IN[15]^ IN[18]^ IN[21]^ IN[24]^ IN[25]^
              IN[26]^ IN[27]^ IN[28]^ IN[29]^ IN[31]^ IN[32]^ IN[36]^ IN[37]^ IN[41]^ IN[43]^ IN[44]^
              IN[47]^ IN[48]^ IN[49]^ IN[50]^ IN[53];

 OUT[66] <= IN[0]^ IN[2]^ IN[3]^ IN[5]^ IN[6]^ IN[7]^ IN[10]^ IN[11]^ IN[13]^ IN[14]^ IN[15]^ IN[23]^
              IN[24]^ IN[28]^ IN[32]^ IN[33]^ IN[34]^ IN[35]^ IN[37]^ IN[38]^ IN[39]^ IN[41]^ IN[44]^
              IN[46]^ IN[47]^ IN[49]^ IN[50]^ IN[54];

 OUT[67] <= IN[0]^ IN[1]^ IN[2]^ IN[3]^ IN[4]^ IN[8]^ IN[9]^ IN[13]^ IN[14]^ IN[15]^ IN[19]^ IN[22]^ IN[23]^
              IN[26]^ IN[27]^ IN[30]^ IN[33]^ IN[36]^ IN[38]^ IN[40]^ IN[41]^ IN[46]^ IN[50]^ IN[55];

 OUT[68] <= IN[0]^ IN[1]^ IN[3]^ IN[4]^ IN[5]^ IN[6]^ IN[7]^ IN[10]^ IN[11]^ IN[12]^ IN[13]^ IN[14]^ IN[15]^
              IN[19]^ IN[20]^ IN[22]^ IN[25]^ IN[26]^ IN[28]^ IN[29]^ IN[30]^ IN[31]^ IN[35]^ IN[37]^ IN[45]^
              IN[46]^ IN[48]^ IN[56];

 OUT[69] <= IN[1]^ IN[2]^ IN[4]^ IN[5]^ IN[6]^ IN[7]^ IN[8]^ IN[11]^ IN[12]^ IN[13]^ IN[14]^ IN[15]^ IN[16]^
              IN[20]^ IN[21]^ IN[23]^ IN[26]^ IN[27]^ IN[29]^ IN[30]^ IN[31]^ IN[32]^ IN[36]^ IN[38]^ IN[46]^
              IN[47]^ IN[49]^ IN[57];

 OUT[70] <= IN[2]^ IN[3]^ IN[5]^ IN[6]^ IN[7]^ IN[8]^ IN[9]^ IN[12]^ IN[13]^ IN[14]^ IN[15]^ IN[16]^ IN[17]^
              IN[21]^ IN[22]^ IN[24]^ IN[27]^ IN[28]^ IN[30]^ IN[31]^ IN[32]^ IN[33]^ IN[37]^ IN[39]^ IN[47]^
              IN[48]^ IN[50]^ IN[58];

 OUT[71] <= IN[0]^ IN[2]^ IN[3]^ IN[4]^ IN[8]^ IN[10]^ IN[11]^ IN[12]^ IN[14]^ IN[15]^ IN[17]^ IN[18]^ IN[19]^
              IN[24]^ IN[26]^ IN[27]^ IN[28]^ IN[30]^ IN[31]^ IN[32]^ IN[33]^ IN[35]^ IN[38]^ IN[39]^ IN[40]^
              IN[41]^ IN[42]^ IN[45]^ IN[46]^ IN[47]^ IN[49]^ IN[59];

 OUT[72] <= IN[1]^ IN[3]^ IN[4]^ IN[5]^ IN[9]^ IN[11]^ IN[12]^ IN[13]^ IN[15]^ IN[16]^ IN[18]^ IN[19]^ IN[20]^
              IN[25]^ IN[27]^ IN[28]^ IN[29]^ IN[31]^ IN[32]^ IN[33]^ IN[34]^ IN[36]^ IN[39]^ IN[40]^ IN[41]^
              IN[42]^ IN[43]^ IN[46]^ IN[47]^ IN[48]^ IN[50]^ IN[60];

 OUT[73] <= IN[0]^ IN[4]^ IN[5]^ IN[7]^ IN[9]^ IN[10]^ IN[11]^ IN[14]^ IN[17]^ IN[20]^ IN[21]^ IN[22]^ IN[23]^
               IN[24]^ IN[25]^ IN[27]^ IN[28]^ IN[32]^ IN[33]^ IN[37]^ IN[39]^ IN[40]^ IN[43]^ IN[44]^ IN[45]^ IN[46]^
               IN[49]^ IN[61];

 OUT[74] <= IN[1]^ IN[5]^ IN[6]^ IN[8]^ IN[10]^ IN[11]^ IN[12]^ IN[15]^ IN[18]^ IN[21]^ IN[22]^ IN[23]^ IN[24]^
               IN[25]^ IN[26]^ IN[28]^ IN[29]^ IN[33]^ IN[34]^ IN[38]^ IN[40]^ IN[41]^ IN[44]^ IN[45]^ IN[46]^ IN[47]^
               IN[50]^ IN[62];
     end
endmodule


