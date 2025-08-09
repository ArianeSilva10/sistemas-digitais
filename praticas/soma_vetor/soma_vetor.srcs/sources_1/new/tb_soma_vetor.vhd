

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity tb_soma_vetor is
--  Port ( );
end tb_soma_vetor;

architecture Behavioral of tb_soma_vetor is

constant CLK_PERIOD: time := 10 ns; -- 100MHz

signal s_clk : std_logic := '0';
signal s_rst : std_logic := '0';

signal s_start : std_logic := '0';
signal s_data : std_logic_vector (31 downto 0) := (others => '0');
signal s_soma : std_logic_vector (6 downto 0);
signal s_done : std_logic;

begin
    DUT:
    entity work.soma_vetor
        Port map(
            clk => s_clk,
            rst => s_rst,
            start => s_start,
            data => s_data,
            soma => s_soma,
            done => s_done
        );
        
     s_clk <= not s_clk after CLK_PERIOD/2;
     
     stim_proc:
     process
     begin
        s_rst <= '1';     -- reset inicial
        wait for 20ns;
        s_rst <= '0';
        wait for 20ns;
        
        -- teste 1 : [1,2,3,4,5,6,7,8] = 36
        s_data <= "00010010001101000101011001111000";
        s_start <= '1';
        wait for CLK_PERIOD;
        s_start <= '0';
        
        wait until s_done = '1';
        
        -- teste 2 : [15,15,15,15,15,15,15,15] = 120
        s_data <= (others => '1');
        s_start <= '1';
        wait for CLK_PERIOD;
        s_start <= '0';
        
        wait until s_done = '1';
        
        -- teste 3 : [0,0,0,0,0,0,0,0] = 0
        s_data <= (others => '0');
        s_start <= '1';
        wait for CLK_PERIOD;
        s_start <= '0';
        
        wait until s_done = '1';
        
        wait for 50ns;
        wait;
        
     end process;

end Behavioral;
