// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_monitor.sv
// DESCRIPTION    : This class is passive agent monitor. It receive the DUT
//                  output via interface and sends to score board for checking.
// -----------------------------------------------------------------------------


`ifndef CNT_MONITOR
`define CNT_MONITOR

//--------------------------------------------------------------------------------
// Class       : cnt_monitor
// Parent      : agent
// Description : This class defines uvm component monitor.
//--------------------------------------------------------------------------------
class cnt_monitor extends uvm_monitor;
  `uvm_component_utils(cnt_monitor)

  virtual cnt_if           m_if;
  virtual cnt_if_reset_clk m_if_reset_clk;

  uvm_analysis_port#(cnt_transaction) m_port;
  uvm_event#(cnt_transaction)      drv2mon;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name, uvm_component parent);
    super.new (name, parent);
    m_port = new("m_port", this);
  endfunction : new

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase
  // Description : This is build phase of this class it receives the handle for
  //               virtual interface.
  //------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Geting pin level transaction interface
    if (!uvm_config_db#(virtual interface cnt_if)::get(this," ","m_if",m_if)) begin
      `uvm_fatal("cnt_monitor", "Didn't received interface from top")
    end
    else begin
      `uvm_info ("cnt_monitor", "Received interface from top", UVM_MEDIUM)
    end

    // Getting clock and reset interface
    if (!uvm_config_db#(virtual interface cnt_if_reset_clk) :: get(this, "", "m_if_reset_clk", m_if_reset_clk)) begin
      `uvm_fatal("cnt_monitor", "Didn't received clk and reset interface from top")
    end
    else begin
      `uvm_info ("cnt_monitor", "Received clock and reset interface from top", UVM_MEDIUM)
    end

    // Getting driver to monitor event from agent
    if (!uvm_config_db#(uvm_event#(cnt_transaction)) :: get(this, "", "drv2mon", drv2mon)) begin
      `uvm_fatal("cnt_monitor", "Didn't received event handle from agent")
    end
    else begin
      `uvm_info ("cnt_monitor", "Received event handle from agent", UVM_MEDIUM)
    end    
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : run_phase
  // Argument    : phase
  // Description : This is run phase of the class it perform when receive
  //               trigger from driver and sends the recieved transaction to
  //               exports.
  //------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    cnt_transaction m_tnx;
    forever begin
      `uvm_info ("cnt_monitor", "Waiting for Trigger from Driver", UVM_HIGH)
      drv2mon.wait_trigger_data(m_tnx);
      `uvm_info ("cnt_monitor", "Received Trigger from Driver", UVM_HIGH)
      `uvm_info ("cnt_monitor", "Reading data from DUT", UVM_HIGH)
      m_tnx.out_data = m_if.m_cb.out_data;
      m_tnx.rst      = m_if_reset_clk.rst;
      `uvm_info ("cnt_monitor", $sformatf("DUT output data : %0d",m_tnx.out_data), UVM_LOW)
      `uvm_info ("cnt_monitor", "Broadcasting Data from monitor", UVM_HIGH)
      m_port.write(m_tnx);
    end 
  endtask : run_phase
endclass : cnt_monitor
`endif // CNT_MONITOR
