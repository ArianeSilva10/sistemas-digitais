----------------------------------------------------------------------------------
-- Create Date: 05/21/2025 04:18:59 PM
-- Design Name: 
-- Module Name: register_file - Behavioral
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity register_file is
    generic (N : integer:= 16);
    Port ( Rm_sel : in STD_LOGIC_VECTOR (2 downto 0);
           Rn_sel : in STD_LOGIC_VECTOR (2 downto 0);
           Rd_sel : in STD_LOGIC_VECTOR (2 downto 0);
           Rm : out STD_LOGIC_VECTOR (N-1 downto 0);
           Rn : out STD_LOGIC_VECTOR (N-1 downto 0);
           Rd : in STD_LOGIC_VECTOR (N-1 downto 0);
           Rd_wr : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end register_file;

architecture Behavioral of register_file is


    signal s_ld : std_logic_vector  (7 downto 0);
    signal q0,q1,q2,q3,q4,q5,q6,q7 : std_logic_vector  (N-1 downto 0);

begin

    R0: entity work.registrador
        generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q0, ld => s_ld(0));
    R1: entity work.registrador
        generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q1, ld => s_ld(1));
    R2: entity work.registrador
        generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q2, ld =>s_ld(2));
    R3: entity work.registrador
    generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q3, ld =>s_ld(3));
    R4: entity work.registrador
        generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q4, ld =>s_ld(4));
    R5: entity work.registrador
        generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q5, ld =>s_ld(5));
    R6: entity work.registrador
        generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q6, ld =>s_ld(6));
    R7: entity work.registrador
        generic map(N => 16)
        port map(clk => clk, rst => rst, d => Rd, q => q7, ld =>s_ld(7));

    -- saida Rm DMUX
    Rm <= q0 when Rm_sel = "000" else
        q1 when Rm_sel = "001" else
        q2 when Rm_sel = "010" else
        q3 when Rm_sel = "011" else
        q4 when Rm_sel = "100" else
        q5 when Rm_sel = "101" else
        q6 when Rm_sel = "110" else
        q7 when Rm_sel = "111" else
        q0 ;                                     -- quando ele nao eh ninguem vai ser r0


    -- saida Rn DMUX
    Rn <= q0 when Rn_sel = "000" else
        q1 when Rn_sel = "001" else
        q2 when Rn_sel = "010" else
        q3 when Rn_sel = "011" else
        q4 when Rn_sel = "100" else
        q5 when Rn_sel = "101" else
        q6 when Rn_sel = "110" else
        q7 when Rn_sel = "111" else
        q0 ;                                     -- quando ele nao eh ninguem vai ser r0
        
        
    -- Entrada Rd DMUX
    s_ld(0) <= Rd_wr when Rd_sel = "000" else '0';
    s_ld(1) <= Rd_wr when Rd_sel = "001" else '0';
    s_ld(2) <= Rd_wr when Rd_sel = "010" else '0';
    s_ld(3) <= Rd_wr when Rd_sel = "011" else '0';
    s_ld(4) <= Rd_wr when Rd_sel = "100" else '0';
    s_ld(5) <= Rd_wr when Rd_sel = "101" else '0';
    s_ld(6) <= Rd_wr when Rd_sel = "110" else '0';
    s_ld(7) <= Rd_wr when Rd_sel = "111" else '0';
    
        
end Behavioral;
