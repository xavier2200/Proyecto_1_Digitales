`timescale 1ns / 1ps


module restador #(parameter N = 4)(
    input [N-1:0]           a_i,
    input [N-1:0]           b_i,
    //input                   carry_i,
    
    output [N-1:0]          resta_o,
    output                  carry_o
);

wire [N-1:0] b_neg;
assign b_neg = ~b_i + 1;

wire [N:0] resta;
assign resta = a_i + b_neg; 

assign resta_o = resta[N-1:0];
assign carry_o = resta[N];

endmodule