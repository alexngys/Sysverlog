`include "instruction_memory.sv"
`include "reg_file.sv"
`include "extend.sv"
`include "alu.sv"
`include "data_memory_and_io.sv"
`include "program_counter.sv"
`include "control_unit.sv"

module risc_v(output logic [31:0] CPUOut,
                input logic [31:0] CPUIn,
                input logic Reset, CLK);

logic [31:0] Instr, WD3, RD1, RD2, SrcA, SrcB, ALUResult, WD, RD, Result, ImmExt, PCTarget, PCNext, PC, PCPlus4;
logic [4:0]  A1, A2, A3;
logic        MemWrite, ALUSrc, RegWrite, Zero;
logic [2:0]  ALUControl;
logic [2:0]  ImmSrc;
logic [1:0]  ResultSrc;
logic [1:0]  PCSrc;

assign WD3 = Result;
assign SrcA = RD1;
assign WD = RD2;
assign PCTarget = ImmExt + PC;
assign A1 = Instr[19:15];
assign A2 = Instr[24:20];
assign A3 = Instr[11:7];
instruction_memory instruction_memory(Instr,PC);
reg_file reg_file(RD1,RD2,WD3,A1,A2,A3,RegWrite,CLK);
extend extend(ImmExt,Instr,ImmSrc);
alu alu(ALUResult,Zero,SrcA,SrcB,ALUControl);
data_memory_and_io data_memory_and_io(RD,CPUOut,ALUResult,WD,CPUIn,MemWrite,CLK);
program_counter program_counter(PC,PCPlus4,PCTarget,ALUResult,PCSrc,Reset,CLK);
control_unit control_unit(PCSrc,ResultSrc,MemWrite,ALUSrc,RegWrite,ALUControl,ImmSrc,Instr,Zero);

SrcB_MUX SrcB_MUX(SrcB,RD2,ImmExt,ALUSrc);
Result_Mux Result_Mux(Result,ALUResult,RD,PCPlus4,ResultSrc);

endmodule


module SrcB_MUX(output logic [31:0] SrcB,
                input logic [31:0] RD2, ImmExt,
                input logic ALUSrc);
always_comb begin
    case(ALUSrc)
        1'b0: SrcB = RD2;   // If select is 00, output RD2
        1'b1: SrcB = ImmExt;   // If select is 01, output ImmExt
        default: SrcB = 32'bx; // Undefined state
    endcase
end
endmodule

module Result_Mux (output logic [31:0] Result,
                    input logic [31:0] ALUResult, RD, PCPlus4,
                    input logic [1:0] ResultSrc);
always_comb begin
    case(ResultSrc)
        2'b00: Result = ALUResult;   // If select is 00, output ALUResult
        2'b01: Result = RD;   // If select is 01, output RD
        2'b10: Result = PCPlus4;   // If select is 10, output PCPlus4
        default: Result = 32'bx; // Undefined state
    endcase
end
endmodule