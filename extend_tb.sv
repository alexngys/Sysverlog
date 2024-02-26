`timescale 1ns/1ps
`include "extend.sv"

module extend_tb;
  logic [31:0] ImmExt, Instr;
  logic [2:0] ImmSrc;

  extend dut (ImmExt, Instr, ImmSrc);

  initial begin
    $dumpfile("extend_tb.vcd");
    $dumpvars(0, extend_tb);

    // Test 1: I-Type 
    Instr = 32'b00000000110001001000010000010011; // addi rd, rs1 imm | 8 9 12
    ImmSrc = 3'b000; // I-Type
    #10; // Wait for 10ns
    

  end

  initial begin
    $monitor("Time = %0t ns, ImmExt = %b (Hex: %h), Instr = %b, ImmSrc = %b", 
              $time, ImmExt, ImmExt, Instr, ImmSrc);
  end
endmodule
