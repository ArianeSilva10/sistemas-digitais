----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2025 04:49:41 PM
-- Design Name: 
-- Module Name: mux2x1 - Behavioral
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

entity mux2x1 is
    Port ( i0 : in STD_LOGIC_VECTOR (1 downto 0);
           i1 : in STD_LOGIC_VECTOR (1 downto 0);
           sel : in STD_LOGIC;
           o0 : out STD_LOGIC_VECTOR (1 downto 0));
end mux2x1;

architecture Behavioral of mux2x1 is

begin

o0 <= i0 when (sel = '1') else
i0 when (sel = '0') else
(others => '0');

end Behavioral;
