// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_sequencer.sv
// DESCRIPTION    : This is the uvm component sequencer which is extended from 
//                  uvm parametrized class uvm_sequencer. It sends request to
//                  driver for transmiting transaction.
// -----------------------------------------------------------------------------


`ifndef CNT_SEQUENCER_SV
`define CNT_SEQUENCER_SV

//--------------------------------------------------------------------------------
// Class       : cnt_sequencer
// Parent      : agent
// Description : This class defines uvm component uvm_sequncer.
//--------------------------------------------------------------------------------
class cnt_sequencer extends uvm_sequencer#(cnt_transaction);
  `uvm_component_utils(cnt_sequencer)

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name, uvm_component parent);
    super.new (name, parent);
  endfunction : new

endclass : cnt_sequencer
`endif // CNT_SEQUENCER_SV    
