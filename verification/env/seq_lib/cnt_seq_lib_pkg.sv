// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_seq_lib_pkg.sv
// DESCRIPTION    : This file declares system verilog package to store the
//                  various sequence class file.
// -----------------------------------------------------------------------------


`ifndef CNT_SEQ_LIB_PKG_SV
`define CNT_SEQ_LIB_PKG_SV

//------------------------------------------------------------------------------
// Package        : cnt_seq_lib_pkg
// Discription    : This file includes various test sequences.
//------------------------------------------------------------------------------
package cnt_seq_lib_pkg;
  import uvm_pkg::*;
  import cnt_uvc_pkg::*;
  import cnt_typedef_pkg::*;
  import cnt_env_pkg::*;
  `include "uvm_macros.svh"
  `include "cnt_sequence_ext.sv"
  `include "cnt_reset_test_seq.sv"
  `include "cnt_initialization_test_seq.sv"
  `include "cnt_load_test_seq.sv"
  `include "cnt_dwncount_test_seq.sv"
  `include "cnt_upcount_test_seq.sv"
  `include "cnt_previous_test_seq.sv"
  `include "cnt_roll_back_test_seq.sv"
  `include "cnt_roll_over_test_seq.sv"
endpackage : cnt_seq_lib_pkg
`endif // CNT_SEQ_LIB_PKG_SV
