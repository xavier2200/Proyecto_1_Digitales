`timescale 1ns / 1ps

module shift_tb;

logic [63:0] in;

logic [31:0] out;

integer i;

shift #() dut(
.in(in),
.out(out)
);

initial begin

$dumpfile("shift_tb.vcd"); // Especifica el nombre del archivo VCD
$dumpvars(1, shift_tb); // Define el alcance de la generación del VCD

in =0;
    for(i=0;i<10;i=i+1) begin
        in=$random;
        #10;
        $display("Valor del imm truncado %b",out);
        #10;


    end
end

endmodule
