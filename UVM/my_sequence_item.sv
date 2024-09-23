

class my_sequence_item extends uvm_sequence_item;
   `uvm_object_utils(my_sequence_item)

  
  function new (string name = "my_sequence_item");
    super.new(name);
  endfunction
  
  rand logic En, rst,Rr_en,Rw_en;
  logic        Valid_out ;
  logic        [31:0] Data_out;
  randc logic  [3:0] Address  ;
  rand  logic  [31:0] Data_in ;
  

    constraint Rw_Rr       {{Rr_en != Rw_en};}
    constraint rst_en      { rst     dist {0:=50,1:=5};}

    constraint address     {Address  dist {[0:15]:/100};}
    constraint data_in     {Data_in  dist {32'h0:=0.5, [32'd1:32'd254]:/100 ,32'd255:=0.5};} 
endclass
