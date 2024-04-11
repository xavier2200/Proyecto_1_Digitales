`timescale 100ns / 1ps // funciona con un clock de 10MGHhz

// Recuperado de [https://circuitcove.com/design-examples-register-file/]
//Adaptado con una señal de reset

module reg_file #(
  parameter DataWidth  = 64,  //Ancho de bus parametrizado
  parameter NumRegs    = 32,  // Numero de registros parametrizasdo                  
  parameter IndexWidth = $clog2(NumRegs) // Calculo del indice para la cantidad los registros
  ) 
  (
  input  logic                  clk,
  input  logic                  rst,
  input  logic                  writeEn,
  input  logic [DataWidth-1:0] 	writeData,	//Datos de entrada de ancho [DataWidth-1:0]
  
  input  logic [IndexWidth-1:0] writeAddr,
  input  logic [IndexWidth-1:0] readAddr1,	// direccion de los registros N registros
  input  logic [IndexWidth-1:0] readAddr2,
  output logic [DataWidth-1:0]  readData1,
  output logic [DataWidth-1:0]  readData2
);

  logic [DataWidth-1:0] regs[NumRegs]; // Se crea un arreglo de [NumRegs] registros de ancho [DataWidth-1:0]

always_ff @(posedge clk) begin 

    if (rst) begin  
        foreach (regs[i]) begin  
            regs[i] <= 0;  // inicializo todos los registros en cero
        end
    end else begin
      if (writeEn) begin 		// si hay señal de write Enable
        regs[writeAddr] <= writeData; 	// Ubico el registro en la dirección [writeAddr] y le escribo el contenido de [Write_data]
      end
    end
  end

  assign readData1 = regs[readAddr1];    // Asigno la salida readData1 como la dirección de [readAddr1] dentro del arreglo de registros
  assign readData2 = regs[readAddr2];   // Asigno la salida readData2 como la dirección de [readAddr2] dentro del arreglo de registros

endmodule