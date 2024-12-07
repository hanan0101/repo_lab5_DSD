`timescale 1ns / 1ps

module nbit_counter #(
    parameter n = 8
)(
    input  logic clk,
    input  logic resetn,
    input  logic load,
    input  logic clr,
    input  logic en,
    input  logic up_down,
    input  logic [n - 1: 0] d,
    output logic [n - 1: 0] count
);
    logic [n-1 : 0] counter;
    
    always @(posedge clk or negedge resetn) begin 
        if (~resetn) 
            counter <= {n{1'b0}}; // Reset count to 0 on active-low reset
        else if (clr)
            counter <= 0;
        else begin 
            if (load) // Load value d into count if load is high
                counter <= d;
            else if (en) begin 
                if (up_down == 0) // Count up if up_down is low
                    counter <= counter + 1; 
                else 
                    counter <= counter - 1; // Count down if up_down is high
            end
        end
    end

    assign count = counter;

endmodule