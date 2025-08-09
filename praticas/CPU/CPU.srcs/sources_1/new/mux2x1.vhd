----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2025 02:30:44 PM
-- Design Name: 
-- Module Name: mux2x1 - Behavioral
-- Project Name: 
----------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux2x1 is
    Port ( i0 : in STD_LOGIC_VECTOR (3 downto 0);
           i1 : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC;
           o0 : out STD_LOGIC_VECTOR (3 downto 0));
end mux2x1;

architecture Behavioral of mux2x1 is

begin


o0 <= i1 when (sel = '1') else
    i0;

end Behavioral;
