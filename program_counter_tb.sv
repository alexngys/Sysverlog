`timescale 1ns/1ps
`include "program_counter.sv"

module program_counter_tb;
logic [31:0] t_PC, t_PCPlus4, t_PCTarget, t_ALUResult;
logic [1:0] t_PCSrc;
logic t_Reset, t_CLK;

program_counter dut (t_PC, t_PCPlus4, t_PCTarget, t_ALUResult, t_PCSrc, t_Reset, t_CLK);   

initial begin
  t_CLK = 0;
  forever #10 t_CLK = ~t_CLK;  
end 

initial begin
  #200 $finish;
end

initial begin      
  $dumpfile("program_counter_tb.vcd"); 
  $dumpvars(0, program_counter_tb);
  t_PCSrc = 1; t_Reset = 0; t_PCTarget = 0; t_ALUResult = 4; 
  #10 t_PCSrc = 0; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 0; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 0; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 1; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 1; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 1; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 1; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 2; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 2; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 2; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 2; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 0; t_Reset = 1; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 0; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10 t_PCSrc = 0; t_Reset = 0; t_PCTarget = 2; t_ALUResult = 4;
  #10;
end

initial begin                             // Response monitor

$monitor("t_PC = %d t_PCPlus4 = %d t_PCTarget = %d t_ALUResult = %d t_PCSrc = %d t_Reset = %d t_CLK = %d", 
          t_PC, t_PCPlus4, t_PCTarget, t_ALUResult, t_PCSrc, t_Reset, t_CLK);
end
endmodule
