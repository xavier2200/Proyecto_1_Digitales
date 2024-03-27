`timescale 100ns / 1ps

module pc_tb;

    parameter ADDRESS_WIDTH = 32;
    // Se�ales de entrada
    logic rst;
    logic clk;
    logic [ADDRESS_WIDTH-1:0] PC_next;

    // Se�ales de salida
    logic [ADDRESS_WIDTH-1:0] address_o;
    

    // Instancia del contador de programa
    pc_counter #(
        .ADDRESS_WIDTH(ADDRESS_WIDTH)
    ) dut (
        .rst(rst),
        .clk(clk),
        .PC_next(PC_next),
        .address_o(address_o)
    );

    // Se�al de reloj
    always #5 clk = ~clk;
    

    // Est�mulo
    initial begin
        PC_next = 0;
        clk =1;
        // Reset inicial
        rst = 1;
        #10 rst = 0;

        // Se�ales de entrada
        #20 PC_next = 1;
        #20 PC_next = 2;
        // Continuar con m�s cambios de PC_next seg�n sea necesario

        // Finalizar simulaci�n despu�s de un tiempo
        #1000 $finish;
    end

    // Visualizaci�n de resultados
    always @(posedge clk) begin
        $display("address_o = %h", address_o);
    end

endmodule
