UVC       = $(BASE_DIR)/cnt_uvc
SEQ_LIB   = $(BASE_DIR)/verification/env/seq_lib
ENV				= $(BASE_DIR)/verification/env
TOP       = $(BASE_DIR)/verification/tb_top
TEST			= $(BASE_DIR)/verification/tests
DUT				= '/home/meetm/Projects/AN_Training/shared/rtl/up_down_counter'
UVM_FLAGS = +define+UVM_NO_DPI +incdir+$(UVM_HOME)/src  $(UVM_HOME)/src/uvm_pkg.sv 
TEST_NAME	= cnt_reset_test

clean:
	rm -rf work *.ini *.wlf *.log transcript
	clear
compile:
	vlib work
	vlog +incdir+$(DUT) $(DUT)/dut_top.sv
	vlog $(UVM_FLAGS) +incdir+$(UVC) $(UVC)/cnt_pkg.sv \
			 +incdir+$(ENV) $(ENV)/cnt_env_pkg.sv\
			 +incdir+$(SEQ_LIB) $(SEQ_LIB)/cnt_seq_lib_pkg.sv\
			 +incdir+$(TEST) $(TEST)/cnt_tests_pkg.sv\
			 +incdir+$(TOP) $(TOP)/cnt_tb_top.sv
sim:
	vsim -novopt -c -do "run -all; quit" cnt_tb_top +UVM_CONFIG_DB_TRACE +UVM_VERBOSITY=UVM_LOW +UVM_TESTNAME="$(TEST_NAME)" 
wave:
	vsim -novopt dut_top cnt_tb_top +UVM_TESTNAME="$(TEST_NAME)" -do "add wave -r /*; run 1000 ns; quit" -wlf cnt_reset_test.wlf

