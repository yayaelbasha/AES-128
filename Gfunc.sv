/*
Project        : AES
Standard doc.  : 
Module name    : Gfunc block
Dependancy     :
Design doc.    : 
References     : 
Description    : Gfunc is used in the last word of the last Round key
                for key expansion
Owner          : Yahia Ahmed
*/

module Gfunc (
    input [3:0] Rnum, 
    input [7:0] W3in [0:3],
    output reg [7:0] W3out [0:3]
);
    wire [7:0] W3shift [0:3];
	 
    wire [7:0] W3sub [0:3];
	 
 assign W3shift = '{W3in[1], W3in[2], W3in[3], W3in[0]}; //cyclic shift left by one
    
    genvar i;

    generate
        for (i = 0 ; i < 4 ; i = i + 1) 
        begin: allrows3
            SBox sub (
                    .din           (W3shift[i]),        //SBox input byte
                    .dout           (W3sub[i])    //SBox output
                    );
        end
    endgenerate

localparam  R1 = 8'h01, 
            R2 = 8'h02, 
            R3 = 8'h04, 
            R4 = 8'h08, 
            R5 = 8'h10, 
            R6 = 8'h20, 
            R7 = 8'h40, 
            R8 = 8'h80, 
            R9 = 8'h1B, 
            R10 = 8'h36;

always @(*) begin
    case (Rnum)
        4'd0: W3out = '{W3sub[0], W3sub[1], W3sub[2], W3sub[3]};
        4'd1: W3out = '{(W3sub[0] ^ R1), W3sub[1], W3sub[2], W3sub[3]};
        4'd2: W3out = '{(W3sub[0] ^ R2), W3sub[1], W3sub[2], W3sub[3]};
        4'd3: W3out = '{(W3sub[0] ^ R3), W3sub[1], W3sub[2], W3sub[3]};
        4'd4: W3out = '{(W3sub[0] ^ R4), W3sub[1], W3sub[2], W3sub[3]};
        4'd5: W3out = '{(W3sub[0] ^ R5), W3sub[1], W3sub[2], W3sub[3]};
        4'd6: W3out = '{(W3sub[0] ^ R6), W3sub[1], W3sub[2], W3sub[3]};
        4'd7: W3out = '{(W3sub[0] ^ R7), W3sub[1], W3sub[2], W3sub[3]};
        4'd8: W3out = '{(W3sub[0] ^ R8), W3sub[1], W3sub[2], W3sub[3]};
        4'd9: W3out = '{(W3sub[0] ^ R9), W3sub[1], W3sub[2], W3sub[3]};
        4'd10: W3out = '{(W3sub[0] ^ R10), W3sub[1], W3sub[2], W3sub[3]};
        4'd11: W3out = '{(W3sub[0] ^ R10), W3sub[1], W3sub[2], W3sub[3]};
        4'd12: W3out = '{(W3sub[0] ^ R10), W3sub[1], W3sub[2], W3sub[3]};
        4'd13: W3out = '{(W3sub[0] ^ R10), W3sub[1], W3sub[2], W3sub[3]};
        4'd14: W3out = '{(W3sub[0] ^ R10), W3sub[1], W3sub[2], W3sub[3]};
        4'd15: W3out = '{(W3sub[0] ^ R10), W3sub[1], W3sub[2], W3sub[3]};
        default: W3out = '{W3sub[0], W3sub[1], W3sub[2], W3sub[3]};
    endcase
end

endmodule