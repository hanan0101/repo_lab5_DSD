`timescale 1ns / 1ps

module tb_realTime_counter;
    parameter N = 6;
    parameter WIDTH = $clog2(N);
    logic clk;
    logic resetn;
    logic en;
    logic load;
    logic clr;
    logic up_down;
    logic [WIDTH-1:0] q;
    logic [WIDTH-1:0] counter_out;

    // Instantiate the Real_Time_Counter
    Real_Time_Counter #(.N(N)) rtc (
        .clk(clk),
        .resetn(resetn),
        .en(en),
        .load(load),
        .clr(clr),
        .up_down(up_down),
        .d(0),
        .q(q),
        .counter_out(counter_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        resetn = 0; 

        // Assert reset
        #10;resetn = 0; 
        #10 resetn = 1; // Deassert reset
        en = 1; 
        load = 0; 
        up_down = 0; // Count up
        clr = 0; // No clear
#10000;
d=3'b010;
load =1; 
        // Wait for the clock divider to generate pulses
        #1000000000; // Wait for 1 second to see the first count
        clr = 1; // Assert clear (optional)
        #10 clr = 0; // Deassert clear (optional, depending on your design)

        // Wait for additional time to observe behavior
        #500000000; // Wait for 5 seconds
        $finish; // End simulation
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t: q = %b, counter_out = %b", $time, q, counter_out);
    end
endmodule