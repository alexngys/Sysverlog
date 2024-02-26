`timescale 1ns/1ps
`include "extend.sv"

module extend_tb;
  logic [31:0] t_ImmExt, t_Instr;
  logic [2:0] t_ImmSrc;

  extend dut (t_ImmExt, t_Instr, t_ImmSrc);

  initial begin
    $dumpfile("extend_tb.vcd");
    $dumpvars(0, extend_tb);
    t_Instr = 32'b00000000110001001000010000010011; t_ImmSrc = 3'b000; // I-Type addi rd, rs1 imm | 8 9 12
    #10 t_Instr = 32'b11111110011110011010110100100011; t_ImmSrc = 3'b001; // S Type sw
    #10 t_Instr = 32'b00000001111001000000100001100011; t_ImmSrc = 3'b010; // B Type beq
    #10 t_Instr = 32'b01111111100010100110000011101111; t_ImmSrc = 3'b011; // J Type jal
    #10 t_Instr  = 32'b10001100110111101111101010110111; t_ImmSrc = 3'b100; // U Type lui
    #10;  
  end

  initial begin
    $monitor("Time = %0t ns, t_ImmExt = %b (Hex: %h), t_Instr = %b, t_ImmSrc = %b", 
              $time, t_ImmExt, t_ImmExt, t_Instr, t_ImmSrc);
  end
endmodule
