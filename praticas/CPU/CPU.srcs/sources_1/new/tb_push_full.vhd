library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_push_full is
end entity;

architecture behavior of tb_push_full is
    constant N : integer := 16;
    constant CLK_PERIOD : time := 10 ns;

    -- sinais
    signal clk        : std_logic := '0';
    signal rst        : std_logic := '1';
    signal rn_sel     : std_logic_vector(2 downto 0) := (others => '0');
    signal rm_sel     : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_sel     : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_wr      : std_logic := '0';
    signal op_ula     : std_logic_vector(3 downto 0) := (others => '0');
    signal rd_ram     : std_logic_vector(N-1 downto 0) := (others => '0');
    signal rd_immd    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal sel_rd_mux : std_logic_vector(1 downto 0) := (others => '0');
    signal Rm         : std_logic_vector(N-1 downto 0);
    signal Rn         : std_logic_vector(N-1 downto 0);
    signal sp_out     : std_logic_vector(N-1 downto 0);
    signal dout       : std_logic_vector(N-1 downto 0); -- dado a ser escrito (suponha que existe)
    signal we         : std_logic := '0'; -- write enable para RAM (se usar)
    
begin

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

    -- Instancia datapath ou componente push, ajuste conforme seu projeto
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

    -- Stimulus process: simula push
    stim_proc: process
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for CLK_PERIOD;

        -- SP começa em 0x0100 (reset)

        -- Configura para escrever dado no push
        -- Exemplo: push o valor 0x00AA que está em R0 (rm_sel = "000")
        -- O SP será decrementado e o dado gravado na RAM na posição SP
        rn_sel <= "111";           -- Rn = SP (para ULA)
        rm_sel <= "000";           -- Rm = R0 (dado para push)
        rd_sel <= "111";           -- escreve em SP
        rd_wr  <= '1';             -- habilita escrita no SP
        op_ula <= "0101";          -- operação SUB (para decrementar SP)
        rd_immd <= x"0001";        -- decrementa SP em 1
        sel_rd_mux <= "11";        -- seleciona saída da ULA para atualizar SP
        rd_ram <= (others => '0'); -- dado na RAM não usado aqui

        wait for CLK_PERIOD;

        -- Agora simula a escrita do dado no endereço SP (não detalhado aqui, depende do módulo RAM)
        we <= '1'; -- ativa escrita na RAM
        dout <= x"00AA"; -- dado a ser empurrado para pilha (push)
        wait for CLK_PERIOD;

        rd_wr <= '0';
        we <= '0';

        wait for 3 * CLK_PERIOD;


        wait;
    end process;

end architecture;
