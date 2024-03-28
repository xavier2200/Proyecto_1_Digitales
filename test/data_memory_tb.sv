`timescale 1ns / 1ps

module data_memory_tb;

parameter W = 32;
parameter N = 5;

logic clk = 0;
logic rst = 0;

logic memread = 0;
logic memwrite = 0;         

logic [W-1:0] wrt_data;      //dato a almacenar

logic [W-1:0] rd_data;

logic [$clog2(N)-1:0] addr;

integer i

data_memory dut#(.W(W), .N(N))(
    .clk(clk),
    .Memread(memread),
    .Memwrite(memwrite),
    .write_data(wrt_data),
    .read_data(rd_data),
    .address(addr)
);

for (i = 0;i<N ;i=++ ) begin
    wrt_data=$urandom_range(2**W);
    #10;
    memwrite = 1'b1;
    #10;                //guarda el dato random
    memwrite = 1'b0;
    #10
    memread = 1'b1;
    #10;
    $display("Operand1 = %b", rd_data);     //muestra el dato random guardado
    #10;
    memread = 1'b0;

end

endmodule
