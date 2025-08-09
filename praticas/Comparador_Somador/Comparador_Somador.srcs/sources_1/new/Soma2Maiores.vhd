------------------------------------------------------------------------------------ 
-- Create Date: 05/27/2025 07:31:39 PM
-- Design Name: 
-- Module Name: Soma2Maiores - Behavioral
-- Project Name: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use iEEE.std_logic_unsigned.all;


entity Soma2Maiores is
    Port(
        a : in std_logic_vector (3 downto 0);
        b : in std_logic_vector (3 downto 0);
        c : in std_logic_vector (3 downto 0);
        s: out std_logic_vector (3 downto 0)
    );
end Soma2Maiores;

architecture Behavioral of Soma2Maiores is
    signal somaTodos: std_logic_vector (3 downto 0); 
    signal menor: std_logic_vector (3 downto 0);
begin

    somaTodos <= a + b + c;
    
    menor <= a when (a < b and a < c) else
             b when (b < a and b < c) else 
                    c;
    
    
    s <= std_logic_vector(somaTodos - menor);


end Behavioral;
