// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_sequence_ext.sv
// DESCRIPTION    : This is the base sequence class derived from uvm sequence.
// -----------------------------------------------------------------------------


`ifndef CNT_SEQUENCE_EXT_SV
`define CNT_SEQUENCE_EXT_SV

//--------------------------------------------------------------------------------
// Class       : cnt_sequence_ext
// Parent      : None
// Description : This class defines base sequence class.
//--------------------------------------------------------------------------------
class cnt_sequence_ext extends cnt_sequence;
  `uvm_object_utils (cnt_sequence_ext)
  `uvm_declare_p_sequencer(cnt_virtual_sequencer)
  
  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name = " ");
    super.new(name);
  endfunction : new

endclass : cnt_sequence_ext
`endif // CNT_SEQUENCE_EXT_SV
