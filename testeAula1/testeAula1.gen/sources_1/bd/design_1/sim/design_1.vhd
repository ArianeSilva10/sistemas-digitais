--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
--Date        : Wed Apr 16 17:05:08 2025
--Host        : ariane-550XDA running 64-bit Ubuntu 24.04.2 LTS
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    I0_0 : in STD_LOGIC;
    I1_0 : in STD_LOGIC;
    o0_0 : out STD_LOGIC;
    o1_0 : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_teste_0_0 is
  port (
    I0 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    o0 : out STD_LOGIC;
    o1 : out STD_LOGIC
  );
  end component design_1_teste_0_0;
begin
teste_0: component design_1_teste_0_0
     port map (
      I0 => I0_0,
      I1 => I1_0,
      o0 => o0_0,
      o1 => o1_0
    );
end STRUCTURE;
