class my_monitor extends uvm_monitor;
 `uvm_component_utils(my_monitor)
  
  my_sequence_item seq_item;
  virtual intf my_vif;
  
  uvm_analysis_port#(my_sequence_item) my_analysis_port; // 1 inst port
  
 
  function new (string name = "my_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      if(!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
      my_analysis_port = new("my_analysis_port", this); // 2 handle
      seq_item = my_sequence_item::type_id::create("seq_item");
  endfunction
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
  endfunction

  
  task run_phase(uvm_phase phase);
   super.run_phase(phase);
    
  forever begin
   #10;
    @( my_vif.cb) 
      seq_item.Data_in    = my_vif.Data_in;
      seq_item.Address    = my_vif.Address;
      seq_item.Data_out   = my_vif.Data_out;
      seq_item.Valid_out  = my_vif.Valid_out;
      seq_item.En         = my_vif.En ;
      seq_item.Rr_en      = my_vif.Rr_en;
      seq_item.Rw_en      = my_vif.Rw_en;
      seq_item.rst        = my_vif.rst;
      // Send the captured data to analysis port
      my_analysis_port.write(seq_item);
     
   end
   endtask
endclass
