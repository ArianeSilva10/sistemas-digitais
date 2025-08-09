----------------------------------------------------------------------------------
-- Create Date: 05/23/2025 01:43:28 PM
-- Design Name: 
-- Module Name: datapath - Behavioral
-- Project Name: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity datapath is
    Generic (N :integer  := 16);
    Port(
        -- Portas do Registrador File
        rn_sel : in std_logic_vector (2 downto 0);
        rm_sel: in std_logic_vector (2 downto 0);
        rd_sel: in std_logic_vector (2 downto 0);
        rd_wr: in std_logic;
        
        -- ULA
        op_ula: in std_logic_vector (3 downto 0);
        
        -- mux rd
        din_ram: in std_logic_vector (N-1 downto 0);
        rd_immd: in std_logic_vector (N-1 downto 0);
        sel_rd_mux: in std_logic_vector (1 downto 0);
        
        -- clock e reset
        clk :in std_logic;
        rst :in std_logic 
    );
end datapath;

architecture Behavioral of datapath is
    signal  s_rd: std_logic_vector (N-1 downto 0);
    signal  s_rm: std_logic_vector (N-1 downto 0);
    signal  s_rn: std_logic_vector (N-1 downto 0);
    signal s_Q: std_logic_vector (N-1 downto 0);
begin

RF:
    entity work.register_file
    generic map(N => N)
    port map(
         -- Portas do Registrador File
        rn_sel => rn_sel,
        rm_sel => rm_sel,
        rd_sel => rd_sel,
        rd_wr => rd_wr,
        Rd => s_rd,
        Rm => s_rm,
        Rn => s_rn,
        clk => clk,
        rst => rst
    );

ULA:
    entity work.ula 
    generic map(N_BITS => N)
    port map(
        A => s_rm,
        B => s_rn,
        op => op_ula
    );

 MuxRd:
    entity work.mux4x1
    generic map(N => N)
    Port map(
        I0 => s_rm,
        I1 => rd_ram,
        I2 => rd_immd,
        I3 => s_Q,
        sel => sel_rd_mux,
        o0 => s_rd
    );

end Behavioral;
