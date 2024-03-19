`timescale 1ns/1ps
`include "control_unit.sv"

module control_unit_tb;
logic [31:0] t_Instr;
logic [2:0] t_ALUControl, t_ImmSrc;
logic [1:0] t_PCSrc, t_ResultSrc;
logic t_MemWrite, t_ALUSrc, t_RegWrite, t_Zero;

control_unit dut(t_PCSrc, t_ResultSrc, t_MemWrite, t_ALUSrc, t_RegWrite, t_ALUControl, t_ImmSrc, t_Instr, t_Zero);

initial begin      
  $dumpfile("control_unit_tb.vcd");
  $dumpvars(0, control_unit_tb);
  t_Instr = 32'b00000000000000000000000000110011; t_Zero = 0; // add 0000000 0000000000 000 00000 0110011
  #10 t_Instr = 32'b00100000000000000000000000110011; t_Zero = 0; //sub 0010000 0000000000 000 00000 0110011
  #10 t_Instr = 32'b00000000000000000110000000110011; t_Zero = 0; // or 0000000 0000000000 110 00000 0110011
  #10 t_Instr = 32'b00000000000000000111000000110011; t_Zero = 0; // and 0000000 0000000000 111 00000 0110011
  #10 t_Instr = 32'b00000000000000000010000000110011; t_Zero = 0; // slt 0000000 0000000000 010 00000 0110011
  #10 t_Instr = 32'b00000000000000000000000000010011; t_Zero = 0; // addi 0000000 0000000000 000 00000 0010011
  #10 t_Instr = 32'b00000000000000000110000000010011; t_Zero = 0; // ori 0000000 0000000000 110 00000 0010011
  #10 t_Instr = 32'b00000000000000000111000000010011; t_Zero = 0; // andi 0000000 0000000000 111 00000 0010011
  #10 t_Instr = 32'b00000000000000000010000000000011; t_Zero = 0; // lw 0000000 0000000000 010 00000 0000011
  #10 t_Instr = 32'b00000000000000000010000000100011; t_Zero = 0; // sw 0000000 0000000000 010 00000 0100011
  #10 t_Instr = 32'b00000000000000000000000001100011; t_Zero = 0; // beq 0000000 0000000000 000 00000 1100011 and zero = 0
  #10 t_Instr = 32'b00000000000000000000000001100011; t_Zero = 1; // beq 0000000 0000000000 000 00000 1100011 and zero = 1
  #10 t_Instr = 32'b00000000000000000000000001101111; t_Zero = 0; // jal 0000000 0000000000 000 00000 1101111
  #10 t_Instr = 32'b00000000000000000000000001100111; t_Zero = 0; // jalr 0000000 0000000000 000 00000 1100111
  #10 t_Instr = 32'b00000000000000000000000000110111; t_Zero = 0; // lui 0000000 0000000000 000 00000 0110111
  #10;
end

initial begin                             // Response monitor

$monitor("t_PCSrc = %d t_ResultSrc = %d t_MemWrite = %d t_ALUSrc = %d t_RegWrite = %d t_ALUControl = %d t_ImmSrc = %d t_Instr = %d t_Zero = %d", 
          t_PCSrc, t_ResultSrc, t_MemWrite, t_ALUSrc, t_RegWrite, t_ALUControl, t_ImmSrc, t_Instr, t_Zero);
end
endmodule
