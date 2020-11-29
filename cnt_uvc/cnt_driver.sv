// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_driver.sv
// DESCRIPTION    : This driver class is receives the transaction from the
//                  sequencer class and convert transaction into pin level
//                  wiggle.
// -----------------------------------------------------------------------------


`ifndef CNT_DRIVER_SV
`define CNT_DRIVER_SV

//--------------------------------------------------------------------------------
// Class       : cnt_driver
// Parent      : agent
// Description : This class get the transaction from the sequencer and send to
//               to DUT using BusFunctionaModel. It gets the interface from the
//               top module.               
//--------------------------------------------------------------------------------
class cnt_driver extends uvm_driver#(cnt_transaction);
  `uvm_component_utils(cnt_driver)

  uvm_event#(cnt_transaction)      drv2mon;
  virtual cnt_if m_if;

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction : new

  //------------------------------------------------------------------------------
  // Method      : build_phase
  // Argument    : phase
  // Description : This is build phase of this class it receives the handle for
  //               virtual interface.
  //------------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Getting interface for pin level transaction
    if (!uvm_config_db#(virtual interface cnt_if)::get(this, " ", "m_if",m_if)) begin
      `uvm_fatal("cnt_driver","Didn't get handle to virtual interface from top")
    end
    else begin
      `uvm_info ("cnt_driver","Received handle of virtual interface from top",UVM_MEDIUM)
    end

    // Getting event from agent
    if (!uvm_config_db#(uvm_event#(cnt_transaction))::get(this, "", "drv2mon", drv2mon)) begin
      `uvm_fatal("cnt_driver","Didn't get event handle from agent")
    end
    else begin
      `uvm_info ("cnt_driver","Received event handle from agent",UVM_MEDIUM)
    end
  endfunction : build_phase

  //------------------------------------------------------------------------------
  // Method      : run_phase
  // Argument    : phase
  // Description : This is the run phase of this class it receive the
  //               transaction from the sequencer and sends to interface.
  //------------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    cnt_transaction m_tnx;
    forever begin
      `uvm_info ("cnt_driver", "Waiting for transaction from sequencer", UVM_HIGH)
      seq_item_port.get_next_item(m_tnx);
      `uvm_info ("cnt_driver", "Received transaction from sequencer", UVM_HIGH)
      m_tnx.print();
      repeat(m_tnx.delay) begin
        @(posedge m_if.m_cb);
        `uvm_info ("cnt_driver", "Received posedge of clocking block", UVM_HIGH)
        m_if.m_cb.en      <= m_tnx.en;
        m_if.m_cb.load    <= m_tnx.load;
        m_if.m_cb.updown  <= m_tnx.updown;
        m_if.m_cb.in_data <= m_tnx.in_data;
        drv2mon.trigger(m_tnx);
        `uvm_info ("cnt_driver", "Triggering Event to monitor", UVM_HIGH)
      end
      `uvm_info ("cnt_driver", "Completing transaction", UVM_HIGH)
      seq_item_port.item_done();
    end
  endtask : run_phase
endclass : cnt_driver
`endif // CNT_DRIVER_SV
