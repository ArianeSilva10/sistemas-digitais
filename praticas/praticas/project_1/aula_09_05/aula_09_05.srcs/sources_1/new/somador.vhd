library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_somador is
--  Port ( );
end tb_somador;

architecture Behavioral of tb_somador is
--sinais
signal s_A: std_logic_vector(3 downto 0);
signal s_B: std_logic_vector(3 downto 0);
signal s_S: std_logic_vector(3 downto 0);

-- declaração do componente somador
component somador is
  generic (
    N_BITS : integer := 4
  );
  Port ( 
    A : in std_logic_vector(N_BITS-1 downto 0);
    B : in std_logic_vector(N_BITS-1 downto 0);
    S: out std_logic_vector(N_BITS-1 downto 0)
  );
end component;

begin

DUT:
component somador port map (
    A => s_A,
    B => s_B,
    S => s_S
);


stimulus:
process
begin

wait for 100ns;
s_A <= "1010";
s_B <= "0001";

wait for 100ns;
s_A <= "0010";
s_B <= "0100";
 
 wait;
end process;




end Behavioral;
