--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
--Date        : Fri Jul 11 15:00:33 2025
--Host        : ariane-550XDA running 64-bit Ubuntu 24.04.2 LTS
--Command     : generate_target hdmi.bd
--Design      : hdmi
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hdmi is
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
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of hdmi : entity is "hdmi,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=hdmi,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=4,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of hdmi : entity is "hdmi.hwdef";
end hdmi;

architecture STRUCTURE of hdmi is
  component hdmi_video_source_0_0 is
  port (
    clk : in STD_LOGIC;
    video_en : in STD_LOGIC;
    w_address : in STD_LOGIC_VECTOR ( 14 downto 0 );
    din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    we : in STD_LOGIC;
    r : out STD_LOGIC_VECTOR ( 7 downto 0 );
    g : out STD_LOGIC_VECTOR ( 7 downto 0 );
    b : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component hdmi_video_source_0_0;
  component hdmi_rom_0_0 is
  port (
    clk : in STD_LOGIC;
    address : in STD_LOGIC_VECTOR ( 14 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component hdmi_rom_0_0;
  component hdmi_pdi_0_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    start : in STD_LOGIC;
    op : in STD_LOGIC_VECTOR ( 3 downto 0 );
    din : in STD_LOGIC_VECTOR ( 23 downto 0 );
    rom_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    ram_we : out STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 23 downto 0 );
    ram_addr : out STD_LOGIC_VECTOR ( 14 downto 0 )
  );
  end component hdmi_pdi_0_0;
  component hdmi_clk_wiz_0_0 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC
  );
  end component hdmi_clk_wiz_0_0;
  component hdmi_video_out_0_0 is
  port (
    clk250 : in STD_LOGIC;
    R : in STD_LOGIC_VECTOR ( 7 downto 0 );
    G : in STD_LOGIC_VECTOR ( 7 downto 0 );
    B : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk25 : out STD_LOGIC;
    video_en : out STD_LOGIC;
    HDMI_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_clk_n : out STD_LOGIC;
    HDMI_clk_p : out STD_LOGIC;
    v_sync : out STD_LOGIC;
    h_sync : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component hdmi_video_out_0_0;
  signal Net : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal pdi_0_dout : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal pdi_0_ram_addr : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal pdi_0_ram_we : STD_LOGIC;
  signal pdi_0_rom_addr : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal rom_0_dout : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal video_out_0_video_en : STD_LOGIC;
  signal video_source_0_b : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal video_source_0_g : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal video_source_0_r : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of HDMI_clk_n : signal is "xilinx.com:signal:clock:1.0 CLK.HDMI_CLK_N CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of HDMI_clk_n : signal is "XIL_INTERFACENAME CLK.HDMI_CLK_N, CLK_DOMAIN hdmi_video_out_0_0_HDMI_clk_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of HDMI_clk_p : signal is "xilinx.com:signal:clock:1.0 CLK.HDMI_CLK_P CLK";
  attribute X_INTERFACE_PARAMETER of HDMI_clk_p : signal is "XIL_INTERFACENAME CLK.HDMI_CLK_P, CLK_DOMAIN hdmi_video_out_0_0_HDMI_clk_p, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of clk_in1_0 : signal is "xilinx.com:signal:clock:1.0 CLK.CLK_IN1_0 CLK";
  attribute X_INTERFACE_PARAMETER of clk_in1_0 : signal is "XIL_INTERFACENAME CLK.CLK_IN1_0, CLK_DOMAIN hdmi_clk_in1_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 RST.RST RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME RST.RST, INSERT_VIP 0, POLARITY ACTIVE_LOW";
begin
clk_wiz_0: component hdmi_clk_wiz_0_0
     port map (
      clk_in1 => clk_in1_0,
      clk_out1 => clk_wiz_0_clk_out1
    );
pdi_0: component hdmi_pdi_0_0
     port map (
      clk => Net,
      din(23 downto 0) => rom_0_dout(23 downto 0),
      dout(23 downto 0) => pdi_0_dout(23 downto 0),
      op(3 downto 0) => op(3 downto 0),
      ram_addr(14 downto 0) => pdi_0_ram_addr(14 downto 0),
      ram_we => pdi_0_ram_we,
      rom_addr(14 downto 0) => pdi_0_rom_addr(14 downto 0),
      rst => rst,
      start => start
    );
rom_0: component hdmi_rom_0_0
     port map (
      address(14 downto 0) => pdi_0_rom_addr(14 downto 0),
      clk => Net,
      dout(23 downto 0) => rom_0_dout(23 downto 0)
    );
video_out_0: component hdmi_video_out_0_0
     port map (
      B(7 downto 0) => video_source_0_b(7 downto 0),
      G(7 downto 0) => video_source_0_g(7 downto 0),
      HDMI_clk_n => HDMI_clk_n,
      HDMI_clk_p => HDMI_clk_p,
      HDMI_data_n(2 downto 0) => HDMI_data_n(2 downto 0),
      HDMI_data_p(2 downto 0) => HDMI_data_p(2 downto 0),
      R(7 downto 0) => video_source_0_r(7 downto 0),
      clk25 => Net,
      clk250 => clk_wiz_0_clk_out1,
      h_sync => h_sync,
      v_sync => v_sync,
      vga_b(4 downto 0) => vga_b_0(4 downto 0),
      vga_g(5 downto 0) => vga_g_0(5 downto 0),
      vga_r(4 downto 0) => vga_r_0(4 downto 0),
      video_en => video_out_0_video_en
    );
video_source_0: component hdmi_video_source_0_0
     port map (
      b(7 downto 0) => video_source_0_b(7 downto 0),
      clk => Net,
      din(23 downto 0) => pdi_0_dout(23 downto 0),
      g(7 downto 0) => video_source_0_g(7 downto 0),
      r(7 downto 0) => video_source_0_r(7 downto 0),
      video_en => video_out_0_video_en,
      w_address(14 downto 0) => pdi_0_ram_addr(14 downto 0),
      we => pdi_0_ram_we
    );
end STRUCTURE;
