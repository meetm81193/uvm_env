// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_reset_test.sv
// DESCRIPTION    : This test class creates the enviornment object.
// -----------------------------------------------------------------------------


`ifndef CNT_RESET_TEST_SV
`define CNT_RESET_TEST_SV

//--------------------------------------------------------------------------------
// Class       : cnt_reset_test
// Parent      : None
// Description : This class declares enviornment and runs virtual sequencer.
//--------------------------------------------------------------------------------
class cnt_reset_test extends cnt_base_test;
  `uvm_component_utils (cnt_reset_test)
  cnt_reset_test_seq    m_rst_seq;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  //               parent - handle of the parent component
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase - inbult uvm phase.
  // Description : This is the build function of the uvm. Creates object for
  //               enviornment class and virtual sequencer.
  //------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_rst_seq = cnt_reset_test_seq::type_id::create ("m_rst_seq");
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : run_phase
  // Argument    : phase - inbult uvm_phase
  // Description : This is the run phase of the class. it runs the virtual
  //               sequencer. 
  //------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    `uvm_info("cnt_reset_test","Raising the Objection", UVM_MEDIUM)
    phase.raise_objection(this);
    m_rst_seq.start(m_env.m_vir_seqr);
    phase.drop_objection(this);
    `uvm_info("cnt_reset_test","Dropping the Objection", UVM_MEDIUM)
  endtask : run_phase
endclass : cnt_reset_test
`endif // CNT_RESET_TEST_SV
