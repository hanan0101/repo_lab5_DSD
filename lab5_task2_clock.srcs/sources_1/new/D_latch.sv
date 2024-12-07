`timescale 1ns / 1ps

module D_latch(

    input logic clk,
    input logic d,
    input logic reset, // Changed to Reset_L to indicate active low
    output logic Q,
    output logic Qbar 
);
    
    logic Dout, Rout, Qout;
    
    
    // Basic D-latch with active-low asynchronous reset
    assign Dout = ~(clk & d); 
    assign Rout = ~(clk & (~d));
    
    // Modified for active-low reset
    // When Reset_L is 0, Q should be forced to 0 and Qbar to 1
    
 
    assign Qout = ~(Dout & Qbar);
    assign Q=((reset)& Qout);
    assign Qbar = ~(Rout & Q); 
    
endmodule