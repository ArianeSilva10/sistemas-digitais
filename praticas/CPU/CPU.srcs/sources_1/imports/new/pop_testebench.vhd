library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pop_instruction is
end tb_pop_instruction;

architecture sim of tb_pop_instruction is

    constant N : integer := 16;
    constant CLK_PERIOD : time := 10 ns;

    signal clk        : std_logic := '0';
    signal rst        : std_logic := '1';

    signal rn_sel     : std_logic_vector(2 downto 0) := (others => '0');
    signal rm_sel     : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_sel     : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_wr      : std_logic := '0';

    signal op_ula     : std_logic_vector(3 downto 0) := (others => '0');
    signal rd_ram     : std_logic_vector(N-1 downto 0) := (others => '0');
    signal rd_immd    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal sel_rd_mux : std_logic_vector(1 downto 0) := "00";

    signal Rm         : std_logic_vector(N-1 downto 0);
    signal Rn         : std_logic_vector(N-1 downto 0);

begin

    -- Clock process
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Instancia o datapath
    uut: entity work.datapath
        generic map(N => N)
        port map(
            clk         => clk,
            rst         => rst,
            rn_sel      => rn_sel,
            rm_sel      => rm_sel,
            rd_sel      => rd_sel,
            rd_wr       => rd_wr,
            op_ula      => op_ula,
            rd_ram      => rd_ram,
            rd_immd     => rd_immd,
            sel_rd_mux  => sel_rd_mux,
            Rm          => Rm,
            Rn          => Rn
        );

    -- Estímulo da instrução POP
    stim_process : process
    begin
        wait for 20 ns;
        rst <= '0';
        wait for CLK_PERIOD;

        ---------------------------------------------
        -- Etapa 1: Rx ← MEM[SP]
        ---------------------------------------------
        rm_sel      <= "111";             
        rd_sel      <= "001";            
        rd_wr       <= '1';               
        sel_rd_mux  <= "01";              
        wait for CLK_PERIOD;

        ---------------------------------------------
        -- Etapa 2: SP ← SP + 1
        ---------------------------------------------
        rd_sel      <= "111";             
        rm_sel      <= "111";             -- SP como operando A
        rd_immd     <= x"0001";           -- Imediato 1
        op_ula      <= "0100";            -- Operação ADD
        sel_rd_mux  <= "11";              -- Saída da ULA
        rd_wr       <= '1';
        wait for CLK_PERIOD;

        -- Final
        rd_wr <= '0';
        wait;

    end process;

end sim;