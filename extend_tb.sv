`timescale 1ns/1ps
`include "extend.sv"

module extend_tb;
  logic [31:0] ImmExt, Instr;
  logic [2:0] ImmSrc;

  extend dut (ImmExt, Instr, ImmSrc);

  initial begin
    $dumpfile("extend_tb.vcd");
    $dumpvars(0, extend_tb);

    Instr = 32'b00000000110001001000010000010011; ImmSrc = 3'b000; // I-Type addi rd, rs1 imm | 8 9 12
    #10; Instr = 32'b11111110011110011010110100100011; ImmSrc = 3'b001; // S Type sw
    #10; Instr = 32'b00000001111001000000100001100011; ImmSrc = 3'b010; // B Type beq
    #10; Instr = 32'b01111111100010100110000011101111; ImmSrc = 3'b011; // J Type jal
    #10; Instr  = 32'b10001100110111101111101010110111; ImmSrc = 3'b100; // U Type lui
    #10;  

  end

  initial begin
    $monitor("Time = %0t ns, ImmExt = %b (Hex: %h), Instr = %b, ImmSrc = %b", 
              $time, ImmExt, ImmExt, Instr, ImmSrc);
  end
endmodule
