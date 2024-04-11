`timescale 100ns / 1ps

module pc_tb;

    parameter ADDRESS_WIDTH = 32;
    // Se�ales de entrada
    logic rst_tb;
    logic clk_tb;
    logic [ADDRESS_WIDTH-1:0] PC_next_tb;

    // Se�ales de salida
    logic [ADDRESS_WIDTH-1:0] address_o_tb;
    

    // Instancia del contador de programa
    pc_counter #(.ADDRESS_WIDTH(ADDRESS_WIDTH)) PC_dut (
        .rst(rst_tb),
        .clk(clk_tb),
        .PC_next(PC_next_tb),
        .address_o(address_o_tb)
    );

    // Se�al de reloj
    always #5 clk_tb = ~clk_tb;
    
    // Est�mulo
    initial begin
        $dumpfile("pc_tb.vcd"); // Especifica el nombre del archivo VCD
        $dumpvars(1, pc_tb); // Define el alcance de la generación del VCD

        // Inicializaci�n de se�ales
        PC_next_tb = 0;
        clk_tb = 0;
        
        // Generar un pulso de reset
        rst_tb = 1;
        #10 rst_tb = 0;

        // Generar est�mulo utilizando un bucle for
        for (int i = 0; i < 6; i = i + 1) begin 
            // Establecer la pr�xima direcci�n del programa
            PC_next_tb = i;
            // Esperar un ciclo de reloj
            #5;
            
            if(PC_next_tb != i)begin 
                $display("Error, contenido incorrecto");       
            end else 
                $display("address_o = %h", address_o_tb);
        end
        $finish;    
    end
endmodule



