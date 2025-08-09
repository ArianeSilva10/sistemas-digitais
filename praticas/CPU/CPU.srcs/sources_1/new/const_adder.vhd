
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity const_adder is
    generic (N: integer := 16;
             B: integer :=1);
    Port ( A : in STD_LOGIC_VECTOR (N-1 downto 0);
           S : out STD_LOGIC_VECTOR (N-1 downto 0));
end const_adder;

architecture Behavioral of const_adder is

begin

S <= A + B;

end Behavioral;