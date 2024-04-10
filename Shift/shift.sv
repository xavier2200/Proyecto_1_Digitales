module shift #(parameter N=64)(
input [N-1:0] in,
output [N/2-1:0] out
);

reg [N-1:0]intermedio;
assign intermedio = in << 1;
assign out= {intermedio [N/2-1:0]};


endmodule
