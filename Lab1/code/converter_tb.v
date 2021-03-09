`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 12:54:44 PM
// Design Name: 
// Module Name: converter_tb
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


module converter_tb;

reg[7:0] in;
wire [7:0] out;

converter coverter_1(
    .x0(in[0]),
    .x1(in[1]),
    .x2(in[2]),
    .x3(in[3]),
    .x4(in[4]),
    .x5(in[5]),
    .x6(in[6]),
    .x7(in[7]),
    .y0(out[0]),
    .y1(out[1]),
    .y2(out[2]),
    .y3(out[3]),
    .y4(out[4]),
    .y5(out[5]),
    .y6(out[6]),
    .y7(out[7])
);
integer i, t;
initial begin
    for(t=0, i = 0, in = 0; in < 160; in = in + 1) begin
    #5
    if(in<16*i+10) begin
        $display("Test for %d:", t);
        $display("input = %b%b%b%b %b%b%b%b", in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]);
        if(out == t) begin
            $display("Test passed, answer: %d.", t);
        end
        t = t + 1;

    end
    
    if(in==16*(i+1)-1) begin
        i=(in/16)+1;
    end
    end
    #5 $stop;
end
endmodule
