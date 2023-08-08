/*
Project        : AES
Standard doc.  : 
Module name    : KeyXOR block
Dependancy     :
Design doc.    : 
References     : 
Description    : XORing the words of the key to get the next key
Owner          : Yahia Ahmed
*/

module KeyXor ( 
    input [7:0] Wordsin [0:3] [0:3],
    input [7:0] Gword [0:3],
    output [7:0] Wordsout [0:3] [0:3]
);

    wire [7:0] Wordsbet [0:3][0:4];
    
    genvar i, j, k;

    generate
        for (k = 0 ; k < 4 ; k = k + 1) 
        begin: cols1
            assign Wordsbet[k][0] = Gword[k];
        end
    endgenerate

    generate
        for (i = 0 ; i < 4 ; i = i + 1) 
        begin: rows
            for (j = 0 ; j < 4 ; j = j + 1)
            begin: cols2
                assign Wordsout[j][i] = Wordsin[j][i] ^ Wordsbet[j][i];
                assign Wordsbet[j][i+1] = Wordsout[j][i];
            end
        end
    endgenerate
endmodule