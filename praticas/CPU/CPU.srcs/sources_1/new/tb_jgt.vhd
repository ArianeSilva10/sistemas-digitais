library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_jgt is
end tb_jgt;

architecture behavior of tb_jgt is

    -- Parâmetros
    constant N : integer := 16;

    -- Sinais para conectar à FSM
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '1';
    signal rom_en : std_logic;
    signal pc_clr : std_logic;
    signal pc_inc : std_logic;
    signal ir_ld  : std_logic;
    signal ir_data : std_logic_vector(N-1 downto 0);
    signal immed  : std_logic_vector(N-1 downto 0);
    signal ram_sel : std_logic;
    signal ram_we : std_logic;
    signal rf_sel : std_logic_vector(1 downto 0);
    signal rm_sel : std_logic_vector(2 downto 0);
    signal rn_sel : std_logic_vector(2 downto 0);
    signal rd_sel : std_logic_vector(2 downto 0);
    signal rd_wr  : std_logic;
    signal ula_op : std_logic_vector(3 downto 0);
    signal flag_z : std_logic := '0';
    signal flag_c : std_logic := '0';
    signal pc_en  : std_logic;
    signal pc_src : std_logic_vector(1 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instancia a FSM
    uut: entity work.fsm
    generic map (
        N => 16
    )
    port map (
        clk     => clk,
        rst     => rst,
        rom_en  => rom_en,
        pc_clr  => pc_clr,
        pc_inc  => pc_inc,
        ir_ld   => ir_ld,
        ir_data => ir_data,
        immed   => immed,
        ram_sel => ram_sel,
        ram_we  => ram_we,
        rf_sel  => rf_sel,
        rm_sel  => rm_sel,
        rn_sel  => rn_sel,
        rd_sel  => rd_sel,
        rd_wr   => rd_wr,
        ula_op  => ula_op,
        flag_z  => flag_z,
        flag_c  => flag_c,
        pc_en   => pc_en,
        pc_src  => pc_src
    );

    -- Processo para gerar clock
    clk_process :process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    stim_proc: process
    begin
        -- Reset inicial
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Teste 1: Deve realizar o salto (Z=0, C=0)
        -- Instrução JGT (opcode = "1100") com imediato = 1
        -- Construindo a instrução: 
        -- opcode[15:12] = 1100 0001
        -- imediato = 1 (bits 7 downto 0)
        ir_data <= "11000001" & "00000001";
        flag_z <= '0';
        flag_c <= '0';
        wait for 40 ns;

        -- Teste 2: Não deve realizar salto (Z=1, C=0)
        flag_z <= '1';
        flag_c <= '0';
        wait for 40 ns;

        -- Teste 3: Não deve realizar salto (Z=0, C=1)
        flag_z <= '0';
        flag_c <= '1';
        wait for 40 ns;

        wait;
    end process;

end behavior;
