// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_if.sv
// DESCRIPTION    : This file declares interface block. Defines all the signal
//                  level variables.
// -----------------------------------------------------------------------------


`ifndef CNT_IF_SV
`define CNT_IF_SV

//--------------------------------------------------------------------------------
// Interface    : cnt_if
// Argument     : clk
// Descripotion : Declares various pin and clocking block.
//--------------------------------------------------------------------------------
interface cnt_if(input clk);
  logic       en;
  logic       load;
  logic       updown;
  logic [7:0] in_data;
  logic [7:0] out_data;

  //------------------------------------------------------------------------------
  // Clocking Block : m_cb
  // Argument       : posedge clk
  // Description    : default input in prepond region and output skew at 4ns.
  //------------------------------------------------------------------------------
  clocking m_cb@(posedge clk);
    default input #1step output #4ns;
    output en,
           load,
           updown,
           in_data;
    input  out_data;
  endclocking : m_cb
endinterface : cnt_if
`endif // CNT_IF_SV
