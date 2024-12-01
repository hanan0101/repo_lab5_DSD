`timescale 1ns / 1ps
module tb_shfitReg;
    parameter n = 8; 
    logic clk;        
    logic rst_n;    
    logic en_shift;
    logic dataIN;   
    logic [n-1:0] q;    
    // Instantiate 
    shift_regsiter #(n) DUT(.clk(clk), .rst_n(rst_n), .en_shift(en_shift), .dataIN(dataIN), .q(q));
 initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
initial begin 
    $display("Time---reset--shit enabale---data in  parallel output"); 
    $monitor("%t---%b--%b---%b--%b",$time,rst_n,en_shift,dataIN,q ); 
    //case 1
     rst_n =0;
     en_shift=0;
     dataIN=0;
     #10;
     //case 2
     rst_n =1;
     en_shift=0;
     dataIN=0;
     #10;
      //case 3
     en_shift=1;
     dataIN=0;
     #10;
     //case 4 DO multi shiting 
    dataIN=1; #10;
    dataIN=0; #10;
    dataIN=1; #10;
    dataIN=0;#10;
    dataIN=1;#10;    
     //case 5
     en_shift=0;
     dataIN=1;
     #10;     
     //case 6
     en_shift=1;
     dataIN=0;
     #10;  
  $finish;
  
end


endmodule






