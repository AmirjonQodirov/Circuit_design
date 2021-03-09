`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2021 10:26:43 AM
// Design Name: 
// Module Name: adder
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


module adder(
    input a,
    input b,
    input carry_in,
    output result,
    output carry_out
    );
    
    wire not_a, not_b, not_ci;
    nor(not_a, a, a);
    nor(not_b, b, b);
    nor(not_ci, carry_in, carry_in);
    
    wire nor_b_ci, nor_nb_nci, nor_nb_ci, nor_b_nci;
    nor(nor_b_ci, b, carry_in);
    nor(nor_nb_nci, not_b, not_ci);
    nor(nor_nb_ci, not_b, carry_in);
    nor(nor_b_nci, b, not_ci);
   
    wire x1, x2, x3, x4, x5;
    nor(x1, nor_b_nci, nor_nb_ci);
    nor(x2, nor_b_ci, nor_nb_nci);
    nor(x3, a, x1);
    nor(x4, not_a, x2);
    nor(x5, not_a, x1);
    
    wire not_res, not_co;
    nor(not_res, x3, x4);
    nor(not_co, nor_nb_nci, x5);
    
    nor(result, not_res, not_res);
    nor(carry_out, not_co, not_co);
    
endmodule
