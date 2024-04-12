module inst_memory #(
    parameter DATA_WIDTH=32,
    parameter ADDRESS_WIDTH=32, // EN REALIDAD NO NECESITAMOS TODOS LOS BITS POR EL TAMAÑO DE LA MEMORY
    parameter MEM_SIZE=10
) (
    input logic [ADDRESS_WIDTH-1:0] address,
    output logic [DATA_WIDTH-1:0] instruction
);
    
    //creación del espacio de memory

    reg [DATA_WIDTH-1:0] inst_memory[MEM_SIZE-1:0];


    initial begin
        $readmemh("program_sencillo.hex",inst_memory,0,9);
    end

    assign instruction=inst_memory[address[9:2]]; //hacer en data memory
    
endmodule
