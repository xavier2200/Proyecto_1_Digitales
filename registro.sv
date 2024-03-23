module registro #(
parameter W = 32,
parameter N=5
)(
    input logic clk,
    //ancho reg_numer-1 es el ancho de las direcciones
    //Necesitamos recibir las direcciónes de los registros a leer y/o dirección de registro de destino

    input logic [N-1:0] rs1, //direcición registro de 'consulta 1'
    input logic [N-1:0] rs2, //dirección registro de consulta '2'
    input logic [N-1:0] rd, //direccion de registro destino
    input logic rst,
    input logic we, //habilitación de escritura
    input logic [W-1:0] data_in, //valor de almacenamiento
    
    //a la salida mostramos el contenido de los registros 
    output logic [W-1:0] data_rs1,
    output logic [W-1:0] data_rs2
   

);
//creamos propiamente el registro: 
reg  [W-1:0] registers[(2**N)-1:0] ;

//asignación de la salida: en estos debemos observar el contenido de rs1 y/ rs2 según la instrucción
always_comb begin: read
    if(rs1 != 0)
        data_rs1=registers[rs1];
    else
        data_rs1=32'b0;

    if (rs2 != 0)
        data_rs2 = registers[rs2];
    else
        data_rs2=32'b0;
end

always_ff @(posedge clk) begin : write

    if (we && (rd != 0)) 
        registers[rd]<=data_in;
    
//En el flanco de reloj, si tenemos activada la escritura y la dirección de escritura no es 0 (registro inmutable),
// entonces le asignamos al registro rd, el contenido de data_in

end

endmodule

