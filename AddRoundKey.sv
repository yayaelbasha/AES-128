/*
Project        : AES
Standard doc.  : 
Module name    : AddRoundKey block
Dependancy     :
Design doc.    : 
References     : 
Description    : Adds(xor) the key with the state.
Owner          : Yahia Ahmed
*/

module AddRoundKey
(
    input [7:0] statein [0:3] [0:3],
    input [7:0] key [0:3] [0:3],
    output [7:0] stateout [0:3] [0:3]
);
    genvar i, j;

    generate
        for (i = 0 ; i < 4 ; i = i + 1) 
        begin: allrows
            for (j = 0 ; j < 4 ; j = j + 1) 
            begin: allcols
                assign stateout[i][j] = statein[i][j] ^ key[i][j];
            end
        end
    endgenerate
endmodule