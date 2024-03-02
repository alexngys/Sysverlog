module data_memory_and_io (output logic [31:0] RD, CPUOut,
                            input logic [31:0] A, WD, CPUIn,
                            input logic WE, CLK);

logic [7:0] DM [0:1023];
logic RDsel, WEM, WEOut;

// if WE is 0 / RD output mode
assign RDsel = (A == 32'hFFFFFFFC) ? 1 : 0; // if A RDsel == 1 and read CPUIn else memory

assign RD = (RDsel) ? CPUIn : {DM[A+3], DM[A+2], DM[A+1], DM[A]}; // RD/Output is CPUIn or memory

// if WE is 1 / CPUInOut mode
always_comb
begin
   if ((WE) & (A == 32'hFFFFFFFC)) begin  // Write memory to CPUOut
        WEOut = 1; // Write to memory
        WEM = 0; // Write to CPUOut
    end
    else if ((WE) & (A != 32'hFFFFFFFC)) begin // Write CPUIn to memory
        WEOut = 0;
        WEM = 1;
    end
    else begin // Do nothing
        WEOut = 0;
        WEM = 0;
    end        
end

always_ff @ (posedge CLK)
begin
    if (WEM)  {DM [A+3], DM [A+2], DM [A+1], DM [A]} <= WD; // Write WD/PC to memory
    if (WEOut) CPUOut <= WD; // Write WD/PC to CPUOut
end

endmodule
