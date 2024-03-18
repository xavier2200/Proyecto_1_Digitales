module mux #(parameter N=4)(
input [1:0] sel,
input [N-1:0] in [3:0],
input aux,
output reg auxiliar,
output reg [N-1:0] salida
);

always @* begin
    case (sel)
       2'b00 : begin
            salida = in[0]; 
            auxiliar = 1'b0;
        end
        
       2'b01 : begin
            salida = in[1];
            auxiliar = 1'b0; 
        end
        
       2'b10 : begin
            salida = in[2];
            auxiliar = 1'b0;
        end
        
       2'b11 : begin
            salida = in[3];
            auxiliar = aux;
        end
       default: begin
            salida = in[0];
            auxiliar = 1'b0;
         end 
     endcase
end
endmodule