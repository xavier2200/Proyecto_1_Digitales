module imm #(parameter N = 64)(
    input [N/2-1:0] in,
    output reg [N-1:0] out
);

reg [11:0] inmediato;
reg [1:0] opcode;

always @* begin

    opcode= {in[6:5]};

        case (opcode)
            {2'b10} : begin
                inmediato= {in[N/2-1:20]};
            end

            {2'b11} : begin
                inmediato ={in[N/2-1:25],in[11:7]};
            end
            {2'b00} : begin
                inmediato={in[N/2-1],in[7],in[30:25],in[11:8]};
            end
            
            {2'b01} : begin
                inmediato={in[N/2-1],in[7],in[30:25],in[11:8]};
            end
            default: inmediato=0;
        endcase
        
       out= $signed(inmediato);
end


endmodule