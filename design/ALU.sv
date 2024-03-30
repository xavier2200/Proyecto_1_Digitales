module ALU #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] data_rs1,
    input logic [DATA_WIDTH-1:0] source_2,
    input logic [1:0] alu_inst,

    output logic [DATA_WIDTH-1:0] ALU_result,
    output logic zero
);
    
logic [DATA_WIDTH-1:0] ALUResult;

assign ALUResult = ALU_result;
    
always @ (*) begin
    if(ALUResult==0)begin
        zero = 1'b1;
    end else begin
         zero=1'b0;
    end
end


always @(*) begin
    case(alu_inst)

        2'b00 : ALU_result = data_rs1 + source_2;  //suma
        2'b01 : ALU_result = data_rs1 - source_2;  //resta
        2'b10 : ALU_result = data_rs1 & source_2;  //AND
        2'b11 : ALU_result = data_rs1 | source_2; //OR

        default ALU_result=data_rs1 + source_2;
endcase

end

endmodule