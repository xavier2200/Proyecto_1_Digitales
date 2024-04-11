//`timescale 100ns / 1ps


module processor_top#(

parameter DATA_WIDTH_t = 64,                 //ALU, reg, imm, shift, mux 1 2 
parameter INSTRUC_WIDTH_t = 32,              //ALU_CONTROL, Data_memory, inst_memory X , sumadorb, mux 3
parameter address_data_mem_t = 6,            //Data_memory .N x
parameter ADDRESS_WIDTH_inst_memory_t = 32,  // inst_memory X , PC_COUNTER X
parameter MEM_SIZE_t=256,                    // inst_memory X
parameter width_instruc_main_control_t = 7,  //main_control
parameter NumRegs_t    = 32,                 //regfile  
parameter IndexWidth_t = $clog2(NumRegs_t),    //regfile
parameter const_sumador_pc_t = 4             //sumador_pc


//parameter DATA_WIDTH = 64, //ALU X

//parameter width_instruc = 32, //ALU_CONTROL X

// parameter W = 32, //Data_memory X
// parameter N=5,   //Data_memory  X

// parameter N = 64, //imm X


//  parameter DATA_WIDTH=32,    // inst_memory X
//  parameter ADDRESS_WIDTH=32, // inst_memory X
//  parameter MEM_SIZE=256      // inst_memory X

//  parameter width_instruc = 7 //main control X

//  parameter ADDRESS_WIDTH = 32 //pc_counter X
 
//  parameter DataWidth  = 64,  //regfile X
//  parameter NumRegs    = 32,  //regfile X            
//  parameter IndexWidth = $clog2(NumRegs) //regfile X
  
//  parameter N=32 //shift X
  
//  parameter N = 4 //sumador_pc X
  
//  parameter N = 4 //sumadorb X

//  parameter ancho=3 // mux X

) (
    
    input logic rst_t,clk_t,
    
    output logic [DATA_WIDTH_t-1:0] ALU_O_t,
    output logic [DATA_WIDTH_t-1:0] read_data_o_t
    
    );
 
 
 // Cables de conexion   
    logic [INSTRUC_WIDTH_t-1:0] w_pc_out;
    logic [INSTRUC_WIDTH_t-1:0] w_INSTRUCTION;
    
    logic [INSTRUC_WIDTH_t-1:0] w_addpc_out;
    
    logic [INSTRUC_WIDTH_t-1:0] w_addBranch_out;
    
    logic [INSTRUC_WIDTH_t-1:0] w_mux3_to_pc;
    
    logic w_ALUSrc; 
    logic w_MemtoReg;
    logic w_RegWrite; 
    logic w_MemRead; 
    logic w_MemWrite; 
    logic w_Branch;
    logic [1:0] w_ALUOp;
    
    logic sel_mux_3;
    logic w_zero;
    
    logic [DATA_WIDTH_t-1:0] w_data_in;
    logic [DATA_WIDTH_t-1:0] w_data1;
    logic [DATA_WIDTH_t-1:0] w_data2;
    
    logic [DATA_WIDTH_t-1:0] w_imm_to_shift;
    
    logic [DATA_WIDTH_t-1:0] w_mux1_to_ALU;
    
    logic [INSTRUC_WIDTH_t-1:0] w_shift_to_addbranch;
    
    logic [1:0] w_alu_inst;
    
    logic [DATA_WIDTH_t-1:0] w_ALU_RESULT;
    
    logic [DATA_WIDTH_t-1:0] w_data_memory_read;
    
    
    
//Modulos    
pc_counter#(.ADDRESS_WIDTH(ADDRESS_WIDTH_inst_memory_t)) PC (
.rst(rst_t),
.clk(clk_t),
.PC_next(w_mux3_to_pc),
.address_o(w_pc_out)
);
    

