
`timescale 1ns / 1ps

module ModN_Counter#(
    parameter N = 100,
    localparam WIDTH = $clog2(N)
) (
    input  logic clk,
    input  logic resetn,
    input  logic load,
    input  logic en,
    input  logic clr,
    input  logic up_down,
    input  logic [WIDTH - 1: 0] d,
    output logic [WIDTH - 1: 0] q,
    output logic [WIDTH - 1: 0] counter_out // Output for internal counter value
); 
    nbit_counter #(.n(WIDTH)) dut(
        .clk(clk),
        .resetn(resetn),
        .load(load),
        .en(en),
        .clr(clr),
        .up_down(up_down),
        .d(d),
        .count(counter_out)
    );
 
    always @(*) begin 
        if (counter_out == N && up_down == 0) // Reset when counting up
            q = 0;
        else if (counter_out == 0 && up_down == 1) // Reset when counting down
            q = N-1;
        else 
            q = counter_out; 
    end
    
endmodule