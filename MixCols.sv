/*
Project        : AES
Standard doc.  : 
Module name    : MixCols block
Dependancy     :
Design doc.    : 
References     : 
Description    : MixCols consists  of 4x4 Matrix Multiplication with
                    the constant matrix uaing modulo arithmetic.
Owner          : Yahia Ahmed
*/

module MixCols (
    input [7:0] Datain [0:3] [0:3],
    output [7:0] Dataout [0:3] [0:3]
);
/* Multiplication by 2 is done by left shift by one, 
if the MSB contains one the add (xor) 1b*/
    function [7:0] ModMul2;
        input [7:0] in;
        begin 
            ModMul2 = (!in[7])? (in << 1) : ((in << 1) ^ 8'h1b);
        end  
    endfunction

/* Multiplication by 3 is done by multiplying by 2 first then adding (xor)
the number to itself
*/

    function [7:0] ModMul3;
        input [7:0] in;
        begin 
            ModMul3 = ModMul2(in) ^ in;
        end  
    endfunction
    
    genvar i;

    generate
        for (i = 0 ; i < 4 ; i = i + 1) 
        begin: matrixmul
            assign Dataout[0][i] = ModMul2(Datain[0][i]) ^ ModMul3(Datain[1][i]) ^ Datain[2][i] ^ Datain[3][i];
            assign Dataout[1][i] = Datain[0][i] ^ ModMul2(Datain[1][i]) ^ ModMul3(Datain[2][i]) ^ Datain[3][i];
            assign Dataout[2][i] = Datain[0][i] ^ Datain[1][i] ^ ModMul2(Datain[2][i]) ^ ModMul3(Datain[3][i]);
            assign Dataout[3][i] = ModMul3(Datain[0][i]) ^ Datain[1][i] ^ Datain[2][i] ^ ModMul2(Datain[3][i]);
        end
    endgenerate

endmodule