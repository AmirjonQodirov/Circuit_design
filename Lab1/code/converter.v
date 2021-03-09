`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 12:20:24 PM
// Design Name: 
// Module Name: converter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module converter(
    input x0,
    input x1, 
    input x2,
    input x3,
    input x4,
    input x5,
    input x6,
    input x7,
    output y0,
    output y1,
    output y2,
    output y3,
    output y4,
    output y5,
    output y6,
    output y7
);

wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9;
wire s0, s1, s2, s3;

adder a0(.a(x0), .b(0), .carry_in(0), .result(y0), .carry_out(w0));
adder a1(.a(x1), .b(x4), .carry_in(w0), .result(s0), .carry_out(w1));
adder a2(.a(x2), .b(x5), .carry_in(w1), .result(s1), .carry_out(w2));
adder a3(.a(x3), .b(x6), .carry_in(w2), .result(s2), .carry_out(w3));
adder a4(.a(x7), .b(0), .carry_in(w3), .result(s3), .carry_out(w4));

adder a5(.a(0), .b(s0), .carry_in(0), .result(y1), .carry_out(w5));
adder a6(.a(0), .b(s1), .carry_in(w5), .result(y2), .carry_out(w6));
adder a7(.a(x4), .b(s2), .carry_in(w6), .result(y3), .carry_out(w7));
adder a8(.a(x5), .b(s3), .carry_in(w7), .result(y4), .carry_out(w8));
adder a9(.a(x6), .b(w4), .carry_in(w8), .result(y5), .carry_out(w9));
adder a10(.a(x7), .b(0), .carry_in(w9), .result(y6), .carry_out(y7));

endmodule
