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
  t_Instr = 51; t_Zero = 0; // add 0000000 0000000000 000 00000 0110011
  #10 t_Instr = 671088691; t_Zero = 0; //sub 0010100 0000000000 000 00000 0110011
  #10 t_Instr = 24627; t_Zero = 0; // or 0000000 0000000000 110 00000 0110011
  #10 t_Instr = 28723; t_Zero = 0; // and 0000000 0000000000 111 00000 0110011
  #10 t_Instr = 8243; t_Zero = 0; // slt 0000000 0000000000 010 00000 0110011
  #10 t_Instr = 19; t_Zero = 0; // addi 0000000 0000000000 000 00000 0010011
  #10 t_Instr = 24595; t_Zero = 0; // ori 0000000 0000000000 110 00000 0010011
  #10 t_Instr = 28691; t_Zero = 0; // andi 0000000 0000000000 111 00000 0010011
  #10 t_Instr = 8195; t_Zero = 0; // lw 0000000 0000000000 010 00000 0000011
  #10 t_Instr = 8227; t_Zero = 0; // sw 0000000 0000000000 010 00000 0100011
  #10 t_Instr = 99; t_Zero = 0; // beq 0000000 0000000000 000 00000 1100011
  #10 t_Instr = 111; t_Zero = 0; // jal 0000000 0000000000 000 00000 1101111
  #10 t_Instr = 103; t_Zero = 0; // jalr 0000000 0000000000 000 00000 1100111
  #10 t_Instr = 55; t_Zero = 0; // lui 0000000 0000000000 000 00000 0110111
  #10;
end

initial begin                             // Response monitor

$monitor("t_PCSrc = %d t_ResultSrc = %d t_MemWrite = %d t_ALUSrc = %d t_RegWrite = %d t_ALUControl = %d t_ImmSrc = %d t_Instr = %d t_Zero = %d", 
          t_PCSrc, t_ResultSrc, t_MemWrite, t_ALUSrc, t_RegWrite, t_ALUControl, t_ImmSrc, t_Instr, t_Zero);
end
endmodule
