module ALU_CONTROL #(
    parameter width_instruc = 32
) (
    input logic [width_instruc-1:0] instruccion, 
    input logic [1:0] ALU_OP,
    output logic [3:0] alu_inst
);
    
logic [3:0] field_3 ;
logic I_30;

assign  field_3 = instruccion[14:12];
assign  I_30 = instruccion[30];

always @(*) begin

    case (ALU_OP)
        2'b00 : alu_inst = 4'b0010; //add
        2'b01 : alu_inst = 4'b0110; //subtract
        2'b10 : begin

            if (I_30 == 1'b0 && field_3 == 3'b000)
                alu_inst = 4'b0010; //add
                
            else if (I_30 == 1'b1 && field_3 == 3'b000)
                alu_inst = 4'b0110; //subtract

            else if (I_30 == 1'b0 && field_3 == 3'b111)
                alu_inst = 4'b0000; //and

            else if (I_30 == 1'b0 && field_3 == 3'b110)
                alu_inst = 4'b0001; //or
        end
        default: alu_inst = 4'b0010; // Default case
    endcase
end

endmodule
