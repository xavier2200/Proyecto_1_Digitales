`timescale 1ns / 1ns

module data_memory_tb;

parameter W = 32;
parameter N = 5;

         

logic [W-1:0] wrt_data;      //dato a almacenar

logic [W-1:0] rd_data;

logic [N-1:0] addr;

logic clk;
logic rst;

logic memread;
logic memwrite;

integer i;

data_memory #(.W(W), .N(N)) dut (
    .clk(clk),
    .MemRead(memread),
    .MemWrite(memwrite),
    .write_data(wrt_data),
    .read_data(rd_data),
    .address(addr)
);
initial begin
clk=0;
rst=0;

memread=0;
memwrite=0;

wrt_data=0;
addr=0;

for (i = 0;i<N ;i=i+1 ) begin
    memwrite = 1'b1;
    addr=i;
    
    #10;
    wrt_data=$urandom_range(W);
    #10;                //guarda el dato random
    memwrite = 1'b0;
    #10
    memread = 1'b1;
    #10;
    $display("Operand1 = %b", rd_data);     //muestra el dato random guardado
    #10;
    memread = 1'b0;

end

$finish;

end



endmodule
