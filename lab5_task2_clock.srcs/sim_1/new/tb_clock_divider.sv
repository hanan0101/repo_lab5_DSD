`timescale 1ns / 1ps
module tb_clock_divider;
parameter N = 100;
logic clk;
logic resetn;
logic pulses;
Clock_Divider#(.N(N)) clk_divider(
    .clk(clk),
    .reset(resetn),
    .pulses(pulses)
);
always begin
    #5 clk = ~clk; // 10 ns period clock
end
initial begin
    // Initialize Inputs
    clk = 0;
    resetn = 1;
    // Wait 100 ns for global reset to finish
    #100;
    // Release reset
    resetn = 0;   
    #10;
    resetn = 1;
    // Simulate for 800 ns to match your waveform
    #800; 
    resetn = 0; 
    #10;
    resetn = 1;
    // End simulation
    $finish;
end
// Monitor the signals
initial begin
    $monitor("Time %t: clk = %b, resetn = %b, pulses = %b", $time, clk, resetn, pulses);
end
endmodule
