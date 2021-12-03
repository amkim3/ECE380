transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/dev2/ECE380/bonusLab/w_and.vhd}
vcom -93 -work work {C:/dev2/ECE380/bonusLab/full_adder.vhd}
vcom -93 -work work {C:/dev2/ECE380/bonusLab/four_shiftreg.vhd}
vcom -93 -work work {C:/dev2/ECE380/bonusLab/bonusLab.vhd}
vcom -93 -work work {C:/dev2/ECE380/bonusLab/dflipflop.vhd}

