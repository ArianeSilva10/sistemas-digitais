--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
--Date        : Wed Apr 16 17:05:08 2025
--Host        : ariane-550XDA running 64-bit Ubuntu 24.04.2 LTS
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    I0_0 : in STD_LOGIC;
    I1_0 : in STD_LOGIC;
    o0_0 : out STD_LOGIC;
    o1_0 : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    o0_0 : out STD_LOGIC;
    o1_0 : out STD_LOGIC;
    I0_0 : in STD_LOGIC;
    I1_0 : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      I0_0 => I0_0,
      I1_0 => I1_0,
      o0_0 => o0_0,
      o1_0 => o1_0
    );
end STRUCTURE;
