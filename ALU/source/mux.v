module mux #(parameter N=4)(
input [1:0] sel,
input [N-1:0] in [3:0],
output [N-1:0] salida
);

always @* begin
    case (sel)
       2'b00 : salida = in[0];
       2'b01 : salida = in[1]; 
       2'b10 : salida = in[2];
       2'b11 : salida = in[3];
        default: 
    endcase
end