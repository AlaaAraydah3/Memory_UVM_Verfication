
`include "uvm_macros.svh"
`include "memory.sv"
`include "intf.sv"
import uvm_pkg::*;

module top;
  bit clk;
  always #5 clk = ~clk;

  import memory_pkg::*;
  intf in1 (clk);
  // Instantiate the memory module and pass the interface
  mem mem_inst (.in1(in1));

  initial begin
    clk = 0;
    uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "my_vif", in1);
    run_test("my_test");
  end
endmodule
