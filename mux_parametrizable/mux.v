module mux #(parameter maxnum=3, parameter depth=4)(
    input clk,
    input rst,
    input [$clog2(depth)-1:0] sel,
    input [depth-1:0][$clog2(maxnum)-1:0] inputs,
    output [$clog2(maxnum)-1:0] salida
);

wire [depth-1:0]en;
genvar i;
generate
    for (i = 0;i < depth; i=i+1 ) begin
        assign en[i]=(i==sel)? 1:0;
    end
    for(i = 0; i<depth; i=i+1) begin
        bufferz #(maxnum)bufferz_(.en(en[i]), .entrada(salida_ff[i]));
    end
endgenerate


endmodule
