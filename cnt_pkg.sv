// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_pkg.sv
// DESCRIPTION    : This file declare system verilog package to store the
//                  various uvm component file.
// -----------------------------------------------------------------------------


`ifndef CNT_PKG_SV
`define CNT_PKG_SV

`include "cnt_if_reset_clk.sv"
`include "cnt_if.sv"
`include "cnt_typedef_pkg.sv"

//------------------------------------------------------------------------------
// Pacakge        : cnt_uvc_pkg
// Discription    : This package declares various component class file.
//------------------------------------------------------------------------------
package cnt_uvc_pkg;
  import uvm_pkg::*;
  import cnt_typedef_pkg::*;

  `include "uvm_macros.svh"
  `include "cnt_transaction.sv"
  `include "cnt_sequence.sv"
  `include "cnt_sequencer.sv"
  `include "cnt_driver.sv"
  `include "cnt_monitor.sv"
  `include "cnt_agent.sv"
endpackage : cnt_uvc_pkg
`endif // CNT_PKG_SV
