// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_base_test.sv
// DESCRIPTION    : This is base test declares various common variable.
// -----------------------------------------------------------------------------


`ifndef CNT_BASE_TEST_SV
`define CNT_BASE_TEST_SV

//--------------------------------------------------------------------------------
// Class       : cnt_base_test
// Parent      : None
// Description : This class declares enviornment and prints topology.
//--------------------------------------------------------------------------------
class cnt_base_test extends uvm_test;
  `uvm_component_utils (cnt_base_test)
  cnt_env              m_env;

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
    m_env      = cnt_env::type_id::create("m_env", this);
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : end_of_elobration_phase
  // Argument    : phase - inbult uvm phase
  // Description : This is the end of elobration phase. It prints the topology.
  //------------------------------------------------------------------------------
  function void end_of_elaboration_phase (uvm_phase phase);
    //uvm_top.print_topology ();
  endfunction : end_of_elaboration_phase
endclass : cnt_base_test
`endif // CNT_BASE_TEST_SV
