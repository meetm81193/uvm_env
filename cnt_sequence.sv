// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_sequence.sv
// DESCRIPTION    : This is the base sequence class derived from uvm sequence.
// -----------------------------------------------------------------------------


`ifndef CNT_SEQUENCE_SV
`define CNT_SEQUENCE_SV

//--------------------------------------------------------------------------------
// Class       : cnt_sequence
// Parent      : None
// Description : This class defines base sequence class.
//--------------------------------------------------------------------------------
class cnt_sequence extends uvm_sequence#(cnt_transaction);
  `uvm_object_utils (cnt_sequence)
  
  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name = " ");
    super.new(name);
  endfunction : new

endclass : cnt_sequence
`endif // CNT_SEQUENCE_SV
