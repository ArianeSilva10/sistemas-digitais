library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_cmp is
end tb_cmp;

architecture behavior of tb_cmp is
    constant N : integer := 16;

    -- Sinais de entrada/saída do datapath
    signal clk       : std_logic := '0';
    signal rst       : std_logic := '1';
    signal rd_wr     : std_logic := '0';  -- habilita a escrita no register file
    signal op_ula    : std_logic_vector(3 downto 0) := (others => '0');
    signal rd_sel    : std_logic_vector(2 downto 0) := "000";
    signal rm_sel    : std_logic_vector(2 downto 0) := "001";
    signal rn_sel    : std_logic_vector(2 downto 0) := "010";
    signal flag_z    : std_logic;
    signal flag_c    : std_logic;

    -- Sinais extras exigidos pelo datapath
    signal rd_immd    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal rd_ram     : std_logic_vector(N-1 downto 0) := (others => '0');
    signal sel_rd_mux : std_logic_vector(1 downto 0) := "10";  -- seleciona rd_immd
    signal sp_out     : std_logic_vector(N-1 downto 0);

    -- Sinais de saída que não estamos usando diretamente
    signal rm_data    : std_logic_vector(N-1 downto 0);
    signal rn_data    : std_logic_vector(N-1 downto 0);

    -- UUT: datapath
    component datapath
        generic (N : integer := 16);
        port (
            rn_sel     : in std_logic_vector (2 downto 0);
            rm_sel     : in std_logic_vector (2 downto 0);
            rd_sel     : in std_logic_vector (2 downto 0);
            rd_wr      : in std_logic;
            op_ula     : in std_logic_vector (3 downto 0);
            rd_ram     : in std_logic_vector (N-1 downto 0);
            rd_immd    : in std_logic_vector (N-1 downto 0);
            sel_rd_mux : in std_logic_vector (1 downto 0);
            Rm         : out std_logic_vector (N-1 downto 0);
            Rn         : out std_logic_vector (N-1 downto 0);
            clk        : in std_logic;
            rst        : in std_logic;
            sp_out     : out std_logic_vector (N-1 downto 0);
            flag_z     : out std_logic;
            flag_c     : out std_logic
        );
    end component;

begin
    uut: datapath
        generic map (N => N)
        port map (
            rn_sel     => rn_sel,
            rm_sel     => rm_sel,
            rd_sel     => rd_sel,
            rd_wr      => rd_wr,
            op_ula     => op_ula,
            rd_ram     => rd_ram,
            rd_immd    => rd_immd,
            sel_rd_mux => sel_rd_mux,
            Rm         => rm_data,
            Rn         => rn_data,
            clk        => clk,
            rst        => rst,
            sp_out     => sp_out,
            flag_z     => flag_z,
            flag_c     => flag_c
        );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Estímulos
    stim_proc: process
    begin
        -- Reset
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        -- Escreve 0x0010 em R1
        rd_wr <= '1';
        rd_sel <= "001";             -- R1
        rd_immd <= x"0010";
        sel_rd_mux <= "10";          -- escolhe rd_immd
        wait for 10 ns;

        -- Escreve 0x0010 em R2
        rd_sel <= "010";             -- R2
        rd_immd <= x"0010";
        wait for 10 ns;

        -- Desativa escrita
        rd_wr <= '0';

        -- Testa CMP R1, R2 (iguais)
        rm_sel <= "001";             -- R1
        rn_sel <= "010";             -- R2
        op_ula <= "1011";            -- Op de CMP
        wait for 10 ns;

        -- Verifica flags aqui (espera flag_z = '1', flag_c = '0')

        -- Testa CMP R2, R1 (iguais, ordem invertida)
        rm_sel <= "010";             -- R2
        rn_sel <= "001";             -- R1
        wait for 10 ns;

        -- Escreve 0x0020 em R3
        rd_sel <= "011"; 
        rd_immd <= x"0020"; 
        rd_wr <= '1'; 
        wait for 10 ns;
        rd_wr <= '0';

        -- Testa CMP R1, R3 (0x0010 < 0x0020)
        rm_sel <= "001";             -- R1
        rn_sel <= "011";             -- R3
        wait for 10 ns;

        -- Aqui, espera: flag_z = '0', flag_c = '1'

        wait;
    end process;

end behavior;
