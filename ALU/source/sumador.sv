`timescale 1ns / 1ps


module sumador #(parameter N = 4)(
    input [N-1:0]           a_i,
    input [N-1:0]           b_i,
    //input                   carry_i,
    
    output [N-1:0]          sum_o,
    output                  carry_o
);

assign {carry_o,sum_o} = a_i + b_i;


endmodule