module ALU_top #(parameter N=64)(
input [1:0] alu_control,
input [N-1:0] A,
input [N-1:0] B,

output [N-1:0] alu_result,
output zero
);

wire [N-1:0] internal[3:0];


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
    .sum_o(internal[2])
);

restador #(.N(N)) restador_alu (
    .a_i(A),
    .b_i(B),
    .resta_o(internal[2])   
);

mux #(.N(N))(
    .sel(alu_control),
    .in(internal),
    .aux(internal[0]),
    .salida(alu_result),
    .auxiliar(zero)
);

endmodule