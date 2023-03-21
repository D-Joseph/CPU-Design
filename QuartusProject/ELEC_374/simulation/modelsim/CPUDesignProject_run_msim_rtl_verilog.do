transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/sub_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/rotate_right_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/rotate_left_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/reg_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/not_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/negate_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/mux_32_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/multiplication_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/encoder_32_to_5.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/division_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/CPUDesignProject.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/adder_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/IncPC_32_bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/2_to_4_encoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/4_to_16_encoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/CONFF_logic.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/selectencodelogic.v}
vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/ram.v}

vlog -vlog01compat -work work +incdir+C:/Users/Luka/Documents/Queens/Third\ Year/ELEC\ 374/CPU-Design/QuartusProject/ELEC_374 {C:/Users/Luka/Documents/Queens/Third Year/ELEC 374/CPU-Design/QuartusProject/ELEC_374/mfhi_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  mfhi_tb

add wave *
view structure
view signals
run 1000 ns
