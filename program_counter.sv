module program_counter (output logic [31:0] PC, PCPlus4,
                        input logic [31:0] PCTarget, ALUResult,
                        input logic [1:0] PCSrc, 
                        input logic Reset, CLK);
logic [31:0] PCNext, PCPlus4Out, PCOut;

mux_3_to_1 mux_3_to_1(PCNext,PCPlus4Out,PCTarget,ALUResult,PCSrc);
pc pc(PCOut,PCNext,CLK,Reset);
adder_4 adder_4(PCPlus4Out,PCOut);
assign PC=PCOut;
assign PCPlus4 = PCPlus4Out;
endmodule

module mux_3_to_1 (output logic [31:0] mux_out,
                    input logic [31:0] a, b, c,
                    input logic [1:0] select);
always_comb begin
    case(select)
        2'b00: mux_out = a;   // If select is 00, output a
        2'b01: mux_out = b;   // If select is 01, output b
        2'b10: mux_out = c;   // If select is 10, output c
        default: mux_out = 32'bx; // Undefined state
    endcase
end

endmodule

module pc (output logic [31:0] pc_out, 
            input logic [31:0] pc_in,  
            input logic clk, reset);
            
always_ff @(posedge reset or posedge clk) 
begin
    if (reset) pc_out <= 32'b0; // Reset PC to 0
    else pc_out <= pc_in; // Update PC with the input value
end

endmodule

module adder_4 (output logic [31:0] PCPlus4,
                  input logic [31:0] PC);
    assign PCPlus4 = PC + 32'd4;
endmodule
