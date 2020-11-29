// -----------------------------------------------------------------------------
// AUTHOR         : Meet Mehta
// FILE NAME      : cnt_macros.sv
// DESCRIPTION    : This file declares global macros.
// -----------------------------------------------------------------------------

// Check that analysis imports are connected.
`define CHECK_PORT_CONNECTION(PORT) \
  begin \
    uvm_port_list list; \
    PORT.get_provided_to(list); \
    if (!list.size()) begin \
      `uvm_error("AP_CONNECT", \
        $sformatf("Analysis port %s not connected.", PORT.get_full_name())); \
    end \
    else `uvm_info("AP_CONNECT",$sformatf("Analysis port %s connected.",PORT.get_name()),UVM_MEDIUM) \
  end
