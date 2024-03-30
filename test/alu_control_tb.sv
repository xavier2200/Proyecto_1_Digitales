`timescale 1ns / 1ps

module alu_control_tb;

parameter width_inst=32;

logic [width_inst-1:0] inst;
logic [1:0]alu_oper;

logic [1:0] alu_instr;



ALU_CONTROL #(.width_instruction(width_inst)) dut (
    .instruccion(inst),
    .ALU_OP(alu_oper),
    .alu_inst(alu_instr)
);
initial begin
inst=0;
alu_oper=0;

#10;

alu_oper = 2'b00;

    $display("ALU_INST = %b", alu_instr);

    #10;

alu_oper = 2'b01;

    $display("ALU_INST = %b", alu_instr);

    #10;

alu_oper = 2'b10;
    inst=0;
    $display("ALU_INST = %b", alu_instr);

    #10;

    inst = 32'b01000000000000000000000000000000;
    $display("ALU_INST = %b", alu_instr);

    #10;

    inst = 32'b00000000000000000111000000000000;
    $display("ALU_INST = %b", alu_instr);

    #10;

    inst = 32'b00000000000000000110000000000000;
    $display("ALU_INST = %b", alu_instr);

    #10;
    
    $finish;
end
endmodule