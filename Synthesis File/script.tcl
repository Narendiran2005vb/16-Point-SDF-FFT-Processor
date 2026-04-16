set_attribute lib_search_path /home/iiitdmk/Desktop/124EC0017/fft/fft/fft16/foundary
set_attribute hdl_search_path /home/iiitdmk/Desktop/124EC0017/fft/fft/fft16/
set_attribute library fast_vdd1v0_basicCells.lib

##read_hdl {gate_test.v nor_test.v}
read_hdl {butterfly.v complex_multiplier.v FFT_stage_1.v FFT_stage_2.v FFT_stage_3.v FFT_stage_4.v FFT_top_level.v Trivial_rotor.v}

elaborate fft_16point

current_design fft_16point

set_attribute dont_use true [find /lib* -libcell SDFF*] 
define_clock -period 10000000 -name clk [get_ports clk]
external_delay -input 0 -clock clk [all_inputs] 
external_delay -output 0 -clock clk [all_outputs]

elaborate

##read_sdc /home/basari/gate_testt/verilog/delay_constraints.g

syn_generic -effort medium

syn_map
syn_opt
gui_report_timing
gui_show

write_hdl > netlist.v 
write_sdc > constraint.sdc 


