class my_subscriber extends uvm_subscriber#(my_sequence_item);
  `uvm_component_utils(my_subscriber)
   my_sequence_item seq_item;
  
  int final_cover;
  
  covergroup group_1;
        Address: coverpoint seq_item.Address 
         {
          bins addr_bins = {[0:15]};  
         }
    
        rst: coverpoint seq_item.rst 
        {
         bins rst_L    = {0};
         bins rst_H    = {1};
         bins rst_L2H  = (0=>1); 
         bins rst_H2L  = (1=>0);
         }
    
         Rr_en: coverpoint seq_item.Rr_en
         {
         bins read_L    = {0};
         bins read_H    = {1};
         bins read_L2H  = (0=>1); 
         bins read_H2L  = (1=>0);
         }
    
         Rw_en: coverpoint seq_item.Rw_en
         {
          bins write_L   = {0};
          bins write_H   = {1};
          bins write_L2H = (0=>1); 
          bins write_H2L = (1=>0);
          }

          En: coverpoint seq_item.En 
          {
           bins en_L   = {0};
           bins en_H   = {1};
           bins en_L2H = (0=>1); 
           bins en_H2L = (1=>0);
          }
    
          Valid_out : coverpoint seq_item.Valid_out
          {
           bins V_L   = {0};
           bins V_H   = {1};
           bins V_L2H = (0=>1);
           bins V_H2L = (1=>0);
          }
    
          Data_in: coverpoint seq_item.Data_in
          {
          bins data_in1 = {[0:$]};
          }
    
          Data_out: coverpoint seq_item.Data_out 
          {
          bins data_o1 = {[0:$]};
          }
          // cross1: cross Address, Data_in ;
  endgroup

   
  function new(string name, uvm_component parent);
    super.new(name, parent);
    group_1 = new();
  endfunction
  
  function void write(input my_sequence_item seq_item);
    this.seq_item = seq_item; // Assign the sequence item to class-level variable
    // Sample the coverage group with the sequence item
    group_1.sample();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq_item = my_sequence_item::type_id::create("seq_item");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    final_cover = group_1.get_coverage();
    `uvm_info(get_type_name(), $sformatf("Final Coverage is: %0f", final_cov), UVM_LOW);
    
  endfunction
 
endclass
