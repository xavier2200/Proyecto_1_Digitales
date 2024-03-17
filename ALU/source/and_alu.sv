`timescale 1ns / 1ps


module and_alu #(parameter N = 4)(
    input [N-1:0]           a_i,
    input [N-1:0]           b_i,
    
    output [N-1:0]          and_o
);

assign and_o = a_i & b_i;

endmodule
