// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_predictor.sv
// DESCRIPTION    : This monitor is the part of active agent. It takes the
//                  input from the interface and predicts the output. The
//                  output is then sent to Score Board. 
// -----------------------------------------------------------------------------


`ifndef CNT_PREDICTOR_SV
`define CNT_PREDICTOR_SV

//--------------------------------------------------------------------------------
// Class       : cnt_predictor
// Parent      : agent
// Description : This class defines uvm component active agent monitor.
//--------------------------------------------------------------------------------
class cnt_predictor extends uvm_monitor;
  `uvm_component_utils(cnt_predictor)

  uvm_analysis_export #(cnt_transaction)  m_export;
  uvm_tlm_analysis_fifo#(cnt_transaction) m_fifo;
  uvm_blocking_put_port#(int)             m_put_port;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name, uvm_component parent);
    super.new (name, parent);
  endfunction : new

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase
  // Description : This is build phase of the class creates port.
  //------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_export   = new ("m_export", this);
    m_fifo     = new ("m_fifo", this);
    m_put_port = new ("m_put_port", this);
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
  // Description : This is run_phase of this class it monitor the transaction
  //               and predicts the output of the dut and sends to scoreboard.
  //------------------------------------------------------------------------------
  task run_phase (uvm_phase phase);
    int count    = 0;
    int temp     = 0;
    int out_data = 0;
    cnt_transaction m_tnx;

    forever begin
    `uvm_info ("cnt_predictor", "Receving Data from Monitor", UVM_HIGH)
     m_fifo.get(m_tnx); 
    `uvm_info ("cnt_predictor", "Getting Data from Monitor", UVM_HIGH)
     case(m_tnx.m_state)
       RESET  :  begin
                   if(count == 1) begin
                     out_data = 0;
                     count    = 0;
                     temp     = out_data;
                   end
                   else
                     count++;
                 end 
       PREV   :  begin
                   out_data = temp;
                 end
       LOAD   :  begin
                   out_data = m_tnx.in_data;
                   temp     = out_data;
                 end
       UPCNT  :  begin
                   out_data+= out_data;
                   temp     = out_data;
                 end
       DWNCNT :  begin
                   out_data-=out_data;
                   temp     = out_data;
                 end
       INITIAL: out_data = 'x; 
     endcase
     `uvm_info("cnt_predictor", $sformatf("My Predicted Output : %0d", out_data), UVM_LOW)
     m_put_port.put(out_data);
     `uvm_info("cnt_predictor", "Sending data to Score Board from predictor", UVM_HIGH)
    end
  endtask : run_phase
endclass : cnt_predictor 
`endif // CNT_PREDICTOR_SV 
