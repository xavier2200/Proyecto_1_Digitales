module main_control #(parameter width_instruc = 7) (
    input logic [width_instruc-1:0] opcode,
    output logic ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,
    output logic [1:0] ALUOp
);

always @(*) begin
    case (opcode)
        7'b0110011: begin // R-format
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b10;
        end
        7'b0000011: begin // ld
            ALUSrc = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
        end
        7'b0100011: begin // sd
            ALUSrc = 1;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            ALUOp = 2'b00;
        end
        7'b1100011: begin // beq
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 1;
            ALUOp = 2'b01;
        end
        default: begin // Caso no definido
            ALUSrc = 'x;
            MemtoReg = 'x;
            RegWrite = 'x;
            MemRead = 'x;
            MemWrite = 'x;
            Branch = 'x;
            ALUOp = 2'bxx;
        end
    endcase

end

endmodule