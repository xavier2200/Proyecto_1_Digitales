module imm #(parameter N = 4)(
    input [N/2-1:0] in,
    output [N-1:0] out
);
 
assign out= $signed(in);

endmodule