`timescale 1ns / 1ps


module Clock_Divider#(
parameter N = 100,
localparam WIDTH = $clog2(N/2)
)(
input logic clk,
input logic  reset ,
output logic pulses
);

logic en_count = 1'b1; // count is enable
logic pulse_out;
logic [WIDTH-1:0] count;
 
 ModN_Counter#(.N(N)) clock_divider(
    .clk(clk),
    .load(1'b0),
    .up_down(1'b1),
    .resetn(reset), //test
    .en(en_count),
    .clr(pulse_out),
    .d(0),
    .counter_out(count)
    
); 
    assign pulse_out = (count == (N/2)-1); // divied when counter reach n-1  
        
 flip_flop ff(
    .clk(clk),
    .rst(reset),
    .en(pulse_out),
    .D(~pulses),
    .Q(pulses)
);
    
      
endmodule
