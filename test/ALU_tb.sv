`timescale 1ns / 1ps

module ALU_tb;

// Parámetros
  parameter WIDTH = 8;  // Ancho de los operandos

  // Señales
  reg [WIDTH-1:0] operand1, operand2;
  reg [1:0] opcode;
  wire [WIDTH-1:0] result;
  wire zero_o;
 integer i;
  // Instancia de la ALU
  ALU alu_inst#(.DATA_WIDTH(WIDTH))(
    .data_rs1(operand1),
    .source_2(operand2),
    .alu(opcode),
    .ALU_result(result),
    .zero(zero_o),
  );

  // Generación de estímulos
 initial begin
    operand1 = 0;
    operand2 = 0;
    opcode = 0;
 end

 for (i = 0 ;i<10 ;i=i+1 ) begin
    
    if (i=0) begin
        operand1 = 5;
        operand2 = 5;
    end
    else begin
    // Establecer operandos
    operand1 = $urandom_range(2**WIDTH);
    operand2 = $urandom_range(2**WIDTH);
    end

    // Realizar suma
    opcode = 2'b0010;

    $display("Operand1 = %b", operand1);
    $display("Operand2 = %b", operand2);
    $display("Result = %b zero_flag = %b", result,zero_o);
    $display("----------------------------");

    #10;

    // Realizar resta
    opcode = 2'b0110;

    $display("Operand1 = %b", operand1);
    $display("Operand2 = %b", operand2);
    $display("Result = %b zero_flag = %b", result,zero_o);
    $display("----------------------------");

    #10;

    // Realizar AND
    opcode = 2'b0000;

    $display("Operand1 = %b", operand1);
    $display("Operand2 = %b", operand2);
    $display("Result = %b zero_flag = %b", result,zero_o);
    $display("----------------------------");

    #10;

    // Realizar OR
    opcode = 2'b0001;

    $display("Operand1 = %b", operand1);
    $display("Operand2 = %b", operand2);
    $display("Result = %b zero_flag = %b", result,zero_o);
    $display("----------------------------");
    
    #10;

    // Finalizar la simulación

end
    $finish;
 
  

endmodule