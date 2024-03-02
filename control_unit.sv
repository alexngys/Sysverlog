module control_unit (output logic [1:0] PCSrc, ResultSrc,
                    output logic MemWrite, ALUSrc, RegWrite,
                    output logic [2:0] ALUControl, ImmSrc,
                    input logic [31:0] Instr,
                    input logic Zero);

// Decode opcode, funct3, and funct7 from the instruction
wire [6:0] opcode = Instr[6:0];
wire [2:0] funct3 = Instr[14:12];
wire [6:0] funct7 = Instr[31:25];

always_comb begin

    // Set default values
    RegWrite = 1;
    ImmSrc = 3'b000;
    ALUSrc = 0;
    ALUControl = 3'b000; 
    MemWrite = 0;
    ResultSrc = 2'b00;
    PCSrc = 2'b00;

    case (opcode)
      7'b0110011: begin
        case (funct3)
          3'b000: ALUControl = (funct7 == 7'b0100000) ? 3'b001 : 3'b000; // SUB or ADD
          3'b110: ALUControl = 3'b011; // OR
          3'b111: ALUControl = 3'b010; // AND
          3'b010: ALUControl = 3'b101; // SLT    
        endcase
      end
      7'b0010011: begin // I-Type (Imm ALU Ops)
        ALUSrc = 1;
        case (funct3)
          3'b000: ALUControl = 3'b000; // ADDI
          3'b110: ALUControl = 3'b011; // ORI
          3'b111: ALUControl = 3'b010; // ANDI
        endcase
      end
      7'b0000011: begin // LW
        ALUSrc = 1;
        ALUControl = 3'b000; 
        ResultSrc = 2'b01;
      end
      7'b0100011: begin // SW
        RegWrite = 0;
        ImmSrc = 3'b001;
        ALUSrc = 1;
        ALUControl = 3'b000; 
        MemWrite = 1;
        ResultSrc = 2'bx;
      end
      7'b1100011: begin // BEQ
        RegWrite = 0;
        ImmSrc = 3'b010;
        ALUControl = 3'b001; 
        PCSrc= (Zero == 1) ? 2'b01 : 2'b00;
      end
      7'b1101111: begin // JAL
        ImmSrc = 3'b011;
        ALUSrc = 1'bx;
        ALUControl = 3'bx; 
        ResultSrc = 2'b10;
        PCSrc= 2'b01;
      end
      7'b1100111: begin // JALR
        ALUSrc = 1;
        ALUControl = 3'b000; 
        ResultSrc = 2'b10;
        PCSrc= 2'b10;
      end
      7'b0110111: begin // LUI
        ImmSrc = 3'b100;
        ALUSrc = 1;
        ALUControl = 3'b100; 
      end
    endcase
end
endmodule