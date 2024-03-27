`timescale 1ns / 1ps

module pc_counter#(

    parameter ADDRESS_WIDTH = 32
)
(
input logic  rst,clk,
input logic  [ADDRESS_WIDTH-1:0] PC_next,

output logic [ADDRESS_WIDTH - 1 : 0] address_o
);

always_ff @(posedge clk) begin 
    if (rst) begin
        address_o <= 32'b0;
    end else begin
        address_o <= PC_next;
    end
end       
    
endmodule
