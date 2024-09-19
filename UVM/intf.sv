interface intf(input logic clk);
  
 logic  rst;
 logic  En;
 logic [3:0] Address;
 logic [31:0] Data_in;
 logic [31:0] Data_out;
 logic Valid_out;
 logic Rw_en;
 logic Rr_en;
  
  clocking cb @(posedge clk );
     default input #1step output #1step;
    input  Data_in;
    input  Address;
    input  Rw_en;
    input  Rr_en;
    input  rst;
    output Data_out;
    output Valid_out;
   endclocking
  
endinterface 
