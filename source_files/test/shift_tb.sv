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
in =0;
    for(i=0;i<10;i=i+1) begin
        in=$random;
        #10;
        $display("Valor del imm truncado %b",out);
        #10;


    end
end

endmodule
