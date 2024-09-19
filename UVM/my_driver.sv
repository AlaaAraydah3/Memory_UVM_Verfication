
class my_driver extends uvm_driver#(my_sequence_item);
  `uvm_component_utils(my_driver)
  
   my_sequence_item seq_item;
   virtual intf my_vif;
  
  function new(string name = "my_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      if(!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
  endfunction
        
  function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(seq_item); 
      @(negedge my_vif.clk)
      my_vif.Data_in <= seq_item.Data_in; 
      my_vif.Address <= seq_item.Address;
      my_vif.En      <= seq_item.En;
      my_vif.Rr_en   <= seq_item.Rr_en;
      my_vif.Rw_en   <= seq_item.Rw_en;
      my_vif.rst     <= seq_item.rst;
      seq_item_port.item_done();
    end
  endtask
  
endclass
