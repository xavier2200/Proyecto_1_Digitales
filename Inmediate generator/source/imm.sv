module imm #(parameter N = 4)(
    input [N/2-1:0] in,
    output [N-1:0] out
);

wire [11:0] inmediato;
wire opcode [1:0];

always @* begin

    opcode= in[6:5];

        case (opcode)
            2'b10 : begin
                inmediato= in[N/2-1:20];
            end

            2'b11 : begin
                inmediato [11:5]=in[N/2-1:25];
                inmediato [4:0] =in[11:7];
            end
            2'b01 or 2'b00 : begin
                inmediato[11]=in[N/2-1];
                inmediato[10]=in[7];
                inmediato[9:4]=in[30:25];
                inmediato[3:0]=in[11:8]
            end
            default: inmediato=0;
        endcase
end



assign out= $signed(inmediato);

endmodule