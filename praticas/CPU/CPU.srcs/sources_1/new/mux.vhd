library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux5x1 is
  generic (N :integer := 16);
  Port (
   I0:in std_logic_vector(N-1 downto 0);
   I1:in std_logic_vector(N-1 downto 0);
   I2:in std_logic_vector(N-1 downto 0);
   I3:in std_logic_vector(N-1 downto 0);
   I4: in std_logic_vector(N-1 downto 0);
   sel:in std_logic_vector(2 downto 0);
   O0:out std_logic_vector(N-1 downto 0)
  );

end mux5x1;

architecture Behavioral of mux5x1 is
begin

O0 <=   I0 when sel ="000" else
        I1 when sel ="001" else
        I2 when sel ="010" else
        I3 when sel ="011" else
        I4 when sel = "100" else
        I0;
        
end Behavioral;