`timescale 1ns / 1ns

module processor_tb;

 logic clk;
 logic rst;
 
 logic [63:0] alu_out;
 logic [63:0] read_data;
 
 //instancia procesador
 
 processor_top dut(
 .rst_t(rst),
 .clk_t(clk),
 .ALU_O_t(alu_out),
 .read_data_o_t(read_data)
 );
 
 initial forever begin
 clk=~clk;
 #5;
 end
 
 initial begin
 	$dumpfile("processor.vcd"); // Especifica el nombre del archivo VCD
        $dumpvars(1, processor_tb); // Define el alcance de la generación del
 rst=1;
 #10
 rst=0;
 
 
 end
 
