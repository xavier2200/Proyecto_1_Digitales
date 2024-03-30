module shift #(parameter N=64)(
input [N-1:0] in,
output [N/2-1:0] out
);
reg [N-1:0] inter;
assign inter= in << 1;
assign out= inter[31:0]; //truncar

endmodule
