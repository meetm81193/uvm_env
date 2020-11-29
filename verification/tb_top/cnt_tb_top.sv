// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_tb_top.sv
// DESCRIPTION    : This is the top level module which instanciate DUT and
//                  interface and set interface handle in configuration
//                  database so that can be accesed globaly.
// -----------------------------------------------------------------------------

`ifndef CNT_TB_TOP_SV
`define CNT_TB_TOP_SV

//------------------------------------------------------------------------------
// Module         : cnt_tb_top
// Argument       : null
// Description    : This is the top module of the enviornment.
//------------------------------------------------------------------------------
module cnt_tb_top;
  import uvm_pkg::*;
  import cnt_tests_pkg::*;
  `include "uvm_macros.svh"

  // Declaring instance of interface.
  cnt_if_reset_clk m_if_reset_clk();
  cnt_if           m_if1(m_if_reset_clk.clk);
  cnt_if           m_if2(m_if_reset_clk.clk);

  // Declaring instance of DUT i.e. UpDown_Counter.
  dut_top m_dut (.Clk        (m_if_reset_clk.clk),
                 .Reset      (m_if_reset_clk.rst),
                 .Enable_1   (m_if1.m_cb.en),
                 .Enable_2   (m_if2.m_cb.en),
                 .Load_1     (m_if1.m_cb.load),
                 .Load_2     (m_if2.m_cb.load),
                 .UpDown_1   (m_if1.m_cb.updown),
                 .UpDown_2   (m_if2.m_cb.updown),
                 .In_Data_1  (m_if1.m_cb.in_data),
                 .In_Data_2  (m_if2.m_cb.in_data),
                 .Out_Data_1 (m_if1.m_cb.out_data),
                 .Out_Data_2 (m_if2.m_cb.out_data));

  // Configuring UVM component with virtual interface handle.
  initial begin
    uvm_config_db#(virtual interface cnt_if_reset_clk) ::
      set(null,"uvm_test_top.*", "m_if_reset_clk", m_if_reset_clk);
    uvm_config_db#(virtual interface cnt_if) :: 
      set(null,"uvm_test_top.m_env.m_agent1.*", "m_if", m_if1);
    uvm_config_db#(virtual interface cnt_if) :: 
      set(null,"uvm_test_top.m_env.m_agent2.*", "m_if", m_if2);

    run_test(); 
  end
endmodule : cnt_tb_top
`endif // CNT_TB_TOP_SV
