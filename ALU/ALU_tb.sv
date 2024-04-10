`timescale 1ns / 1ns

module ALU_tb;

// Parámetros
  parameter WIDTH = 5;  // Ancho de los operandos

  // Señales
  reg [WIDTH-1:0] operand1, operand2;
  reg [1:0] opcode;
  wire [WIDTH-1:0] result;
  wire zero_o;
 
  // Instancia de la ALU
  ALU #(.DATA_WIDTH(WIDTH)) alu_inst (
    .data_rs1(operand1),
    .source_2(operand2),
    .alu_inst(opcode),
    .ALU_result(result),
    .zero(zero_o)
  );
  integer i;
  // Generación de estímulos
 initial begin
    $dumpfile("ALU_tb.vcd"); // Especifica el nombre del archivo VCD
    $dumpvars(1, ALU_tb); // Define el alcance de la generación del VCD
 
     
    operand1 = 0;
    operand2 = 0;
    opcode = 0;
 

 for (i = 0 ;i<10 ;i=i+1 ) begin
    #10;
    if (i==0) begin
        operand1 = 5;
        operand2 = 5;
    end
    else begin
    // Establecer operandos
    operand1 = $urandom_range(WIDTH);
    operand2 = $urandom_range(WIDTH);
    end
    #10;
    // Realizar suma
    opcode = 2'b00;
    
    $display("Operand1 = %d", operand1);
    $display("Operand2 = %d", operand2);
    $display("Result = %d zero_flag = %b", result,zero_o);
    $display("----------------------------");

    #10;

    // Realizar resta
    opcode = 2'b01;

    $display("Operand1 = %d", operand1);
    $display("Operand2 = %d", operand2);
    $display("Result = %d zero_flag = %b", result,zero_o);
    $display("----------------------------");

    #10;

    // Realizar AND
    opcode = 4'b10;

    $display("Operand1 = %d", operand1);
    $display("Operand2 = %d", operand2);
    $display("Result = %d zero_flag = %b", result,zero_o);
    $display("----------------------------");

    #10;

    // Realizar OR
    opcode = 4'b11;

    $display("Operand1 = %d", operand1);
    $display("Operand2 = %d", operand2);
    $display("Result = %d zero_flag = %b", result,zero_o);
    $display("----------------------------");
    
    #10;

    // Finalizar la simulación

end

    $finish;
end


endmodule
