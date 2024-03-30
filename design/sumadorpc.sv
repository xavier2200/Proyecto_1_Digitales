`timescale 1ns / 1ps


module sumadorpc #(parameter N = 4)(
    input [N-1:0]           a_i,
    
    output [N-1:0]          sum_o
    
);

reg [N-1:0] b_i=4;

assign sum_o = a_i + b_i;


endmodule
