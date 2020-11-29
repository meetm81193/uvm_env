// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_reset_test_seq.sv
// DESCRIPTION    : This is the base Reset seqence and genrated Reset Packet. 
// -----------------------------------------------------------------------------


`ifndef CNT_RESET_TEST_SEQ_SV
`define CNT_RESET_TEST_SEQ_SV

//--------------------------------------------------------------------------------
// Class       : cnt_reset_test_seq
// Parent      : cnt_sequence_ext
// Description : This class is derived from cnt base sequence and randmoize the
//               transaction variable.
//--------------------------------------------------------------------------------
class cnt_reset_test_seq extends cnt_sequence_ext;
  `uvm_object_utils(cnt_reset_test_seq)

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name = "");
    super.new(name);
  endfunction : new

  //------------------------------------------------------------------------------
  // Method      : body
  // Description : This task creates handle for transaction, radomize the
  //               transaction variable with in line constraints.
  //------------------------------------------------------------------------------
  task body();
    cnt_transaction m_tnx1;
    cnt_transaction m_tnx2;
    `uvm_info("cnt_reset_test_seq", "Driving reset transaction to driver", UVM_HIGH)
    fork
      begin
        p_sequencer.m_env.reset_dut();
      end
      begin
      `uvm_do_on_with(m_tnx1,p_sequencer.m_agent1_sequencer,{m_tnx1.m_state == RESET;
                                                            m_tnx1.m_dut   == DUT1;
                                                            m_tnx1.delay   == 2;
                                                            m_tnx1.en      == 1;
                                                            m_tnx1.load    ==1; })
      end
      begin
      `uvm_do_on_with(m_tnx2,p_sequencer.m_agent2_sequencer,{m_tnx2.m_state == RESET;
                                                            m_tnx2.m_dut   == DUT2;
                                                            m_tnx2.en      == 1;
                                                            m_tnx2.load    ==1;
                                                            m_tnx2.delay   == 2; })
      end
    join
  endtask : body
endclass : cnt_reset_test_seq 
`endif // CNT_RESET_TEST_SEQ_SV

