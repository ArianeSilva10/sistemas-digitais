library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity tb_counter is
--  Port ( );
end tb_counter;

architecture Behavioral of tb_counter is

component counter is
    generic (N_BITS :integer := 4);
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (N_BITS-1 downto 0));
end component;
 constant N_BITS: integer := 4;
 constant CLK_PERIOD: time := 10ns; -- 100MHz
 
 signal s_clk    : STD_LOGIC := '0';
 signal s_reset  : STD_LOGIC := '1';
 signal s_enable : STD_LOGIC := '0';
 signal s_count  : STD_LOGIC_VECTOR(N_BITS-1 downto 0);

begin
    DUT:
    counter
    generic map(N_BITS => N_BITS)
    port map (
     clk => s_clk,
     reset => s_reset,
     enable=>s_enable,
     count=>s_count
    );  
    
    clock:
    s_clk <= not s_clk after CLK_PERIOD/2;
    
    demais_sinais:
    process
    begin
    
    wait for CLK_PERIOD;
    s_reset <= '0';
    s_enable <= '1';
   
    wait until s_count = 10;
    s_enable <= '0';
    
    wait for CLK_PERIOD*2;
    s_enable <= '1';
    
    wait until s_count = 5;
    s_reset <= '1';
    
    wait for CLK_PERIOD*2;
    s_reset <= '0';

    end process;
    
    
    controle:
    process
    begin
        wait for 300 ns;
        assert false report "Fim da simulação." severity failure;
    end process;


end Behavioral;