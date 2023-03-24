onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {phase3} /phase3_tb/clk
add wave -noupdate -expand -group {phase3} /phase3_tb/rst
add wave -noupdate -expand -group {phase3} /phase3_tb/stop
add wave -noupdate -expand -group {phase3} /phase3_tb/inport_data_in
add wave -noupdate -expand -group {phase3} /phase3_tb/outport_data_out
add wave -noupdate -expand -group {phase3} /phase3_tb/bus_contents
add wave -noupdate -expand -group {phase3} /phase3_tb/operation
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R0/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R1/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R2/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R3/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R4/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R5/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R6/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R7/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R8/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R9/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R10/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R11/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R12/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R13/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R14/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/R15/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/HI_reg/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/LO_reg/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/IR/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/PC_reg/newPC
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/MDR/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/MAR/q
add wave -noupdate -expand -group {phase3} /phase3_tb/DUT/ramModule/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99999471 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {99999227 ps} {100000041 ps}
