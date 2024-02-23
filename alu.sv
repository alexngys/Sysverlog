module alu (output logic [31:0] ALUResult,
            output logic Zero,
            input logic [31:0] SrcA, SrcB,
            input logic [2:0] ALUControl);
logic BInvert [31:0], MuxOut [31:0], Sum[31:0], AndOut[31:0], OrOut[31:0], ZeroExtOut[31:0], 6MuxOut[31:0];

// assign BInvert = ! SrcB;
// mux_2_to_1(MuxOut,SrcB,BInvert,ALUControl[0]);
// enable_adder(Sum,MuxOut,SrcA,ALUControl[0]);
// zero_ext(ZeroExtOut,Sum);
// and (AndOut,SrcA,SrcB);
// or (OrOut,SrcA,SrcB);
// mux_6_to_1(6MuxOut,Sum,Sum,AndOut,OrOut,SrcB,ZeroExtOut,ALUControl);
// assign ALUResult = 6MuxOut;
// assign Zero = ~(|6MuxOut); // NotSure?
always_comb begin
  case (ALUControl)
    3'b000: begin // ADD
      MuxOut = SrcA + SrcB
    end
    3'b001: begin // SUB
      MuxOut = SrcA - SrcB
    end
    3'b010: begin // AND
      MuxOut = SrcA & SrcB
    end
    3'b011: begin // OR
      MuxOut = SrcA | SrcB
    end
    3'b100: begin // LUI / B
      MuxOut = SrcB
    end
    3'b101: begin // SLT
      MuxOut = SrcA < SrcB ? 32'b1 : 32'b0;
    end
  endcase
  assign ALUResult = MuxOut;
  assign Zero = (MuxOut == 32'b0) ? 1'b1 : 1'b0; // NotSure?
end

endmodule

module mux_2_to_1 (output logic [31:0] mux_out,
                    input logic [31:0] a, b,
                    input logic select);
 
assign mux_out = (select) ? b : a ;
endmodule

module mux_6_to_1 (output logic [31:0] mux_out,
                    input logic [31:0] a, b, c, d, e, f
                    input logic [2:0] select);
always_comb begin
    case(select)
        3'b000: y = a;   // If select is 00, output a
        3'b001: y = b;   // If select is 01, output b
        3'b010: y = c;   // If select is 10, output c
        3'b011: y = e;   // If select is 00, output a
        3'b100: y = f;   // If select is 01, output b
        3'b101: y = g;   // If select is 10, output c
        default: y = 32'bx; // Undefined state
    endcase
end
endmodule

module enable_adder(output logic [31:0] adder_out,
                      input logic [31:0] a, b,
                      input logic enable);
assign  adder_out = (enable) ? a + b : 32'bx;

endmodule

module zero_ext (output logic [31:0] out, 
                  input logic [31:0] in);
// Check if the input is all zeros
assign out = (in == 32'd0) ? 32'd0 : 32'd1;

endmodule
