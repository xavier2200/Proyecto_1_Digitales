module main_control_tb;

logic [6:0] opcode;

logic ALUSrc;
logic MemtoReg;
logic RegWrite;
logic MemRead;
logic MemWrite;
logic Branch;

logic [1:0] ALUOp;

main_control #() dut(
    .opcode(opcode),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUOp(ALUOp)
);

initial begin
    $dumpfile("main_control.vcd"); // Especifica el nombre del archivo VCD
    $dumpvars(1, main_control_tb); // Define el alcance de la generación del VCD


 opcode = 7'b0110011;
        #10;
        assert (ALUSrc == 0);
        assert (MemtoReg == 0);
        assert (RegWrite == 1);
        assert (MemRead == 0);
        assert (MemWrite == 0);
        assert (Branch == 0);
        assert (ALUOp == 2'b10);

        // Test case 2: ld
        opcode = 7'b0000011;
        #10;
        assert (ALUSrc == 1);
        assert (MemtoReg == 1);
        assert (RegWrite == 1);
        assert (MemRead == 1);
        assert (MemWrite == 0);
        assert (Branch == 0);
        assert (ALUOp == 2'b00);

        // Test case 3: sd
        opcode = 7'b0100011;
        #10;
        assert (ALUSrc == 1);
        assert (MemtoReg == 0);
        assert (RegWrite == 0);
        assert (MemRead == 0);
        assert (MemWrite == 1);
        assert (Branch == 0);
        assert (ALUOp == 2'b00);

        // Test case 4: beq
        opcode = 7'b1100011;
        #10;
        assert (ALUSrc == 0);
        assert (MemtoReg == 0);
        assert (RegWrite == 0);
        assert (MemRead == 0);
        assert (MemWrite == 0);
        assert (Branch == 1);
        assert (ALUOp == 2'b01);

        // Test case 5: default
        opcode = 7'b0000000; // Unrecognized opcode
        #10;
        assert (ALUSrc === 'x);
        assert (MemtoReg === 'x);
        assert (RegWrite === 'x);
        assert (MemRead === 'x);
        assert (MemWrite === 'x);
        assert (Branch === 'x);
        assert (ALUOp === 2'bxx);

        // Finaliza la simulación
        $finish;
    end

endmodule