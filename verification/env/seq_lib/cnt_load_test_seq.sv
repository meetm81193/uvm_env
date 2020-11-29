// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_load_test_seq.sv
// DESCRIPTION    : This class genrates packet to drive load state in dut.
// -----------------------------------------------------------------------------


`ifndef CNT_LOAD_SEQUENCE_SV
`define CNT_LOAD_SEQUENCE_SV

//--------------------------------------------------------------------------------
// Class       : cnt_load_test_seq
// Parent      : cnt_sequence_ext
// Description : This class is derived from cnt base sequence and randmoize the
//               transaction variable.
//--------------------------------------------------------------------------------
class cnt_load_test_seq extends cnt_sequence_ext;
  `uvm_object_utils(cnt_load_test_seq)
  
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
    cnt_transaction             m_tnx1;
    cnt_transaction             m_tnx2;
    cnt_initialization_test_seq m_init_seq;
    `uvm_info("cnt_initialization_test_seq","Driving Load Sequence", UVM_MEDIUM )

    `uvm_do (m_init_seq)
    fork
      begin
        `uvm_do_on_with (m_tnx1, p_sequencer.m_agent1_sequencer, { m_tnx1.m_state == LOAD;
                                                                   m_tnx1.m_dut   == DUT1;
                                                                   m_tnx1.delay   == 1;
                                                                   m_tnx1.en      == 1;
                                                                   m_tnx1.load    == 1;})
        `uvm_do_on_with (m_tnx2, p_sequencer.m_agent2_sequencer, { m_tnx2.m_state == LOAD;
                                                                   m_tnx2.m_dut   == DUT2;
                                                                   m_tnx2.delay   == 1;
                                                                   m_tnx2.en      == 1;
                                                                   m_tnx2.load    == 1;})
      end
    join
   endtask : body
endclass : cnt_load_test_seq  
`endif // CNT_LOAD_SEQUENCE_SV  
