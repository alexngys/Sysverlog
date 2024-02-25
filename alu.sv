module alu (output logic [31:0] ALUResult,
            output logic Zero,
            input logic [31:0] SrcA, SrcB,
            input logic [2:0] ALUControl);

logic [31:0] MuxOut ;

always_comb begin
  case (ALUControl)
    3'b000: MuxOut = SrcA + SrcB; // ADD
      
    3'b001: MuxOut = SrcA - SrcB; // SUB
      
    3'b010: MuxOut = SrcA & SrcB; // AND
      
    3'b011: MuxOut = SrcA | SrcB; // OR
      
    3'b100: MuxOut = SrcB; // LUI / B
      
    3'b101: MuxOut = (SrcA < SrcB) ? 32'b1 : 32'b0; // SLT
      

  endcase
  ALUResult = MuxOut;
  Zero = (MuxOut == 32'b0) ? 1'b1 : 1'b0; 
end

endmodule

