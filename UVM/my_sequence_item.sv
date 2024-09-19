
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
    constraint rst_en      { rst     inside {0,1};}
    constraint address     {Address  inside {[0:15]};}
    constraint data_in     {Data_in  dist {[0 :600]:/50, [601 : 900]:/40, [901 : $]:/50};}
endclass
