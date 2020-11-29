// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_virtual_sequencer.sv
// DESCRIPTION    : This is the virtual sequencer class declares two sequencer
//                  of two agent which drives two interface.
// -----------------------------------------------------------------------------


`ifndef CNT_VIRTUAL_SEQUENCER_SV
`define CNT_VIRTUAL_SEQUENCER_SV

//--------------------------------------------------------------------------------
// Class       : cnt_virtual_sequencer
// Parent      : None
// Description : This class defines uvm component virtual sequencer.
//--------------------------------------------------------------------------------
class cnt_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(cnt_virtual_sequencer)

  cnt_sequencer m_agent1_sequencer;
  cnt_sequencer m_agent2_sequencer;
  cnt_env       m_env;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name, uvm_component parent);
    super.new (name, parent);
  endfunction : new

endclass : cnt_virtual_sequencer
`endif // CNT_VIRTUAL_SEQUENCER_SV  
