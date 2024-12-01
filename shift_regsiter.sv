module shift_regsiter  #(
    parameter n = 8) (// Width of the registe(
    input logic clk,        // Clock signal
    input logic rst_n,      // Asynchronous active-low reset
    input logic en_shift,
    input logic dataIN,    // Input data
    output logic [n-1:0] q // Output      *
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 8'b00000000;  // Reset the shift register to all zeros
        else if (en_shift)
            begin
                q[7] <= q[6];
                q[6] <= q[5];
                q[5] <= q[4];
                q[4] <= q[3];
                q[3] <= q[2];
                q[2] <= q[1];
                q[1] <= q[0];
                q[0] <= dataIN;  // Shift right
            end
    end
endmodule