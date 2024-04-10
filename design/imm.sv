module imm #(parameter N = 64)(
    input logic [N/2-1:0] in,
    output logic [N-1:0] out
);

reg [11:0] inmediato;
reg [6:0] opcode;

always @* begin

    opcode= {in[6:0]};

        case (opcode)
            {7'b0000011} : begin
                inmediato= {in[31:20]};				//load double
            end

            {7'b0100011} : begin
                inmediato ={in[31:25],in[11:7]};			//store double
            end

            {7'b1100011} : begin
                inmediato={in[31],in[7],in[30:25],in[11:8]};		//branch if equal

            end
            
            default: inmediato=0;					//default
        endcase
        
       out= $signed(inmediato);
end


endmodule
