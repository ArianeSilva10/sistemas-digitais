library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity tb_ula is
--  Port ( );
end tb_ula;

architecture Behavioral of tb_ula is


-- Instancia da ULA
component ula is
    generic (N_BITS :integer := 16);
    Port(
        A: in std_logic_vector (N_BITS-1 downto 0);
        B: in std_logic_vector (N_BITS-1 downto 0);
        Q: out std_logic_vector (N_BITS-1 downto 0);
        op: in std_logic_vector (3 downto 0)
    );
end component;


 constant N_BITS: integer := 16;
 
    -- sinais de estimulo e resposta
    signal A ,B: std_logic_vector(N_BITS-1 downto 0);
    signal Q: std_logic_vector (N_BITS-1 downto 0);
    signal op: std_logic_vector (3 downto 0);

begin

    dut: ula
        generic map(N_BITS => N_BITS)
        port map (
            A => A,
            B => B,
            Q => Q,
            op => op
        );
        
     operacoes:
     process
     begin
        -- soma
        A <= x"0001";
        B <= x"0002";
        op <= "0100";
        wait for 50 ns;
        
        -- subtracao
        A <= x"0007";
        B <= x"0002";
        op <= "0101";
        wait for 50 ns;
        
        --multiplicacao
        A <= x"0003";
        B <= x"0002";
        op <= "0110";
        wait for 50 ns;
        
        -- and
        A <= x"00f0";
        B <= x"0ff0";
        op <= "0111";
        wait for 50 ns;
        
        --or
        A <= x"00f0";
        B <= x"0ff0";
        op <= "1000";
        wait for 50 ns;
        
        --not 
        A <= x"00f0";
        B <= x"0000";
        op <= "1001";
        wait for 50 ns;
        
        --xor
        A <= x"ff00";
        B <= x"0ff0";
        op <= "1010";
        wait for 50 ns;
        
       end process;
    
    
    controle:
    process
    begin
        wait for 500 ns;
        assert false report "Fim da simulação." severity failure;
    end process;

end Behavioral;