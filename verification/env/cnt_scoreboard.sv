// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_scoreboard.sv
// DESCRIPTION    : This is scoreboard class it receive the transaction from
//                  active and passive monitor and compares the output.
// -----------------------------------------------------------------------------


`ifndef CNT_SCOREBOARD_SV
`define CNT_SCOREBOARD_SV

//--------------------------------------------------------------------------------
// Class       : cnt_scorebaord
// Parent      : enviornment
// Description : This class defines uvm component scorebaord.
//--------------------------------------------------------------------------------
class cnt_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(cnt_scoreboard)

  uvm_analysis_export#(cnt_transaction)   m_export;
  uvm_tlm_analysis_fifo#(cnt_transaction) m_fifo;
  uvm_blocking_get_port#(int)             m_get_port;
  int                                     out_data;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------  
  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase
  // Description : This is the build function of the class it creates analysis
  //               port. 
  //------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_export    = new ("m_export", this);
    m_fifo      = new ("m_fifo", this);
    m_get_port  = new ("m_get_port", this);
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : connect_phase
  // Argument    : phase
  // Description : This is the connect phase function of the class. It connects
  //               to agent's analysis port. 
  //------------------------------------------------------------------------------
  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    m_export.connect(m_fifo.analysis_export);
  endfunction : connect_phase

  //------------------------------------------------------------------------------
  // Method      : end_of_elaboration_phase
  // Argument    : phase
  // Discription : checking the port connection.
  //------------------------------------------------------------------------------
  function void end_of_elaboration_phase (uvm_phase phase);
    super. end_of_elaboration_phase (phase);
    `CHECK_PORT_CONNECTION (m_export)
  endfunction : end_of_elaboration_phase

  //------------------------------------------------------------------------------
  // Method      : run_phase
  // Argument    : phase
  // Description : This is the run phase function of the class. It takes
  //               transaction object from tlm fifo and compares the output.
  //------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    cnt_transaction m_tnx;
    
    forever begin
      m_get_port.get(out_data);
      m_fifo.get(m_tnx);
    
      `uvm_info("cnt_scoreboard",$sformatf("%s",m_tnx.m_dut.name), UVM_LOW)
      case (m_tnx.m_state)
        RESET  :  begin
                    if (out_data == m_tnx.out_data) begin
                      //$display("%c[1;32m",27);
                      `uvm_info("cnt_scoreboard","RESET TEST PASS", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                    else begin
                      //$display("%c[1;31m",27);
                      `uvm_info("cnt_scoreboard","RESET TEST FAIL", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                  end 
        PREV   :  begin
                    if (out_data == m_tnx.out_data) begin
                      //$display("%c[1;32m",27);
                      `uvm_info("cnt_scoreboard","PREVIOUS TEST PASS", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                    else begin
                      //$display("%c[1;31m",27);
                      `uvm_info("cnt_scoreboard","PREVIOUS TEST FAIL", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                  end
        LOAD   :  begin
                    if (out_data == m_tnx.out_data) begin
                      //$display("%c[1;32m",27);
                      `uvm_info("cnt_scoreboard","LOAD TEST Pass", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                    else begin
                      //$display("%c[1;31m",27);
                      `uvm_info("cnt_scoreboard","LOAD TEST Fail", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                  end
        UPCNT  :  begin
                    if (out_data == m_tnx.out_data) begin
                      //$display("%c[1;32m",27);
                      `uvm_info("cnt_scoreboard","UPCOUNT TEST Pass", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                    else begin
                      //$display("%c[1;31m",27);
                      `uvm_info("cnt_scoreboard","UPCOUNT TEST Fail", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                  end
        DWNCNT :  begin
                    if (out_data == m_tnx.out_data) begin
                      //$display("%c[1;32m",27);
                      `uvm_info("cnt_scoreboard","DOWNCOUNT TEST Pass", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                    else begin
                      //$display("%c[1;31m",27);
                      `uvm_info("cnt_scoreboard","DOWNCOUNT TEST Fail", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                  end
        INITIAL: begin
                    if (out_data == m_tnx.out_data) begin
                      //$display("%c[1;32m",27);
                      `uvm_info("cnt_scoreboard","INITIAL TEST Pass", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                    else begin
                      //$display("%c[1;31m",27);
                      `uvm_info("cnt_scoreboard","INITIAL TEST Fail", UVM_LOW);
                      //$display("%c[1;0m",27);
                    end
                 end
      endcase
    end
  endtask : run_phase
endclass : cnt_scoreboard
`endif // CNT_SCOREBOARD_SV
