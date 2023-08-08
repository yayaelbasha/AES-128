/*
Project        : AES
Standard doc.  : 
Module name    : AES Encryption block
Dependancy     :
Design doc.    : 
References     : 
Description    : AES module.
Owner          : Yahia Ahmed
*/


module AES
(
    input clk, rst, valid, 
    input [127:0] ptxt,
    input [127:0] key,
    output [127:0] ctxt
);
    logic [7:0] ptxtds [0:3] [0:3];
    logic [7:0] ptxtreg [0:3] [0:3];
    logic [7:0] ctxtreg [0:3] [0:3];
    logic [7:0] keyds [0:3] [0:3];
    logic [7:0] keyreg [0:3] [0:3];

    //Round Signals
    logic [7:0] regsbR [0:3] [0:3];
    logic [7:0] sbsrR [0:3] [0:3];
    logic [7:0] srmcR [0:3] [0:3];
    logic [7:0] mcmux1R [0:3] [0:3];
    logic [7:0] mux1mux2R [0:3] [0:3];
    logic [7:0] mux2arR [0:3] [0:3];
    logic [7:0] arregR [0:3] [0:3];

    //Key Expansion Signals
    logic [7:0] reggfK [0:3] [0:3];
    logic [7:0] gwordK [0:3];
    logic [7:0] kxmux1K [0:3] [0:3];
    logic [7:0] mux1arK [0:3] [0:3];

    //Controller Signals
    logic eni, eno, crst, selr, seli, done;
    logic [3:0] rcount;


    
    //Matrix Assignment
    assign ptxtds[0][0] = ptxt[127:120];
    assign ptxtds[1][0] = ptxt[119:112];
    assign ptxtds[2][0] = ptxt[111:104];
    assign ptxtds[3][0] = ptxt[103:96];
    assign ptxtds[0][1] = ptxt[95:88];
    assign ptxtds[1][1] = ptxt[87:80];
    assign ptxtds[2][1] = ptxt[79:72];
    assign ptxtds[3][1] = ptxt[71:64];
    assign ptxtds[0][2] = ptxt[63:56];
    assign ptxtds[1][2] = ptxt[55:48];
    assign ptxtds[2][2] = ptxt[47:40];
    assign ptxtds[3][2] = ptxt[39:32];
    assign ptxtds[0][3] = ptxt[31:24];
    assign ptxtds[1][3] = ptxt[23:16];
    assign ptxtds[2][3] = ptxt[15:8];
    assign ptxtds[3][3] = ptxt[7:0];

    assign keyds[0][0] = key[127:120];
    assign keyds[1][0] = key[119:112];
    assign keyds[2][0] = key[111:104];
    assign keyds[3][0] = key[103:96];
    assign keyds[0][1] = key[95:88];
    assign keyds[1][1] = key[87:80];
    assign keyds[2][1] = key[79:72];
    assign keyds[3][1] = key[71:64];
    assign keyds[0][2] = key[63:56];
    assign keyds[1][2] = key[55:48];
    assign keyds[2][2] = key[47:40];
    assign keyds[3][2] = key[39:32];
    assign keyds[0][3] = key[31:24];
    assign keyds[1][3] = key[23:16];
    assign keyds[2][3] = key[15:8];
    assign keyds[3][3] = key[7:0];

    assign ctxt[127:120] = ctxtreg[0][0];
    assign ctxt[119:112] = ctxtreg[1][0];
    assign ctxt[111:104] = ctxtreg[2][0];
    assign ctxt[103:96] = ctxtreg[3][0];
    assign ctxt[95:88] = ctxtreg[0][1];
    assign ctxt[87:80] = ctxtreg[1][1];
    assign ctxt[79:72] = ctxtreg[2][1];
    assign ctxt[71:64] = ctxtreg[3][1];
    assign ctxt[63:56] = ctxtreg[0][2];
    assign ctxt[55:48] = ctxtreg[1][2];
    assign ctxt[47:40] = ctxtreg[2][2];
    assign ctxt[39:32] = ctxtreg[3][2];
    assign ctxt[31:24] = ctxtreg[0][3];
    assign ctxt[23:16] = ctxtreg[1][3];
    assign ctxt[15:8] = ctxtreg[2][3];
    assign ctxt[7:0] = ctxtreg[3][3];



    //Round Components Instances
    Reg128 ireg_ptxt(
                        .clk    (clk), 
                        .rst    (rst), 
                        .en     (1'b1), 
                        .in     (ptxtds), 
                        .out    (ptxtreg)
                        );

    Mux2x1 mux2R    (
                        .in0    (mux1mux2R),
                        .in1    (ptxtreg),
                        .sel    (seli),
                        .out    (mux2arR)
                        );

    AddRoundKey AR  (
                        .statein    (mux2arR),
                        .key        (mux1arK),
                        .stateout   (arregR)
                        );

    Reg128 regR     (
                        .clk    (clk), 
                        .rst    (rst), 
                        .en     (1'b1), 
                        .in     (arregR), 
                        .out    (regsbR)
                        );

    SubBytes sbR    (
                        .Datain (regsbR), 
                        .Dataout(sbsrR) 
                        );

    ShiftRows sr    (
                        .Datain (sbsrR), 
                        .Dataout(srmcR)
                        );

    MixCols mc      (
                        .Datain (srmcR), 
                        .Dataout(mcmux1R)
                        );

    Mux2x1 mux1R    (
                        .in0    (mcmux1R),
                        .in1    (srmcR),
                        .sel    (selr),
                        .out    (mux1mux2R)
                        );

    Reg128 oreg_ctxt(
                    .clk    (clk), 
                    .rst    (rst), 
                    .en     (eno), 
                    .in     (arregR), 
                    .out    (ctxtreg)
                    );


   //Key Expansion Components Instances
    Reg128 ireg_key(
                        .clk    (clk), 
                        .rst    (rst), 
                        .en     (eni), 
                        .in     (keyds), 
                        .out    (keyreg)
                        );

    Mux2x1 mux1K    (
                        .in0    (kxmux1K),
                        .in1    (keyreg),
                        .sel    (seli),
                        .out    (mux1arK)
                        );

    Reg128 regK     (
                        .clk    (clk), 
                        .rst    (rst), 
                        .en     (1'b1), 
                        .in     (mux1arK), 
                        .out    (reggfK)
                        );

    logic [7:0] W3in [0:3];
    assign W3in [0] = reggfK[0][3];
    assign W3in [1] = reggfK[1][3];
    assign W3in [2] = reggfK[2][3];
    assign W3in [3] = reggfK[3][3];

    Gfunc gf        (
                        .Rnum   (rcount), 
                        .W3in   (W3in),
                        .W3out  (gwordK)
                        );

    KeyXor kx       (
                        .Wordsin(reggfK),
                        .Gword  (gwordK),
                        .Wordsout(kxmux1K)
                        );

    //Controller Instances
    RCounter rc     (
                        .clk    (clk),        // Clock input
                        .arst   (crst),      // Asynchronous active low reset
                        .en     (1'b1),     // Enable input
                        .flag   (done),  // Output flag indicating count reaching 10
                        .count  (rcount) // Output count (4-bit counter)
                        );

    Ctrller Ctrller (
                        .clk    (clk), 
                        .rst    (rst), 
                        .valid  (valid), 
                        .complete(done),
                        .eni   (eni), 
                        .eno   (eno), 
                        .seli   (seli), 
                        .selr   (selr), 
                        .crst   (crst)
                    ); 


endmodule