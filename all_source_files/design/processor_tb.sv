`timescale 1ns / 1ps

module processor_top_tb;

    // Parámetros y variables
    parameter W = 32;
    
    logic clk;
    logic rst;
    // Instancia del módulo a probar
    processor_top #() dut (
        .clk_t(clk),
        .rst_t(rst)
    );
    
    // Generación de clock a 1 kHz
    always #1 clk = ~clk;

    // Generador de reloj
    initial begin
    $dumpfile("processor.vcd");
    $dumpvars(0, processor_top_tb);
    end

    initial begin
    rst = 1;
    clk = 0;
    @(posedge clk); // Esperar un poco para estabilizar la simulación
    rst <= 0;
    
    #100000;
    $finish;
    

    //meter los display
    end
    
endmodule
