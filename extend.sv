module extend (output logic [31:0] ImmExt,
                input logic [31:0] Instr,
                input logic [2:0] ImmSrc);
always_comb begin
  case (ImmSrc)
    3'b000: begin // I-Type
      ImmExt = {{20{Instr[31]}}, Instr[31:20]};
    end
    3'b001: begin // S-Type
      ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:17]};
    end
    3'b010: begin // B-Type
      ImmExt = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
    end
    3'b011: begin // J-Type
      ImmExt = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};
    end
    3'b100: begin // U-Type ??????
      ImmExt = {{20{Instr[31]}}, Instr[31:20]};
    end
  endcase
end

endmodule


