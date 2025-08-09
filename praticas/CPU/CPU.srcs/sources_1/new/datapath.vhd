library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity datapath is
    Generic (N : integer := 16);
    Port (
        -- Portas do Register File
        rn_sel     : in std_logic_vector (2 downto 0);
        rm_sel     : in std_logic_vector (2 downto 0);
        rd_sel     : in std_logic_vector (2 downto 0);
        rd_wr      : in std_logic;

        -- ULA
        op_ula     : in std_logic_vector (3 downto 0);
        
        -- Mux Rd
        rd_ram     : in std_logic_vector (N-1 downto 0);
        rd_immd    : in std_logic_vector (N-1 downto 0);
        sel_rd_mux : in std_logic_vector (2 downto 0);
        
        -- RAM
        Rm         : out std_logic_vector (N-1 downto 0);
        Rn         : out std_logic_vector (N-1 downto 0);
        
        -- Clock e reset
        clk        : in std_logic;
        rst        : in std_logic;
        sp_out : out std_logic_vector (N-1 downto 0);
        flag_z: out std_logic;
        flag_c: out std_logic; 
        
        pc_en : in std_logic;
        pc_src : in std_logic_vector(1 downto 0);
        immed : in std_logic_vector(N-1 downto 0);
        pc_out : out std_logic_vector(N-1 downto 0);
        
        -- tipo E/S
        io_write : in std_logic;
        data_out : out std_logic_vector (N-1 downto 0);  -- saida
        io_read  : in std_logic_vector (N-1 downto 0)              -- entrada
        
    );
end datapath;

architecture Behavioral of datapath is
    signal s_rd   : std_logic_vector (N-1 downto 0);
    signal s_rm   : std_logic_vector (N-1 downto 0);
    signal s_rn   : std_logic_vector (N-1 downto 0);
    signal s_Q    : std_logic_vector (N-1 downto 0);
    signal s_sp   : std_logic_vector (N-1 downto 0); -- Registrador SP interno
    signal ula_B  : std_logic_vector(N-1 downto 0);  -- Entrada B da ULA com seleção dinâmica
    signal pc     : std_logic_vector(N-1 downto 0);
begin

    sp_out <= s_sp;
    pc_out <= pc;
    
    data_out <= s_rm when io_write = '1' else (others => 'Z');
        
    -- flags da ula para o cmp
    flag_z <= s_Q(1);
    flag_c <= s_Q(0);
    -- Seleção dinâmica para entrada B da ULA
    ula_B <= s_rn when op_ula /= "0101" else rd_immd;

    -- Register File
    RF: entity work.register_file
        generic map(N => N)
        port map(
            Rm_sel => rm_sel,
            Rn_sel => rn_sel,
            Rd_sel => rd_sel,
            Rd_wr  => rd_wr,
            Rd     => s_rd,
            Rm     => s_rm,
            Rn     => s_rn,
            clk    => clk,
            rst    => rst
        );

    -- ULA
    ULA: entity work.ula
        generic map(N_BITS => N)
        port map (
            A  => s_rm,
            B  => ula_B,
            Q  => s_Q,
            op => op_ula
        );

    -- Mux 5x1 de entrada do registrador destino
    MuxRd: entity work.mux5x1
        generic map(N => N)
        port map(
            I0  => s_rm,
            I1  => rd_ram,
            I2  => rd_immd,
            I3  => s_Q,
            I4  => io_read,
            sel => sel_rd_mux,
            O0  => s_rd
        );

    -- Lógica para o registrador SP (pilha)
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_sp <= x"0100";
            elsif rd_wr = '1' and rd_sel = "111" then
                s_sp <= s_rd; -- Atualiza SP ao escrever em R7
            end if;
        end if;
    end process;
    
    -- Registrador PC
    process(clk)
    begin   
        if rising_edge(clk) then
            if rst = '1' then
                pc <= (others => '0');
            elsif pc_en = '1' then 
                case pc_src is
                    when "00" => 
                        pc <= std_logic_vector(unsigned(pc) + TO_UNSIGNED(1, N));
                    when "01" => 
                        pc <= std_logic_vector(signed(pc) + signed(immed));   -- JEQ
                    when "10" =>
                        pc <= std_logic_vector(signed(pc) + signed(immed));    -- JLT
                    when "11" =>
                        pc <= std_logic_vector(signed(pc) + signed(immed));   -- JGT
                    when others => null;
                end case;
            end if;
        end if;
    
    end process;

    -- Saídas para Rm e Rn, considerando SP (R7)
    Rm <= s_rm when rm_sel /= "111" else s_sp;
    Rn <= s_rn when rn_sel /= "111" else s_sp;

end Behavioral;