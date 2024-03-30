module mux #(parameter ancho=3)(
input  logic sel,
input  logic [ancho-1:0] in_1,
input  logic [ancho-1:0] in_2,
output logic [ancho-1:0] salida
);

always @* begin
    case (sel)
        1'b0 : salida=in_1;
        1'b1 : salida=in_2;
        default: salida=in_1;
    endcase
end
endmodule