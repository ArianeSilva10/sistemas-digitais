----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2025 04:10:48 PM
-- Design Name: 
-- Module Name: teste - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity teste is
    Port ( I0 : in STD_LOGIC;
           I1 : in STD_LOGIC;
           o0 : out STD_LOGIC;
           o1 : out STD_LOGIC);
end teste;

architecture Behavioral of teste is

begin

o0 <= i0;
o1 <= i1; 

end Behavioral;
