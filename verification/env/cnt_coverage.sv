// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_coverage.sv
// DESCRIPTION    : This class measure the functional coverage.
// -----------------------------------------------------------------------------


`ifndef CNT_COVERAGE_SV
`define CNT_COVERAGE_SV

//--------------------------------------------------------------------------------
// Class       : cnt_coverage
// Parent      : enviornment
// Description : This class defines uvm component coverage.
//--------------------------------------------------------------------------------
class cnt_coverage extends uvm_component;
  `uvm_component_utils(cnt_coverage)

  uvm_analysis_export#(cnt_transaction)      m_export_agent1;
  uvm_analysis_export#(cnt_transaction)      m_export_agent2;
  uvm_tlm_analysis_fifo#(cnt_transaction)    m_fifo_agent1;
  uvm_tlm_analysis_fifo#(cnt_transaction)    m_fifo_agent2;

  virtual cnt_if m_if;

  bit [7:0]  in_data;
  bit        updown;
  bit        en;
  bit        load;
  bit        rst;



  covergroup cg_cnt_transaction;
    option.name      = "cg_cnt_transaction";
    option.comment   = "Cover Group covers transaction for various test";
    cp_reset     : coverpoint rst{
      bins set       = {1};
      bins clear     = {0};
      bins trans_01  = (0    =>1[*2]);
      bins trans_10  = (1[*2]=>    0);
    }
    cp_enable    : coverpoint en{
      bins set       = {1};
      bins clear     = {0};
      bins trans_01  = (0 => 1);
      bins trans_10  = (1 => 0);
    }
    cp_load      : coverpoint load{
      bins set       = {1};
      bins clear     = {0};
      bins trans_01  = (0 => 1);
      bins trans_10  = (1 => 0);
    }
    cp_updown    : coverpoint updown{
      bins set       = {1};
      bins clear     = {0};
      bins trans_01  = (0 => 1);
      bins trans_10  = (1 => 0);
    }
    cp_in_data   : coverpoint in_data{
      bins trans_roll_up   = (8'hFF => 8'h00);
      bins trans_roll_back = (8'h00 => 8'hFF);
      bins misc            = default; 
    }
    cross_load_data : cross cp_reset, cp_enable, cp_load {
      ignore_bins reset  = binsof (cp_reset.set) && binsof (cp_reset.trans_01) && binsof (cp_reset.trans_10);
      ignore_bins enable = binsof (cp_enable.trans_01) && binsof (cp_enable.trans_10);
      ignore_bins load   = binsof (cp_load.trans_01) && binsof (cp_load.trans_10);
    }
    cross_updown_count  : cross cp_reset, cp_enable, cp_load, cp_updown {
      ignore_bins reset  = binsof (cp_reset.set) && binsof (cp_reset.trans_01) && binsof (cp_reset.trans_10);
      ignore_bins enable = binsof (cp_enable.clear) && binsof (cp_enable.trans_01) && binsof (cp_enable.trans_10);
      ignore_bins load   = binsof (cp_load.set) && binsof (cp_load.trans_01) && binsof (cp_load.trans_10);
    }      
  endgroup : cg_cnt_transaction


  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------  
  function new (string name, uvm_component parent);
    super.new(name,parent);
    cg_cnt_transaction = new ();
  endfunction

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase
  // Description : This is the build phase function of the class. It creates
  //               analysis imp, and analysis fifo. 
  //------------------------------------------------------------------------------
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    m_export_agent1 = new ("m_export_agent1", this);
    m_export_agent2 = new ("m_export_agent2", this);
    m_fifo_agent1   = new ("m_fifo_agent1", this);
    m_fifo_agent2   = new ("m_fifo_agent2", this);
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : connect_phase
  // Argument    : phase
  // Discription : connect analysis export to analysis tlm fifo.
  //------------------------------------------------------------------------------
  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    m_export_agent1.connect(m_fifo_agent1.analysis_export);
    m_export_agent2.connect(m_fifo_agent2.analysis_export);
  endfunction : connect_phase

  //------------------------------------------------------------------------------
  // Method      : end_of_elaboration_phase
  // Argument    : phase
  // Discription : checking the port connection.
  //------------------------------------------------------------------------------
  function void end_of_elaboration_phase (uvm_phase phase);
    super. end_of_elaboration_phase (phase);
    `CHECK_PORT_CONNECTION (m_export_agent1)
    `CHECK_PORT_CONNECTION (m_export_agent2)
  endfunction : end_of_elaboration_phase

  //------------------------------------------------------------------------------
  // Method      : run_phase
  // Argument    : phase
  // Discription : This is the run phase of the class it get the transaction
  //               from the agent1 and agent2 and covers the coverage.
  //------------------------------------------------------------------------------
  task run_phase (uvm_phase phase);
    cnt_transaction m_tnx_agent1;
    cnt_transaction m_tnx_agent2;
    cg_cnt_transaction.set_inst_name({get_full_name(),"m_cg"});
    cg_cnt_transaction.option.comment = "Covergroup covers transaction received from Monitor Interface";

    forever begin
      fork
        begin
          m_fifo_agent1.get(m_tnx_agent1);
          m_fifo_agent2.get(m_tnx_agent2);
        end
      join
      in_data = m_tnx_agent1.in_data;
      updown  = m_tnx_agent1.updown;
      en      = m_tnx_agent1.en;
      load    = m_tnx_agent1.load;
      rst     = m_tnx_agent1.rst;
      cg_cnt_transaction.sample();
      in_data = m_tnx_agent2.in_data;
      updown  = m_tnx_agent2.updown;
      en      = m_tnx_agent2.en;
      load    = m_tnx_agent2.load;
      rst     = m_tnx_agent2.rst;
      cg_cnt_transaction.sample();
    end
  endtask : run_phase
endclass : cnt_coverage
`endif // CNT_COVERAGE_SV
