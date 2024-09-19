
class my_sequence extends uvm_sequence;
  `uvm_object_utils(my_sequence)
  
   my_sequence_item seq_item;
  
  function new(string name = "my_sequence");
    super.new(name);
  endfunction
  
  task pre_body;
   seq_item = my_sequence_item::type_id::create("seq_item"); 
  endtask
  
  task reset ;
     repeat(5) begin
       start_item(seq_item);
        assert (seq_item.randomize() with {seq_item.rst == 1;})
               else 
               $error("randomization error") ;
        finish_item(seq_item);
      end
  endtask
 
  task write ;
      repeat(100)begin
        start_item(seq_item);
          assert(seq_item.randomize()with {seq_item.rst == 0 ;seq_item.Rw_en == 1 ;seq_item.En ==1 ;})
           else 
           $error("randomization error") ;
        finish_item(seq_item);
      end
  endtask 
  
  task read ;
    repeat(50)begin
     start_item(seq_item);
       assert(seq_item.randomize()with {seq_item.rst == 0 ;seq_item.Rr_en == 1 ;seq_item.En ==1 ;})
          else 
          $error("randomization error") ;
     finish_item(seq_item);
    end
  endtask
  
   
  task body();
      reset();
      write();
      read ();
    endtask
endclass

class write_read_seq extends my_sequence ;
  `uvm_object_utils(write_read_seq)
    my_sequence_item seq_item; 
    
    int i;   
    int max_loop= 200;
  
  function new(string name = "write_read_seq");
    super.new(name);
  endfunction

   task pre_body;
   seq_item = my_sequence_item::type_id::create("seq_item"); 
   endtask

  task write;
    start_item(seq_item);
      assert(seq_item.randomize()with {seq_item.rst == 0 ;seq_item.Rw_en == 1 ;seq_item.En ==1 ;})
         else 
         $error("randomization error") ;
    finish_item(seq_item);
  endtask

  task read;
     start_item(seq_item);   
       assert(seq_item.randomize()with {seq_item.rst == 0 ;seq_item.Rr_en == 1 ;seq_item.En ==1 ;})
         else 
         $error("randomization error") ;
      finish_item(seq_item);
  endtask

  task body;
    for( i= 0 ; i<max_loop ; i++ )begin
        if (i%2!=0)begin
          write;
        end else begin
          read;
      end
      end
    endtask
endclass
    
    
