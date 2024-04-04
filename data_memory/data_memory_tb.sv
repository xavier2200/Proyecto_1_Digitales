`timescale 100ns / 1ps
module data_memory_tb;

    // Parámetros del módulo
    parameter W = 32;
    parameter N = 5;
    
    // Definición de señales
    logic clk;
    logic [N-1:0] address;
    logic [W-1:0] write_data;
    logic [W-1:0] read_data; 
    logic MemRead;
    logic MemWrite;
    logic rst;

    // Instancia del módulo bajo prueba
    data_memory #(W, N) dut (
        .rst(rst),
        .clk(clk),
        .address(address),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Generación de clock a 1 kHz
    always #1 clk = ~clk;

    initial begin
        $dumpfile("data_memory.vcd");
        $dumpvars(0, data_memory_tb);
    end

    // Test case: Escribir en todas dlas posibles direcciones y verificar
    initial begin
        rst = 1;
        clk = 0;
        @(posedge clk); // Esperar un poco para estabilizar la simulación
        rst <= 0;

        // Escribir datos en todas las posibles direcciones de memoria
        for (integer i = 0; i < (1 << N); i++) begin
            address = i; // Dirección de memoria
            @(posedge clk);
            write_data = $random; // Datos aleatorios a escribir
            MemWrite = 1; // Habilitación de escritura
            @(posedge clk);
        end
        MemWrite = 0;
        
        // Leer datos de todas las direcciones de memoria y verificar si son correctos
        for (integer i = 0; i < (1 << N); i++) begin
            address = i; // Dirección de memoria
            @(posedge clk);
            MemRead = 1;
            @(posedge clk);
            if (read_data !== dut.mem[i]) begin
                $display("Test case failed at address %d", i);
            end else begin
                $display("Mem %0d: %h", i, read_data);
                end
        end
        @(posedge clk); // Esperar un poco al final antes de finalizar la simulación
        $finish; // Finalizar la simulación
    end

endmodule
