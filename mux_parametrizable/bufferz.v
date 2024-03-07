module bufferz #(parameter maxnum=3)(
input en,
input [$clog2(maxnum)-1] entrada,
output reg [$clog2(maxnum)-1] salida
);
always @* begin
    if (en)begin
        salida = entrada;
        end
    else begin
        salida = {($clog2(maxnum){1'b0})};
	end
 end
endmodule
