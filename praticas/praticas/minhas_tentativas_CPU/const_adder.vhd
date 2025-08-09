----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/06/2025 02:03:29 PM
-- Design Name: 
-- Module Name: const_adder - Behavioral
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
use IEEE.std_logic_unsigned.ALL;


entity const_adder is
    generic (N: integer := 16;
             B: integer := 1);
  Port (
    A: in std_logic_vector(N-1 downto 0);
    S: out std_logic_vector(N-1 downto 0)
   );
end const_adder;

architecture Behavioral of const_adder is

begin

S <= A + B;


end Behavioral;
