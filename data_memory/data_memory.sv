module data_memory #(
parameter W = 32,
parameter N=5
)(
    input logic clk,

    input logic [W-1:0] address, //direcición de 'consulta 1'
    input logic rst,
    input logic MemRead, //habilitación de lectura
    input logic MemWrite, //habilitación de escritura
    input logic [W-1:0] write_data, //valor de almacenamiento
    
    //a la salida mostramos el contenido de la memoria
    output logic [W-1:0] read_data
);
//creamos propiamente el registro: 
reg  [W-1:0] mem[(2**N)-1:0] ;

initial begin
        $readmemh("programa_inst.hex",mem,0,9);
end

always_ff @(posedge clk) begin
    if (MemWrite) mem[address[(2**N)-1:2]]<=write_data;
end
assign read_data = (MemRead & !rst) ? mem[address[(2**N)-1:2]] : 0;

endmodule

