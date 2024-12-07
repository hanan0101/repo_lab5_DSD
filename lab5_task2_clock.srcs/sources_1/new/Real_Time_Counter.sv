module Real_Time_Counter#(
    parameter N = 100,
    localparam WIDTH = $clog2(N)
) (
    input logic clk,
    input logic resetn,
    input logic en,
    input logic load,
    input logic clr,
    input logic up_down,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q,
    output logic [WIDTH-1:0] counter_out // New output for counter value
); 
    logic pulses_divided;
         
    Clock_Divider#(.N(N)) DUT0(
        .clk(clk),
        .reset(resetn),
        .pulses(pulses_divided)
    );
    ModN_Counter #(.N(N)) uut (
        .clk(pulses_divided),
        .resetn(resetn),
        .load(load),
        .en(en),
        .clr(clr),
        .up_down(up_down),
        .d(d),
        .q(q),
        .counter_out(counter_out) // Pass the counter value out
    );
endmodule