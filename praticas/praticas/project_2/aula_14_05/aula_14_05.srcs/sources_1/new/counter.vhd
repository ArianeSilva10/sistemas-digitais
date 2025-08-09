library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity counter is
    generic (N_BITS :integer := 4);
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (N_BITS-1 downto 0));
end counter;

architecture Behavioral of counter is
   signal contador: STD_LOGIC_VECTOR (N_BITS-1 downto 0):= (others => '0');
   signal s_clk_out: STD_LOGIC;

component divisor_1hz is
    Generic (FREQ_CLOCK_IN :integer := 50000000);
    Port (
        clk_in   : in  STD_LOGIC;  -- Clock de entrada
        reset    : in  STD_LOGIC;  -- Reset síncrono
        clk_out  : out STD_LOGIC   -- Clock de 1 Hz
    );
end component;

begin

    dividor_clk:
    divisor_1hz
    Port map (
        clk_in=>clk,
        reset=>reset,
        clk_out=>s_clk_out
    );
    

    contagem: --nome do processo é opcional
    process (s_clk_out, reset) 
    begin
     if reset = '1' then
        contador <= (others => '0');
     else
      if rising_edge(s_clk_out) then
         if enable = '1' then
            contador <= contador +1;
         end if;
      end if;
         
    end if;
    
    end process;
    
    count <= contador;
    

end Behavioral;