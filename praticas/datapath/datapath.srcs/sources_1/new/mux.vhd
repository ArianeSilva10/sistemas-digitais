----------------------------------------------------------------------------------
-- Create Date: 05/23/2025 01:55:51 PM
-- Design Name: 
-- Module Name: mux - Behavioral
-- Project Name: 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux4x1 is
    generic (N : integer:= 16);
    Port(
        I0: in std_logic_vector (N-1 downto 0);
        I1: in std_logic_vector (N-1 downto 0);
        I2: in std_logic_vector (N-1 downto 0);
        I3: in std_logic_vector (N-1 downto 0);
        sel: in std_logic_vector (1 downto 0);
        o0: out std_logic_vector (N-1 downto 0)
    );
    
end mux4x1;

architecture Behavioral of mux4x1 is

begin

o0 <= I0 when sel ="00" else
    I1 when sel ="01" else
    I2 when sel ="10" else
    I3 when sel ="11" else
    i0;

end Behavioral;
