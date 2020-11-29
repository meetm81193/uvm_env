// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_agent.sv
// DESCRIPTION    : This is the agent class. It instanciate monitor, driver, 
//                  sequencer based on the configuration set in the
//                  enviornment. 
// -----------------------------------------------------------------------------

// Check that analysis imports are connected.
`define CHECK_PORT_CONNECTION(PORT) \
  begin \
    uvm_port_list list; \
    PORT.get_provided_to(list); \
    if (!list.size()) begin \
      `uvm_error("AP_CONNECT", \
        $sformatf("Analysis port %s not connected.", PORT.get_full_name())); \
    end \
    else `uvm_info("AP_CONNECT",$sformatf("Analysis port %s connected.",PORT.get_name()),UVM_MEDIUM) \
  end
`ifndef CNT_AGENT_SV
`define CNT_AGENT_SV  

//--------------------------------------------------------------------------------
// Class       : cnt_agent
// Parent      : enviornment
// Description : This class defines uvm component agent.
//--------------------------------------------------------------------------------
class cnt_agent extends uvm_agent;
  `uvm_component_utils(cnt_agent)

  cnt_sequencer m_sequencer;
  cnt_driver    m_driver;
  cnt_monitor   m_monitor;
  uvm_event#(cnt_transaction)     drv2mon;

  uvm_analysis_port #(cnt_transaction) m_port;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name, uvm_component parent);
    super.new (name, parent);
    drv2mon = new("drv2mon");

   // Creating m_port
    m_port = new ("m_port", this);
  endfunction : new

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase
  // Description : This is build phase of this class create object of
  //               sequencer, driver and monitor.
  //------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_sequencer = cnt_sequencer::type_id::create("m_sequencer", this);
    m_driver    = cnt_driver::type_id::create("m_driver", this);
    m_monitor   = cnt_monitor::type_id::create("m_monitor", this);

   // Sending event to driver and monitor.
   uvm_config_db#(uvm_event#(cnt_transaction)) :: set (this,"m_monitor", "drv2mon", drv2mon);
   uvm_config_db#(uvm_event#(cnt_transaction)) :: set (this,"m_driver", "drv2mon", drv2mon);
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : connect_phase
  // Argument    : phase
  // Description : This is connect phase of this class it connects sequencer
  //               and driver.
  //------------------------------------------------------------------------------
  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
      m_monitor.m_port.connect(m_port);
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
  endfunction : connect_phase

  //------------------------------------------------------------------------------
  // Method      : end_of_elaboration_phase
  // Argument    : phase
  // Discription : checking the port connection.
  //------------------------------------------------------------------------------
  function void end_of_elaboration_phase (uvm_phase phase);
    super. end_of_elaboration_phase (phase);
    `CHECK_PORT_CONNECTION(m_port)
  endfunction : end_of_elaboration_phase
endclass : cnt_agent
`endif // CNT_AGENT_SV  
