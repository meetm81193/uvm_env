// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_transaction.sv
// DESCRIPTION    : This transaction class defines varibles to be sent to DUT.
//                  Also declares copy, compare and convert2string method.
// -----------------------------------------------------------------------------


`ifndef CNT_TRANSACTION_SV
`define CNT_TRANSACTION_SV

//--------------------------------------------------------------------------------
// Class       : cnt_transaction
// Parent      : None
// Description : This class declares random variable and constraint variable.
//               along with modifier methods.
//--------------------------------------------------------------------------------
class cnt_transaction extends uvm_sequence_item;
  rand bit [7:0]    in_data;
  rand bit          updown;
  rand bit          en;
  rand bit          load;
  rand int          delay;
  rand cnt_state_e  m_state;
       bit [7:0]    out_data;
       bit          rst;
  rand cnt_dut_e    m_dut;

  // Constrinat on Indata to be have more weight at 0x00 and 0xFF
  constraint roll_in_data   {in_data dist {8'd0:=1,[8'd1:8'd254]:=1,8'd255:=1};}

  // Constraint on delay to be for 20ns when in Reset state.
  constraint delay_on_reset { m_state == RESET -> delay == 2;}

  // Constraint on delay to be between 20 to 100 ns during any other state
  // except RESET state.
  constraint state_delay    { delay inside {[2:10]};}

  //------------------------------------------------------------------------------
  // Method      : new
  // Argument    : name   - string for instance name
  // Description : This is the constructor method of the class.
  //------------------------------------------------------------------------------
  function new(string name = "");
    super.new(name);
  endfunction : new

  // Register class and variable with UVM_Factory
  `uvm_object_utils_begin(cnt_transaction)
    `uvm_field_int(in_data,UVM_ALL_ON)
    `uvm_field_int(out_data,UVM_ALL_ON)
    `uvm_field_int(updown,UVM_ALL_ON)
    `uvm_field_int(en,UVM_ALL_ON)
    `uvm_field_int(load,UVM_ALL_ON)
    `uvm_field_int(delay,UVM_ALL_ON)
    `uvm_field_int(rst,UVM_ALL_ON)
    `uvm_field_enum(cnt_state_e, m_state,UVM_ALL_ON)
    `uvm_field_enum(cnt_dut_e, m_dut,UVM_ALL_ON)
  `uvm_object_utils_end

  //------------------------------------------------------------------------------
  // Method      : print
  // Description : This is the print function which display the implemented
  //               transaction.
  //------------------------------------------------------------------------------
  function void print;
    //$display("%c[1;34m",27);
    $display("---------- Transaction ----------");
    $display("State         : %0s",m_state.name);
    $display("DUT           : %0s",m_dut.name);
    $display("Reset         : %0d",rst);
    $display("InputData     : %0d",in_data);
    $display("Updown        : %0d",updown);
    $display("Enable        : %0d",en);
    $display("Load          : %0d",load);
    $display("OutputData1   : %0d",out_data);
    $display("-----------------------------------");
    //$display("%c[0m",27);
  endfunction : print
endclass : cnt_transaction
`endif // CNT_TRANSACTION_SV
