/*
Project        : AES
Standard doc.  : 
Module name    : SubBytes block
Dependancy     :
Design doc.    : 
References     : 
Description    : SubBytes uses the SBox.
Owner          : Yahia Ahmed
*/

module SubBytes
(
    input [7:0] Datain [0:3] [0:3],
    output [7:0] Dataout [0:3] [0:3]
);
    genvar i, j;

    generate
        for (i = 0 ; i < 4 ; i = i + 1) 
        begin: allrows2
            for (j = 0 ; j < 4 ; j = j + 1) 
            begin: allcols2
                SBox sub (
                        .din           (Datain[i][j]),        //SBox input byte
                        .dout           (Dataout[i][j])    //SBox output
                        );
            end
        end
    endgenerate
endmodule