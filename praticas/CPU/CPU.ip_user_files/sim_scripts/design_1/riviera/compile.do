transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xil_defaultlib
vlib riviera/blk_mem_gen_v8_4_11

vmap xil_defaultlib riviera/xil_defaultlib
vmap blk_mem_gen_v8_4_11 riviera/blk_mem_gen_v8_4_11

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_datapath_0_0/sim/design_1_datapath_0_0.vhd" \
"../../../bd/design_1/ip/design_1_mux2x1_0_0/sim/design_1_mux2x1_0_0.vhd" \
"../../../bd/design_1/ip/design_1_registrador_0_0/sim/design_1_registrador_0_0.vhd" \
"../../../bd/design_1/ip/design_1_registrador_0_1/sim/design_1_registrador_0_1.vhd" \
"../../../bd/design_1/ip/design_1_const_adder_0_0/sim/design_1_const_adder_0_0.vhd" \

vlog -work blk_mem_gen_v8_4_11  -incr -v2k5 "+incdir+../../../../../../Xilinx2025/2025.1/data/rsb/busdef" -l xil_defaultlib -l blk_mem_gen_v8_4_11 \
"../../../../CPU.gen/sources_1/bd/design_1/ipshared/a32c/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../../Xilinx2025/2025.1/data/rsb/busdef" -l xil_defaultlib -l blk_mem_gen_v8_4_11 \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_1/sim/design_1_blk_mem_gen_0_1.v" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_2/sim/design_1_blk_mem_gen_0_2.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_fsm_1_1/sim/design_1_fsm_1_1.vhd" \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

