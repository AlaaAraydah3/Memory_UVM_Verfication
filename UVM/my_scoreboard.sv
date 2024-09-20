
class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)
   my_sequence_item seq_item ;
  
  int total_write;
  int total_rst;
  int total_read;
  int correct_read;
  logic [31:0] mem_reg [15:0];  
  
  // Declare analysis imp to directly receive transactions
  uvm_analysis_imp#(my_sequence_item, my_scoreboard) my_analysis_imp;

  function new(string name = "my_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Create analysis imp with callback to write method
    my_analysis_imp = new("my_analysis_imp", this);
    seq_item = my_sequence_item::type_id::create("seq_item");
  endfunction

  function void write (input my_sequence_item seq_item);
     
    this.seq_item = seq_item ;

    
    if (seq_item.rst)begin 
      total_rst++;
      $display(" RESET ");
    end else 
    if (seq_item.Rw_en) begin
      total_write++;
      mem_reg[seq_item.Address] = seq_item.Data_in;
      `uvm_info(get_type_name(), $sformatf("[write]: Address=%0d, Data_in=%0h", seq_item.Address, seq_item.Data_in), UVM_LOW)
      $display  (" WRITE" );
    end else 
    if (seq_item.Rr_en ) begin
        total_read++;
       `uvm_info(get_type_name(), $sformatf("[read]: Address=%0d, Data_out=%0h", seq_item.Address, seq_item.Data_out), UVM_LOW)
      $display (" READ ");
      
        if (seq_item.Data_out === mem_reg[seq_item.Address]) begin
             correct_read++;
          $display("[scorebored_PASS] \n Address      = %0d \n Expected Data= %0d \n Actual   Data= %0d"
                 , seq_item.Address, mem_reg[seq_item.Address], seq_item.Data_out);
        end
   
    end 
    else begin
      $display("[Scoreboard Failure]");
    end    

  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
  
  
  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("total  reset = %0d", total_rst), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total  write = %0d", total_write), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total  read  = %0d", total_read), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total correct read =  %0d", correct_read), UVM_LOW)
  endfunction
endclass
