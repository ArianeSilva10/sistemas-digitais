--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
--Date        : Fri Jul 11 15:00:33 2025
--Host        : ariane-550XDA running 64-bit Ubuntu 24.04.2 LTS
--Command     : generate_target hdmi_wrapper.bd
--Design      : hdmi_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hdmi_wrapper is
  port (
    HDMI_clk_n : out STD_LOGIC;
    HDMI_clk_p : out STD_LOGIC;
    HDMI_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    clk_in1_0 : in STD_LOGIC;
    h_sync : out STD_LOGIC;
    op : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rst : in STD_LOGIC;
    start : in STD_LOGIC;
    v_sync : out STD_LOGIC;
    vga_b_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g_0 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_r_0 : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
end hdmi_wrapper;

architecture STRUCTURE of hdmi_wrapper is
  component hdmi is
  port (
    rst : in STD_LOGIC;
    start : in STD_LOGIC;
    op : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clk_in1_0 : in STD_LOGIC;
    HDMI_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_clk_n : out STD_LOGIC;
    HDMI_clk_p : out STD_LOGIC;
    v_sync : out STD_LOGIC;
    h_sync : out STD_LOGIC;
    vga_r_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g_0 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_b_0 : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component hdmi;
begin
hdmi_i: component hdmi
     port map (
      HDMI_clk_n => HDMI_clk_n,
      HDMI_clk_p => HDMI_clk_p,
      HDMI_data_n(2 downto 0) => HDMI_data_n(2 downto 0),
      HDMI_data_p(2 downto 0) => HDMI_data_p(2 downto 0),
      clk_in1_0 => clk_in1_0,
      h_sync => h_sync,
      op(3 downto 0) => op(3 downto 0),
      rst => rst,
      start => start,
      v_sync => v_sync,
      vga_b_0(4 downto 0) => vga_b_0(4 downto 0),
      vga_g_0(5 downto 0) => vga_g_0(5 downto 0),
      vga_r_0(4 downto 0) => vga_r_0(4 downto 0)
    );
end STRUCTURE;
