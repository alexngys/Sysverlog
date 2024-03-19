`timescale 1ns / 1ps
`include "risc_v.sv"

module risc_v_tb;
logic [31:0] CPUOut, CPUIn;
logic Reset, CLK;

risc_v dut (CPUOut, CPUIn, Reset, CLK);

initial begin  // Generate clock signal with 20 ns period
  CLK = 0;
  forever #10 CLK = ~CLK;
end

initial begin  // Apply stimulus
  $dumpfile("risc_v_tb.vcd");
  $dumpvars(0, risc_v_tb);
  CPUIn = 32'd8; Reset = 1;  // Reset the CPU
  #20; Reset = 0; // Instr 1: addi x1, x0, 50 
  #20;  // Instr 2: lw x2, -4(x0)
  #20;  // Instr 3: sub x3, x1, x2
  #20;  // Instr 4: sw x3, -4(x0)
  #20;  // Instr 5: beq x0, x0, 0 
  #20;  
  #20;  
  #20;  
  #20;  
  #20;  
  #20;  
  #20;  
  #20;  
  #20; 
  #20;
  $finish;
end

always@(negedge CLK)
  $display("t = %3d, CPUIn = %d, CPUOut = %d, Reset = %b, PCSrc = %b PC = %d, PCTarget = %h, ImmExt = %h, Instr = %h, ALUResult = %d",
            $time, CPUIn, CPUOut, Reset, dut.PCSrc, dut.PC, dut.PCTarget, dut.ImmExt, dut.Instr, dut.ALUResult);

endmodule

