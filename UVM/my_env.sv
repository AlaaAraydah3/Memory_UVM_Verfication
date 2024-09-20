class my_env extends uvm_env;
  `uvm_component_utils(my_env)

  my_agent      agent;
  my_subscriber subscriber;
  my_scoreboard scoreboard;
  virtual intf my_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the agent//subscriber// scoreboard
    agent      = my_agent::type_id::create     ("agent"     , this);
    subscriber = my_subscriber::type_id::create("subscriber", this);
    scoreboard = my_scoreboard::type_id::create("scoreboard", this);

    // Get the virtual interface and set it for the agent
    if (!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
    
       uvm_config_db#(virtual intf)::set(this, "agent", "my_vif", my_vif);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect the agent's analysis port directly to the scoreboard's analysis imp
    agent.my_analysis_port.connect(scoreboard.my_analysis_imp);
    // Connect the agent's analysis port to the subscriber's analysis export
    agent.my_analysis_port.connect(subscriber.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
endclass
