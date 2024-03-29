`timescale 1ns/1ps
`include "alu.sv"

module alu_tb;
logic [31:0] t_ALUResult, t_SrcA, t_SrcB;
logic [2:0] t_ALUControl;
logic t_Zero;

alu dut (t_ALUResult, t_Zero, t_SrcA, t_SrcB, t_ALUControl);

initial begin      
  $dumpfile("alu_tb.vcd"); 
  $dumpvars(0, alu_tb);
  t_ALUControl = 0; t_SrcA = 4; t_SrcB = 3; // add 4 3 7
  #10 t_ALUControl = 1; t_SrcA = 4; t_SrcB = 3; // sub 4 3 1
  #10 t_ALUControl = 2; t_SrcA = 0; t_SrcB = 0; // and 0 0 0
  #10 t_ALUControl = 2; t_SrcA = 1; t_SrcB = 0; // and 1 0 0
  #10 t_ALUControl = 2; t_SrcA = 0; t_SrcB = 1; // and 0 1 0 
  #10 t_ALUControl = 2; t_SrcA = 1; t_SrcB = 1; // and 1 1 1
  #10 t_ALUControl = 3; t_SrcA = 0; t_SrcB = 0; // or 0 0 0
  #10 t_ALUControl = 3; t_SrcA = 1; t_SrcB = 0; // or 1 0 1
  #10 t_ALUControl = 3; t_SrcA = 0; t_SrcB = 1; // or 0 1 1
  #10 t_ALUControl = 3; t_SrcA = 1; t_SrcB = 1; // or 1 1 1
  #10 t_ALUControl = 4; t_SrcA = 4; t_SrcB = 3; // lui / b 4 3 3
  #10 t_ALUControl = 5; t_SrcA = 4; t_SrcB = 3; // slt 4 3 0 1
  #10 t_ALUControl = 5; t_SrcA = 3; t_SrcB = 3; // slt 4 3 0 1
  #10 t_ALUControl = 5; t_SrcA = 3; t_SrcB = 4; // slt 4 3 1 0
  #10;
end

initial begin                             // Response monitor

$monitor("t_ALUResult = %d t_Zero = %d t_SrcA = %d t_SrcB = %d t_Zero = %d", 
          t_ALUResult, t_Zero, t_SrcA, t_SrcB, t_Zero);
end
endmodule
