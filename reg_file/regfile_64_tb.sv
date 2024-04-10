`timescale 100ns / 1ps

module regfile_64_tb;

  parameter W_tb = 64;                  // Ancho de bus parametrizado
  parameter N_tb = 32;                   // Numero de registros parametrizado                  
  parameter IndexWidth = $clog2(N_tb);   // Calculo del indice para la cantidad de registros

  logic clk_tb;
  logic rst_tb;
  logic we_tb;
  logic [W_tb-1:0] data_in_tb;             //Datos de entrada de ancho [W-1:0]
  logic [IndexWidth-1:0] addr_rd_tb;
  logic [IndexWidth-1:0] addr_rs1_tb;  // direccion de los registros N registros
  logic [IndexWidth-1:0] addr_rs2_tb;
  logic [W_tb-1:0] rs1_tb;
  logic [W_tb-1:0] rs2_tb;

  reg_file #(
  .DataWidth(W_tb),  //Ancho de bus parametrizado
  .NumRegs(N_tb),  // Numero de registros parametrizasdo                  
  .IndexWidth(IndexWidth) // Calculo del indice para la cantidad los registros
  ) reg_dut(
    .clk(clk_tb),
    .rst(rst_tb),
    .writeEn(we_tb),
    .writeData(data_in_tb),
    .writeAddr(addr_rd_tb),
    .readAddr1(addr_rs1_tb),
    .readAddr2(addr_rs2_tb),
    .readData1(rs1_tb),
    .readData2(rs2_tb)
  );

  always #5 clk_tb = ~clk_tb; // Invierte el valor de clk_tb cada 5 unidades de tiempo

  initial begin
    $dumpfile("regfile_64_tb.vcd"); // Especifica el nombre del archivo VCD
    $dumpvars(1, regfile_64_tb); // Define el alcance de la generación del VCD
    rst_tb = 1;
    clk_tb = 0;
    data_in_tb = 0;
    addr_rs1_tb = 0;
    addr_rs2_tb = 0;
    we_tb = 0;
    
    #10;
    
    rst_tb = 0;
    
    // Llenado de registros con valor 1111...
    for (integer i = 1; i < N_tb; i++) begin
        addr_rd_tb = i; // Selecciona el registro a llenar
        data_in_tb = 64'hFFFFFFFFFFFFFFFF; // Valor "1111..." de 64 bits en hexadecimal
        we_tb = 1; // Habilita la escritura
        #10; // Espera un poco antes de cambiar de registro
        we_tb = 0; // Desactiva la escritura
    end
    
    // Mostrar contenido de los registros
    $display("Contenido de los registros:");
    for (integer i = 0; i < N_tb; i++) begin
        addr_rs1_tb = i; // Selecciona el registro a mostrar
        addr_rs2_tb = i-1; // Selecciona el registro a mostrar
        #5; // Espera un poco para que la lectura se complete
        if (rs1_tb !== 64'hFFFFFFFFFFFFFFFF) begin
            $display("Error: El registro %0d no contiene el valor esperado (hFFFFFFFFFFFFFFFF...)", i);
        end else begin
            $display("Registro %0d: %h", i, rs1_tb);
        end
    end

    $finish;
  end

endmodule
