module extend (output logic [31:0] ImmExt,
                input logic [31:0] Instr,
                input logic [2:0] ImmSrc);

always_comb begin
  case (ImmSrc)
    3'b000: ImmExt = {{20{Instr[31]}}, Instr[31:20]}; // I-Type
      
    3'b001: ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[17:11]}; // S-Type
      
    3'b010: ImmExt = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0}; // B-Type
      
    3'b011: ImmExt = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}; // J-Type
    
    3'b100: ImmExt = {{12{Instr[31]}}, Instr[31:12]}; // U-Type ??????
  endcase
end

endmodule


