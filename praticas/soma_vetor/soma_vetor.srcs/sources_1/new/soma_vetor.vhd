
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity soma_vetor is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start: in STD_LOGIC;    -- comeco da soma
           data : in STD_LOGIC_VECTOR (31 downto 0); -- 8 * 4 bits
           soma : out STD_LOGIC_VECTOR (6 downto 0);
           done : out STD_LOGIC  -- fim da soma
           );
end soma_vetor;

architecture Behavioral of soma_vetor is

   type vetor is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
   signal dados : vetor;
   signal acumulador : unsigned (6 downto 0);
   signal count : integer range 0 to 8;
   signal controle : STD_LOGIC;
   type estado is (PARADO, SOMANDO, TERMINOU);
   signal estado_atual : estado;

begin
    -- pega 32 bits de data e separa em 8 valores de 4 bits e guarda em dados
    process(data)
    begin
        for i in 0 to 7 loop
            dados(i) <= data((i+1)*4-1 downto i*4);
        end loop;
    end process;
    
    process(clk, rst)
    begin
        if (rst = '1') then 
            acumulador <= (others => '0');
            count <= 0;
            estado_atual <= PARADO;
            done <= '0';
            
        elsif rising_edge (clk) then
            case estado_atual is
                when PARADO =>
                    done <= '0';
                    acumulador <= (others => '0');
                    count <= 0;
                    
                    if(start = '1') then
                    
                        estado_atual <= SOMANDO;
                    
                    end if;
                when SOMANDO =>
                    if (count < 8) then
                      acumulador <= acumulador + unsigned (dados(count));
                      count <= count + 1;
                    else
                        estado_atual <= TERMINOU;  
                    end if;
                    
                when TERMINOU =>
                    done <= '1';
                    if (start = '0') then
                        estado_atual <= PARADO;
                    end if;
                    
             end case;
        end if;
    
    end process;
    
    soma <= std_logic_vector (acumulador);

end Behavioral;
