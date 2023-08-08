/*
Project        : AES
Standard doc.  : 
Module name    : MUX block
Dependancy     :
Design doc.    : 
References     : 
Description    : MUX 2x1
Owner          : Yahia Ahmed
*/

module Mux2x1
(
    input [7:0] in0 [0:3] [0:3],
    input [7:0] in1 [0:3] [0:3],
    input sel,
    output reg [7:0] out [0:3] [0:3]
);

always @(*) begin
    case (sel)
        1'b0: out = in0;
        1'b1: out = in1;
        default: out = in0;
    endcase
end

endmodule