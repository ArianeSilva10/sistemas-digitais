library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_psh is
end tb_psh;

architecture behavior of tb_psh is

    constant N : integer := 16;
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '1';
    signal we       : std_logic;
    signal din      : std_logic_vector(N-1 downto 0);
    signal ra       : std_logic_vector(2 downto 0);
    signal sp_in    : std_logic_vector(2 downto 0);
    signal sp_out   : std_logic_vector(2 downto 0);
    signal dout     : std_logic_vector(N-1 downto 0);

    component psh
        generic (N : integer := 16);
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            we      : in std_logic;
            din     : in std_logic_vector(N-1 downto 0);
            ra      : in std_logic_vector(2 downto 0);
            sp_in   : in std_logic_vector(2 downto 0);
            sp_out  : out std_logic_vector(2 downto 0);
            dout    : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin

    uut: psh
        generic map (N => N)
        port map (
            clk     => clk,
            rst     => rst,
            we      => we,
            din     => din,
            ra      => ra,
            sp_in   => sp_in,
            sp_out  => sp_out,
            dout    => dout
        );

    -- Clock: 10ns period
    clk_process: process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin
        -- Inicializa
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        -- Configura push
        din     <= x"000A";          -- dado: 10
        ra      <= "000";            -- registrador origem
        sp_in   <= "111";            -- stack pointer apontando p/ R7
        we      <= '1';              -- habilita escrita
        wait for 10 ns;

        -- Desativa escrita
        we <= '0';
        wait for 20 ns;

        -- Fim
        wait;
    end process;

end behavior;
