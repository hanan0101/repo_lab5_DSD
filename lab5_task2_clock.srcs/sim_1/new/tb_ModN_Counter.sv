`timescale 1ns / 1ps
module ModN_Counter_tb;
    parameter N = 6;
    parameter WIDTH = $clog2(N);

    logic clk;
    logic resetn;
    logic load;
    logic en;
    logic clr;  // Added clr signal
    logic up_down;
    logic [WIDTH - 1:0] d;
    logic [WIDTH - 1:0] q;
    logic [WIDTH - 1:0] counter_out ;

    ModN_Counter #(.N(N)) uut (
        .clk(clk),
        .resetn(resetn),
        .load(load),
        .en(en),
        .clr(clr), // Include clr in the instance
        .up_down(up_down),
        .d(d),
        .q(q),
        .counter_out(counter_out)
    );
    always begin
        #5 clk = ~clk; // 10 ns period clock
    end
    initial begin
        
        // Initialize Inputs
        clk = 0;
        resetn = 1;  // Start with reset active

        resetn = 0;  // Start with reset active
        load = 0;
        en = 0;
        clr = 0; // Initialize clr
        up_down = 0; // Start with counting up
        d = 0;
        // Wait 100 ns for global reset to finish
        #100;
        // Release reset
        resetn = 1;
        // Enable counting
        en = 1;
        #5000; 
        // 2. Load a value and count up
        load = 1;
        d = 50; 
        #10; // Allow some time for load to take effect
        load = 0;
        #10000; // Wait for 100 counts at 10 ns per count (1 second in simulation)
        // Change to counting down
        up_down = 1;
        #15000; // Wait for 150 counts down
        
        // End simulation
        $finish;
    end

    // Monitor the counter values
    initial begin
        $monitor("Time %t: q = %d count= %d", $time, q,counter_out);
    end

endmodule