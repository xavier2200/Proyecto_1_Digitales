module data_memory #(
parameter W = 32,
parameter N=5
)(
    input logic clk,
    
    input logic [$clog2(N)-1:0] address, //direcición de 'consulta 1'
    //input logic rst,
    input logic MemRead, //habilitación de lectura
    input logic MemWrite, //habilitación de escritura
    input logic [W-1:0] write_data, //valor de almacenamiento
    
    //a la salida mostramos el contenido de la memoria
    output logic [W-1:0] read_data
);
//creamos propiamente el registro: 
reg  [W-1:0] mem[N-1:0] ;


always_ff @(posedge clk) begin
    if (MemWrite) begin 
        mem[address]<=write_data;
    end else if (MemRead) begin
        read_data <= mem[address];
    end    
end

endmodule

