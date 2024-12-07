`timescale 1ns / 1ps

module FF(
    input logic clk,
    input logic reset,
    input logic d,
    output logic Q,
    output logic Qbar
);

 logic q_master,Qbar_master;

D_latch master (
    .d(d),                 // Data input
    .clk(~clk),             // Enable controlled by inverted clock (transparent when clk is low)
    .reset(reset),             // Active high reset
    .Q(q_master),
    .Qbar(Qbar_master)           // Master latch output
);

// Slave latch
D_latch slave (
    .d(q_master),          // Data input from master latch
    .clk(clk),              // Enable controlled by clock (transparent when clk is high)
    .reset(reset),             // Active high reset
    .Q(Q),
    .Qbar(Qbar)                  // Final output
);



endmodule


