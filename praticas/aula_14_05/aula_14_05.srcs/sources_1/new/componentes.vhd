library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divisor_1hz is
    Generic (FREQ_CLOCK_IN :integer := 50000000);
    Port (
        clk_in   : in  STD_LOGIC;  -- Clock de entrada
        reset    : in  STD_LOGIC;  -- Reset síncrono
        clk_out  : out STD_LOGIC   -- Clock de 1 Hz
    );
end divisor_1hz;

architecture Behavioral of divisor_1hz is

    constant MAX_COUNT : integer := (FREQ_CLOCK_IN/2) - 1;
    signal counter     : integer range 0 to MAX_COUNT := 0;
    signal clk_reg     : STD_LOGIC := '0';

begin

    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if reset = '1' then
                counter <= 0;
                clk_reg <= '0';
            else
                if counter = MAX_COUNT then
                    counter <= 0;
                    clk_reg <= not clk_reg;  -- inverte clock de saída
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;

end Behavioral;