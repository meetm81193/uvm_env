// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_previous_test.sv
// DESCRIPTION    : This class declares previous test sewuence and run on virtual
//                  sequencer.
// -----------------------------------------------------------------------------


`ifndef CNT_PREVIOUS_TEST_SV
`define CNT_PREVIOUS_TEST_SV

//--------------------------------------------------------------------------------
// Class       : cnt_previous_test
// Parent      : None
// Description : This class declares load previous sequence and run on virtual
//               sequencer.
//--------------------------------------------------------------------------------
class cnt_previous_test extends cnt_base_test;
  `uvm_component_utils (cnt_previous_test)
  cnt_previous_test_seq    m_pre_seq;

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
    m_pre_seq = cnt_previous_test_seq::type_id::create ("m_pre_seq");
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : run_phase
  // Argument    : phase - inbult uvm_phase
  // Description : This is the run phase of the class. it runs the virtual
  //               sequencer. 
  //------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    `uvm_info("cnt_previous_test","Raising the Objection", UVM_MEDIUM)
    phase.raise_objection(this);
    m_pre_seq.start(m_env.m_vir_seqr);
    phase.drop_objection(this);
    `uvm_info("cnt_previous_test","Dropping the Objection", UVM_MEDIUM)
  endtask : run_phase
endclass : cnt_previous_test
`endif // CNT_PREVIOUS_TEST_SV
