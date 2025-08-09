library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- deu certo

entity tb_psh is
end tb_psh;

architecture behavior of tb_psh is

    constant N : integer := 16;
    constant CLK_PERIOD : time := 10 ns;

    -- sinais de entrada
    signal clk       : std_logic := '0';
    signal rst       : std_logic := '1';
    signal rn_sel    : std_logic_vector(2 downto 0) := (others => '0');
    signal rm_sel    : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_sel    : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_wr     : std_logic := '0';
    signal op_ula    : std_logic_vector(3 downto 0) := (others => '0');
    signal rd_ram    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal rd_immd   : std_logic_vector(N-1 downto 0) := (others => '0');
    signal sel_rd_mux: std_logic_vector(1 downto 0) := (others => '0');

    -- sinais de saída
    signal Rm        : std_logic_vector(N-1 downto 0);
    signal Rn        : std_logic_vector(N-1 downto 0);
    signal sp_out    : std_logic_vector(N-1 downto 0);

begin

    -- Instancia o datapath
    uut_datapath: entity work.datapath
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
            Rm         => Rm,
            Rn         => Rn,
            clk        => clk,
            rst        => rst,
            sp_out     => sp_out
        );

    -- Clock process
    clk_process: process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- reset inicial
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for CLK_PERIOD;

        -- Inicialmente, SP deve ser 0x0100 (definido no datapath)

        -- Agora, simulamos uma escrita no SP (R7) para ver se o s_sp atualiza
        -- Por exemplo, escrevendo valor 0x0050 no registrador destino (R7)
        rd_sel <= "111";      -- seleciona R7 (SP)
        rd_wr <= '1';         -- habilita escrita
        rd_ram <= (others => '0');
        rd_immd <= (others => '0');
        sel_rd_mux <= "10";   -- seleciona rd_immd para escrever no registrador (ajuste conforme seu mux)
        rd_immd <= x"0050";   -- novo valor a ser escrito
        op_ula <= "0000";     -- operação ULA neutra (ajuste se necessário)
        rm_sel <= "000";
        rn_sel <= "000";

        wait for CLK_PERIOD;

        -- Desabilita escrita
        rd_wr <= '0';

        wait for 3 * CLK_PERIOD;

        -- Finaliza a simulação
        wait;
    end process;

    -- Monitor SP
    monitor_proc: process
    begin
        wait until rst = '0';
        wait for CLK_PERIOD;

        wait for 2 * CLK_PERIOD;
        wait;
    end process;

end behavior;
