library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity ula is
  Generic (N_BITS :integer:=16);
  Port (
    A: in std_logic_vector (N_BITS-1 downto 0);
    B: in std_logic_vector (N_BITS-1 downto 0);
    Q: out std_logic_vector (N_BITS-1 downto 0);
    op: in std_logic_vector(3 downto 0)
   );
end ula;

architecture Behavioral of ula is
   signal s_add: std_logic_vector (N_BITS-1 downto 0);
   signal s_sub: std_logic_vector (N_BITS-1 downto 0);
   signal s_mul: std_logic_vector (2*N_BITS-1 downto 0);
   signal s_and: std_logic_vector (N_BITS-1 downto 0);
   signal s_orr: std_logic_vector (N_BITS-1 downto 0);
   signal s_not: std_logic_vector (N_BITS-1 downto 0);
   signal s_xor: std_logic_vector (N_BITS-1 downto 0);
   signal s_cmp: std_logic_vector (N_BITS-1 downto 0);
   signal s_shr: std_logic_vector(N_BITS-1 downto 0);
   signal s_shl: std_logic_vector(N_BITS-1 downto 0);
   signal s_ror: std_logic_vector(N_BITS-1 downto 0);
   signal s_rol: std_logic_vector(N_BITS-1 downto 0);
   signal flag_z : std_logic;
   signal flag_c: std_logic;
   
begin

s_add <= A + B;
s_sub <= A - B;
s_mul <= A * B;
s_and <= A and B;
s_orr <= A or B;
s_not <= not A;
s_xor <= A xor B;

flag_z <= '1' when A = B else '0';
flag_c <= '1' when A < B else '0';
s_cmp <= (N_BITS - 1 downto 2 => '0') & flag_z & flag_c;

-- operacao de shr >> , cria um vetor, o bit mais a esquerda vira 0, os bits de A sao deslocados uma posicao a direita
s_shr <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));

s_shl <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
-- operacao de ror Rd = Rm >> 1
s_ror <= std_logic_vector(rotate_right(unsigned (A),1));

-- operacao de ror Rd = Rm << 1
s_rol <= std_logic_vector(rotate_left(unsigned (A),1));

Q <= s_add when op = "0100" else
     s_sub when op = "0101" else
     s_mul(N_BITS-1 downto 0) when op = "0110" else
     s_and when op = "0111" else
     s_orr when op = "1000" else
     s_not when op = "1001" else
     s_xor when op = "1010" else
     s_cmp when op = "1011" else
     s_shr when op = "1100" else
     s_ror when op = "1101" else
     s_shl when op = "1110" else
     s_rol when op = "1111" else
     (others => '0');

end Behavioral;