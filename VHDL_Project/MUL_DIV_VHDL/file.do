quit -sim
vcom ALU.vhd
vcom componentPackage.vhd
vcom Controller.vhd
vcom TB.vhd
vcom Top_Module.vhd
vcom UnivShiftReg.vhd
vsim -voptargs=+acc -gui -onfinish  stop work.test
add wave *

add wave -position end  sim:/test/uut/Ctrl/state
add wave -position end  sim:/test/uut/Ctrl/counter
run -all