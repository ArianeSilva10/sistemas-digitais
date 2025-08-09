----------------------------------------------------------------------------------
-- Create Date: 05/30/2025 01:46:50 PM
-- Design Name: 
-- Module Name: tb_Soma2Maiores - Behavioral
-- Project Name: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use iEEE.std_logic_unsigned.all;


entity tb_Soma2Maiores is
--  Port ( );
end tb_Soma2Maiores;

architecture Behavioral of tb_Soma2Maiores is

    component Soma2Maiores  is
        Port(
            a : in std_logic_vector (3 downto 0);
            b : in std_logic_vector (3 downto 0);
            c : in std_logic_vector (3 downto 0);
            s: out std_logic_vector (3 downto 0)
        );
    end component;
    
    signal a, b, c, s : std_logic_vector(3 downto 0);
    signal somaTodos: std_logic_vector (4 downto 0); -- mais um bit por causa do carry (4 + carry)
    signal menor: std_logic_vector (3 downto 0);
    
begin

dut: Soma2Maiores
    port map (
        a => a,
        b => b,
        c => c,
        s => s
    );
    
    operacoes:
    process 
    begin
    
        a <= x"1";
        b <= x"2";
        c <= x"3";
        wait for 50 ns;       -- 5
        
        a <= x"2";
        b <= x"2";
        c <= x"3";
        wait for 50 ns;         -- 5
        
        a <= x"2";
        b <= x"2";
        c <= x"2";
        wait for 50 ns;          -- 4
        
        a <= x"5";
        b <= x"8";
        c <= x"4";
        wait for 50 ns;          -- 13, 0xd
        
        a <= x"1";
        b <= x"6";
        c <= x"3";
        wait for 50 ns;            -- 9
    
    end process;
    
    controle:
    process
    begin
        wait for 500 ns;
        assert false report "Fim da simulação." severity failure;
    end process;

end Behavioral;
