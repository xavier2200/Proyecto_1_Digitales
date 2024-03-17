module ALU_top #(parameter N=64)(
input [1:0] alu_control,
input [N-1:0] A,
input [N-1:0] B,

output [N-1:0] alu_result,
output carry_o
);

wire [N-1:0] internal[3:0];
wire carry_temp [1:0];


and_alu #(.N(N)) and_AB(
    .a_i(A),
    .b_i(B),
    .and_o(internal[0])
);

or_alu #(.N(N)) or_AB(
    .a_i(A),
    .b_i(B),
    .or_o(internal[1])
);

sumador #(.N(N)) sumador_alu(
    .a_i(A),
    .b_i(B),
    .sum_o(internal[2]),
    .carry_o(carry_o)
);

restador #(.N(N)) restador_alu (
    .a_i(A),
    .b_i(B),
    .sum_o(internal[2]),
    .carry_o(carry_o)    
);

mux #(.N(N))(
    .sel(alu_control),
    .in(internal),
    .salida(alu_result)
);