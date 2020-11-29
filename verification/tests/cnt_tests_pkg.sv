// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_tests_pkg.sv 
// DESCRIPTION    : This file declares system verilog package to store the
//                  tests file.
// -----------------------------------------------------------------------------


`ifndef CNT_TESTS_PKG_SV
`define CNT_TESTS_PKG_SV

//------------------------------------------------------------------------------
// Package        : cnt_tests_pkg
// Discription    : This file includes various test files.
//------------------------------------------------------------------------------
package cnt_tests_pkg;
  import uvm_pkg::*;
  import cnt_uvc_pkg::*;
  import cnt_typedef_pkg::*;
  import cnt_env_pkg::*;
  import cnt_seq_lib_pkg::*;

  `include "uvm_macros.svh"
  `include "cnt_base_test.sv"
  `include "cnt_reset_test.sv" 
  `include "cnt_load_test.sv"
  `include "cnt_previous_test.sv"
  `include "cnt_upcount_test.sv"
  `include "cnt_dwncount_test.sv"
  `include "cnt_roll_over_test.sv"
  `include "cnt_roll_back_test.sv"
endpackage : cnt_tests_pkg
`endif // CNT_TESTS_PKG_SV
