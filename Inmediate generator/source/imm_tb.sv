`timescale 1ns / 1ns

module imm_tb;

parameter width_inst = 32;

logic [width_inst-1:0] inst;

logic [2*width_inst-1:0] imm;


imm #() dut(
.in(inst),
.out(imm)
);


//casos posibles de instruccion
initial begin 
inst = 0;

#10;

inst=32'b01100101111010100110111000000011;

#10;
$display("Para load double IMM= %b",imm);
#10;
inst=32'b11100101111010100110111000100011;
#10;
$display("Para store double IMM= %b",imm);
#10;
inst=32'b11100101111010100110111001100011;
#10;
$display("Para branch if equal IMM= %b",imm);
#10;
inst=32'b11100101111010100110111000110011;
#10;
$display("Caso de operacion aritmetica IMM= %b",imm);

$finish;

end

endmodule