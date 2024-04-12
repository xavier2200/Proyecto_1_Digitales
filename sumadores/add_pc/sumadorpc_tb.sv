`timescale 1ns / 1ps

module sumadorpc_tb;

 // Parámetro para el ancho de los vectores
    parameter N = 4;

    // Señales de entrada
    logic [N-1:0] a_i;

    // Señales de salida
    logic [N-1:0] sum_o_expected, sum_o_actual;

    // Instancia del DUT (Design Under Test)
    sumadorpc #(N) dut (
        .a_i(a_i),
        .sum_o(sum_o_actual)
    );

    // Generador de estímulos
    initial begin
        // Casos de prueba
        // Test case 1: a_i = 4'b0000
        a_i = 4'b0000;
        #10; // Espera un tiempo para que se estabilicen las señales
        sum_o_expected = 4'b0100; // Suma esperada: 4'b0000 + 4'b0100 = 4'b0100
        check_output();

        // Test case 2: a_i = 4'b0101
        a_i = 4'b0101;
        #10;
        sum_o_expected = 4'b1001; // Suma esperada: 4'b0101 + 4'b0100 = 4'b1001
        check_output();

        // Test case 3: a_i = 4'b1111
        a_i = 4'b1111;
        #10;
        sum_o_expected = 4'b0011; // Suma esperada: 4'b1111 + 4'b0100 = 4'b0011
        check_output();

        // Finaliza la simulación
        $finish;
    end

    // Comprueba si la salida actual coincide con la salida esperada
    function void check_output();
        if (sum_o_actual === sum_o_expected)
            $display("Test passed: sum_o_actual = sum_o_expected = %b", sum_o_actual);
        else
            $error("Test failed: sum_o_actual = %b, sum_o_expected = %b", sum_o_actual, sum_o_expected);
    endfunction

endmodule