inst_memory #(.DATA_WIDTH(INSTRUC_WIDTH_t), .ADDRESS_WIDTH(ADDRESS_WIDTH_inst_memory_t),.MEM_SIZE(MEM_SIZE_t)) instruction_mem (
    .address(w_pc_out),              //Read address
   .instruction(w_INSTRUCTION)       //Instruction
);
    
sumadorpc #(.N(INSTRUC_WIDTH_t)) addPC (
    .a_i(w_pc_out),
    
    .sum_o(w_addpc_out)
    
);

sumadorb #(.N(INSTRUC_WIDTH_t) )addBranch(
    .a_i(w_pc_out),
    .b_i(w_shift_to_addbranch),

    .sum_o(w_addBranch_out)
    
);    
    
ALU #(.DATA_WIDTH(DATA_WIDTH_t)) alu_ins (
    .data_rs1(w_data1),
    .source_2(w_mux1_to_ALU),
    .alu_inst(w_alu_inst),
    .ALU_result(w_ALU_RESULT),
    .zero(w_zero)
);

ALU_CONTROL #(.width_instruc(INSTRUC_WIDTH_t)) alu_control_ins (
    .instruccion(w_INSTRUCTION), 
    .ALU_OP(w_ALUOp),
    .alu_inst(w_alu_inst)
);

data_memory #( .W(DATA_WIDTH_t) ,.N(address_data_mem_t)) data_memory_ins (
   .clk(clk_t),
    .rst(rst_t),

   .address(w_ALU_RESULT), //direcición de 'consulta 1'
   .MemRead(w_MemRead), //habilitación de lectura
   .MemWrite(w_MemWrite), //habilitación de escritura
   .write_data(w_data1), //valor de almacenamiento
    
    //a la salida mostramos el contenido de la memoria
   .read_data(w_data_memory_read)
);


mux #(.ancho(DATA_WIDTH_t)) mux_1 (
.sel(w_ALUSrc),
.in_1(w_data2),
.in_2(w_imm_to_shift),
.salida(w_mux1_to_ALU)
);

mux #(.ancho(DATA_WIDTH_t)) mux_2 (
.sel(w_MemtoReg),
.in_1(w_ALU_RESULT),
.in_2(w_data_memory_read),
.salida(w_data_in)
);

mux #(.ancho(INSTRUC_WIDTH_t)) mux_3 (
.sel(sel_mux_3),
.in_1(w_addpc_out),
.in_2(w_addBranch_out),
.salida(w_mux3_to_pc)
);

imm #(.N(DATA_WIDTH_t))immediate_g(
    .in(w_INSTRUCTION),
   .out(w_imm_to_shift)    
 );
    

    
main_control #(.width_instruc(width_instruc_main_control_t)) main_control (
    .opcode(w_INSTRUCTION[6:0]),
    
    .ALUSrc(w_ALUSrc), 
    .MemtoReg(w_MemtoReg),
    .RegWrite(w_RegWrite), 
    .MemRead(w_MemRead), 
    .MemWrite(w_MemWrite), 
    .Branch(w_Branch),
    .ALUOp(w_ALUOp)
 
);



reg_file #(.DataWidth(DATA_WIDTH_t),.NumRegs(NumRegs_t),.IndexWidth(IndexWidth_t)) registers (
  .clk(clk_t),
  .rst(rst_t),
  .writeEn(w_RegWrite),
  .writeData(w_data_in),	//Datos de entrada de ancho [DataWidth-1:0]
  
  .writeAddr(w_INSTRUCTION[11:7]),
  .readAddr1(w_INSTRUCTION[19:15]),	// direccion de los registros N registros
  .readAddr2(w_INSTRUCTION[24:20]),
  .readData1(w_data1),
  .readData2(w_data2)
);

shift #(.N(DATA_WIDTH_t))shifter(
.in(w_imm_to_shift),
.out(w_shift_to_addbranch)
);



assign sel_mux_3 = w_Branch && w_zero; // Compuerta and de branch y zero 

assign ALU_O_t = w_ALU_RESULT ;
assign read_data_o_t = w_data_memory_read;
    

endmodule
