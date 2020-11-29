// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_env_pkg.sv
// DESCRIPTION    : This file declares system verilog package to store the
//                  various env file.
// -----------------------------------------------------------------------------


`ifndef CNT_ENV_PKG_SV
`define CNT_ENV_PKG_SV
`include "cnt_macros.sv"
  
//------------------------------------------------------------------------------
// Package        : cnt_env_pkg
// Discription    : This file inlcude various enviornment component. 
//------------------------------------------------------------------------------
package cnt_env_pkg;
  import uvm_pkg::*;
  import cnt_uvc_pkg::*;
  import cnt_typedef_pkg::*;

  `include "uvm_macros.svh"
  typedef cnt_env;
  `include "cnt_virtual_sequencer.sv"
  `include "cnt_predictor.sv"
  `include "cnt_scoreboard.sv"
  `include "cnt_coverage.sv"
  `include "cnt_env.sv"
endpackage : cnt_env_pkg
`endif // CNT_ENV_PKG_SV
