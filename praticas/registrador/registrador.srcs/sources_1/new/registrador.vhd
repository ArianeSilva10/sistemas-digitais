----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2025 03:40:26 PM
-- Design Name: 
-- Module Name: registrador - Behavioral
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

entity registrador is
--  Port ( );
    generic (n : integer := 4);
    port(
        clk: in std_logic;
        ld: in std_logic;
        rst: in std_logic;
        d: in std_logic_vector (N-1 downto 0);
        q: out std_logic_vector (N-1 downto 0)
    );
end registrador;

architecture Behavioral of registrador is

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then 
                q <= (others  => '0');
             
            else
                if ld = '1' then
                    q <= d;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
