module registro_tb;

    // Parámetros del módulo
    parameter W = 32;
    parameter N = 5;
    
    // Definición de señales
    logic clk;
    logic [N-1:0] address;
    logic we;
    logic [W-1:0] write_data;
    logic [W-1:0] read_data;

    // Instancia del módulo bajo prueba
    data_memory #(W, N) dut (
        .clk(clk),
        .address(address),
        .we(we),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Generación de clock a 1 kHz
    always #0.5 clk = ~clk;

    initial begin
        $dumpfile("registro_tb.vcd");
        $dumpvars(0, registro_tb);
    end

    // Test case: Escribir en todas las posibles direcciones y verificar
    initial begin
        #500; // Esperar un poco para estabilizar la simulación

        // Escribir datos en todas las posibles direcciones de memoria
        for (int i = 0; i < (1 << N); i++) begin
            address = i; // Dirección de memoria
            we = 1; // Habilitación de escritura
            write_data = $random; // Datos aleatorios a escribir
            #1000;
        end
        we = 0; // Deshabilitación de escritura
        #1000;

        // Leer datos de todas las direcciones de memoria y verificar si son correctos
        for (int i = 0; i < (1 << N); i++) begin
            address = i; // Dirección de memoria
            #1000;
            if (read_data !== dut.mem[i+3]) begin
                $display("Test case failed at address %d", i);
                $finish;
            end
        end
        $display("Test case passed");

        #1000; // Esperar un poco al final antes de finalizar la simulación
        $finish; // Finalizar la simulación
    end

endmodule
