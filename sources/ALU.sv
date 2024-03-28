module ALU #(
    parameter DATA_WIDTH = 32,
) (
    input logic [DATA_WIDTH-1:0] data_rs1,
    input logic [DATA_WIDTH-1:0] source_2,
    input logic [3:0] alu_inst,

    output logic ALU_result,
    output zero
);
    
always @ (*) begin
    if(ALUResult==0) zero = 1'b1;

    else  cero=1'b0;
end


always @(*) begin
    case(alu_inst)

        4'b0010 : ALU_result = data_rs1 + source_2;  //suma
        4'b0110 : ALU_result = data_rs1 - source_2;  //resta
        4'b0000 : ALU_result = data_rs1 & source_2;  //AND
        4'b0001 : ALU_result = data_rs1 | source_2; //OR

        default ALU_result=data + source_2;
endcase

end

endmodule