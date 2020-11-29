// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_if_reset_clk.sv
// DESCRIPTION    : This is interface block declares reset and clock.
// -----------------------------------------------------------------------------


`ifndef CNT_IF_RESET_CLK_SV
`define CNT_IF_RESET_CLK_SV

//--------------------------------------------------------------------------------
// Interface    : cnt_if_reset_clk
// Descripotion : Declares clock and reset pin.
//--------------------------------------------------------------------------------

interface cnt_if_reset_clk;
  bit clk;
  bit rst;
  int clk_period = 20ns;

  always #(clk_period/2) clk =~ clk;

endinterface : cnt_if_reset_clk
`endif // CNT_IF_RESET_CLK_SV
