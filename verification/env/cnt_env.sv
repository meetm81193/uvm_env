// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_env.sv
// DESCRIPTION    : This enviornment class createss object of agent and score
//                  board along with connecting agent and scoreboard using
//                  port.
// -----------------------------------------------------------------------------


`ifndef CNT_ENV_SV
`define CNT_ENV_SV

//--------------------------------------------------------------------------------
// Class       : cnt_env
// Parent      : test
// Description : This class declares random variable and constraint variable.
//               along with modifier methods.
//--------------------------------------------------------------------------------
class cnt_env extends uvm_env;
  `uvm_component_utils(cnt_env)

  cnt_agent             m_agent1;
  cnt_agent             m_agent2;
  cnt_scoreboard        m_sb1;
  cnt_scoreboard        m_sb2;
  cnt_predictor         m_predictor1;
  cnt_predictor         m_predictor2;
  cnt_coverage          m_cov;
  cnt_virtual_sequencer m_vir_seqr;

  uvm_tlm_fifo#(int)    m_fifo1;
  uvm_tlm_fifo#(int)    m_fifo2;

  virtual cnt_if_reset_clk m_if_reset_clk;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------  
  function new (string name, uvm_component parent);
    super.new(name,parent);

    // Declaring fifo
    m_fifo1 = new ("m_fifo1", this);
    m_fifo2 = new ("m_fifo2", this);
  endfunction : new

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase
  // Description : This is the build phase function of the class. It creates
  //               objects of agent, score board, coverage. Also provide
  //               configuration to agent.
  //------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_agent1     = cnt_agent::type_id::create ("m_agent1",this);
    m_agent2     = cnt_agent::type_id::create ("m_agent2", this);
    m_sb1        = cnt_scoreboard::type_id::create ("m_sb1", this);
    m_sb2        = cnt_scoreboard::type_id::create ("m_sb2", this);
    m_predictor1 = cnt_predictor::type_id::create ("m_predictor1", this);
    m_predictor2 = cnt_predictor::type_id::create ("m_predictor2", this);
    m_cov        = cnt_coverage::type_id::create ("m_cov", this);
    m_vir_seqr   = cnt_virtual_sequencer::type_id::create ("m_vir_seqr", this);

    // Getting Reset and clock interface from test bench top.
    if (!uvm_config_db#(virtual interface cnt_if_reset_clk) :: get (this, "", "m_if_reset_clk",
      m_if_reset_clk)) begin
      `uvm_fatal ("cnt_env", "Didn't recieved interface from top")
    end
    else begin
      `uvm_info ("cnt_env", "Recived interface from top", UVM_MEDIUM);
    end
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : connect_phase
  // Argument    : phase
  // Description : This is the connect phase function of the class. It
  //               connects analysis port of agent, score baord and coverage
  //               , predictor class.
  //------------------------------------------------------------------------------
  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    
    // Connecting UVM Analysis port
    m_agent1.m_port.connect(m_sb1.m_export);
    m_agent1.m_port.connect(m_predictor1.m_export);
    m_agent1.m_port.connect(m_cov.m_export_agent1);
    m_agent2.m_port.connect(m_sb2.m_export);
    m_agent2.m_port.connect(m_predictor2.m_export);
    m_agent2.m_port.connect(m_cov.m_export_agent2);

    // Connecting virtual sequncer to the actual sequencer
    m_vir_seqr.m_agent1_sequencer = m_agent1.m_sequencer;
    m_vir_seqr.m_agent2_sequencer = m_agent2.m_sequencer;

    // Assigning virtual sequncer enviornment hangle to this classs.
    m_vir_seqr.m_env = this;

    // Connecting predictor and scoreboard via fifo
    m_predictor1.m_put_port.connect(m_fifo1.put_export);
    m_sb1.m_get_port.connect(m_fifo1.get_export);
    m_predictor2.m_put_port.connect(m_fifo2.put_export);
    m_sb2.m_get_port.connect(m_fifo2.get_export);
  endfunction : connect_phase

  //------------------------------------------------------------------------------
  // Method      : reset_dut
  // Argument    : None
  // Description : This is the reset method which resets the dut and is called
  //               from virtual sequencer.
  //------------------------------------------------------------------------------
  task reset_dut ();
    m_if_reset_clk.rst = 1'b0;
    #(m_if_reset_clk.clk_period/2)
    `uvm_info("cnt_env", "Driving RESET signal", UVM_LOW)
    m_if_reset_clk.rst = 1'b1;
    #(m_if_reset_clk.clk_period);
    m_if_reset_clk.rst = 1'b0;
    `uvm_info("cnt_env", "Done driving RESET signal", UVM_LOW)
  endtask : reset_dut
endclass : cnt_env
`endif // CNT_ENV_SV
