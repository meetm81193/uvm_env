// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_typedef_pkg.sv
// DESCRIPTION    : This file declares system verilog package and declares
//                  various typedef class and enum. 
// -----------------------------------------------------------------------------


`ifndef CNT_TYPEDEF_PKG_SV
`define CNT_TYPEDEF_PKG_SV

//------------------------------------------------------------------------------
// Package        : cnt_typedef_pkg
// Description    : This package define global variables.
//------------------------------------------------------------------------------
package cnt_typedef_pkg;
  
  // Typedef enumerated type for state
  typedef enum {INITIAL, RESET, PREV, LOAD, UPCNT, DWNCNT} cnt_state_e;

  // Typedef enumerated type for identifying dut
  typedef enum {DUT1, DUT2} cnt_dut_e;

endpackage : cnt_typedef_pkg
`endif // CNT_TYPEDEF_PKG_SV
