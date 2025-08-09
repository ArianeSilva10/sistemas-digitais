vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/blk_mem_gen_v8_4_11

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap blk_mem_gen_v8_4_11 modelsim_lib/msim/blk_mem_gen_v8_4_11

vcom -work xil_defaultlib -64 -93  \
"../../../bd/design_1/ip/design_1_datapath_0_0/sim/design_1_datapath_0_0.vhd" \
"../../../bd/design_1/ip/design_1_mux2x1_0_0/sim/design_1_mux2x1_0_0.vhd" \
"../../../bd/design_1/ip/design_1_registrador_0_0/sim/design_1_registrador_0_0.vhd" \
"../../../bd/design_1/ip/design_1_registrador_0_1/sim/design_1_registrador_0_1.vhd" \
"../../../bd/design_1/ip/design_1_const_adder_0_0/sim/design_1_const_adder_0_0.vhd" \

vlog -work blk_mem_gen_v8_4_11 -64 -incr -mfcu  "+incdir+../../../../../../Xilinx2025/2025.1/data/rsb/busdef" \
"../../../../CPU.gen/sources_1/bd/design_1/ipshared/a32c/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../../../Xilinx2025/2025.1/data/rsb/busdef" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_1/sim/design_1_blk_mem_gen_0_1.v" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_2/sim/design_1_blk_mem_gen_0_2.v" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/design_1/ip/design_1_fsm_1_1/sim/design_1_fsm_1_1.vhd" \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

