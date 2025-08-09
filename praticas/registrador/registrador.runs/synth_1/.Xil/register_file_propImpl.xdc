set_property SRC_FILE_INFO {cfile:/home/ariane/Documentos/faculdade/semestre_5/sistemas_digitais/praticas/registrador/registrador.srcs/constrs_1/imports/Zybo-20250508/ZYBO_Master.xdc rfile:../../../registrador.srcs/constrs_1/imports/Zybo-20250508/ZYBO_Master.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L11P_T1_SRCC_35 Sch=sysclk
set_property src_info {type:XDC file:1 line:10 export:INPUT save:INPUT read:READ} [current_design]
create_clock -add -name sys_clk_pin -period 20ns -waveform {0 10} [get_ports { clk }];
set_property src_info {type:XDC file:1 line:14 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { d[0] }]; #IO_L19N_T3_VREF_35 Sch=SW0
set_property src_info {type:XDC file:1 line:15 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { d[1] }];  #IO_L24P_T3_34 Sch=SW1
set_property src_info {type:XDC file:1 line:16 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { d[2] }]; #IO_L4N_T0_34 Sch=SW2
set_property src_info {type:XDC file:1 line:17 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { d[3] }]; #IO_L9P_T1_DQS_34 Sch=SW3
set_property src_info {type:XDC file:1 line:21 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L20N_T3_34 Sch=BTN0
set_property src_info {type:XDC file:1 line:22 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { ld }]; #IO_L24N_T3_34 Sch=BTN1
set_property src_info {type:XDC file:1 line:28 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { q[0] }]; #IO_L23P_T3_35 Sch=LED0
set_property src_info {type:XDC file:1 line:29 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { q[1] }]; #IO_L23N_T3_35 Sch=LED1
set_property src_info {type:XDC file:1 line:30 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { q[2] }]; #IO_0_35=Sch=LED2
set_property src_info {type:XDC file:1 line:31 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { q[3] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=LED3
