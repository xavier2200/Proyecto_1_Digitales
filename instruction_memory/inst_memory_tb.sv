`timescale 100ns / 1ps
module inst_memory_tb;

    // Parámetros del módulo
    parameter W = 32;
    parameter N = 5;

    
    // Definición de señales

    logic [W-1:0] address;

    logic [W-1:0] read_data; 


    // Instancia del módulo bajo prueba
    inst_memory #(W, W, 10) dut (

        .address(address),
        .instruction(read_data)
    );

    

    initial begin
        $dumpfile("inst_memory.vcd");
        $dumpvars(0, inst_memory_tb);
    end

    initial begin
        
        // Leer datos de todas las direcciones de memoria y verificar si son correctos
        for (integer i = 0; i < (1 << N); i=i+4) begin
            address = i; // Dirección de memoria
            #10;
        end
        $finish; // Finalizar la simulación
    end

endmodule