library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_in is
end tb_in;

architecture sim of tb_in is
    constant N : integer := 16;

    -- Clock/reset
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';

    -- conexoes FSM <-> datapath
    signal rn_sel : std_logic_vector(2 downto 0);
    signal rm_sel : std_logic_vector(2 downto 0);
    signal rd_sel : std_logic_vector(2 downto 0);
    signal rd_wr : std_logic;
    signal ula_op : std_logic_vector(3 downto 0);
    signal rf_sel : std_logic_vector(2 downto 0);
    signal immed : std_logic_vector(N-1 downto 0);
    signal ram_sel, ram_we : std_logic;
    signal pc_en : std_logic;
    signal pc_src : std_logic_vector(1 downto 0);
    signal io_write : std_logic;
    signal data_out : std_logic_vector(N-1 downto 0);
    signal rom_en, pc_clr, pc_inc, ir_ld : std_logic;
    signal ir_data : std_logic_vector(N-1 downto 0);
    signal flag_z, flag_c : std_logic;
    signal pc_out, sp_out : std_logic_vector(N-1 downto 0);
    signal rd_ram : std_logic_vector(N-1 downto 0) := (others => '0');
    signal rd_immd : std_logic_vector(N-1 downto 0);

    -- entrada simulada do dispositivo externo
    signal io_read : std_logic_vector(N-1 downto 0);

    component fsm
        generic (N : integer := 16);
        port (
            clk, rst : in std_logic;
            rom_en, pc_clr, pc_inc, ir_ld : out std_logic;
            ir_data : in std_logic_vector(N-1 downto 0);
            immed : out std_logic_vector(N-1 downto 0);
            ram_sel, ram_we : out std_logic;
            rf_sel : out std_logic_vector(2 downto 0);
            rm_sel, rn_sel, rd_sel : out std_logic_vector(2 downto 0);
            rd_wr : out std_logic;
            ula_op : out std_logic_vector(3 downto 0);
            flag_z, flag_c : in std_logic;
            pc_en : out std_logic;
            pc_src : out std_logic_vector(1 downto 0);
            io_write : out std_logic
        );
    end component;

    component datapath
        generic (N : integer := 16);
        port (
            rn_sel, rm_sel, rd_sel : in std_logic_vector(2 downto 0);
            rd_wr : in std_logic;
            op_ula : in std_logic_vector(3 downto 0);
            rd_ram : in std_logic_vector(N-1 downto 0);
            rd_immd : in std_logic_vector(N-1 downto 0);
            sel_rd_mux : in std_logic_vector(2 downto 0);
            Rm, Rn : out std_logic_vector(N-1 downto 0);
            clk, rst : in std_logic;
            sp_out : out std_logic_vector(N-1 downto 0);
            flag_z, flag_c : out std_logic;
            pc_en : in std_logic;
            pc_src : in std_logic_vector(1 downto 0);
            immed : in std_logic_vector(N-1 downto 0);
            pc_out : out std_logic_vector(N-1 downto 0);
            io_write : in std_logic;
            data_out : out std_logic_vector(N-1 downto 0);
            io_read : in std_logic_vector(N-1 downto 0)
        );
    end component;

begin

    -- Clock
    clk_process : process
    begin
        while now < 500 ns loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
        wait;
    end process;

    -- FSM
    uut_fsm : fsm
        port map (
            clk => clk,
            rst => rst,
            rom_en => rom_en,
            pc_clr => pc_clr,
            pc_inc => pc_inc,
            ir_ld => ir_ld,
            ir_data => ir_data,
            immed => immed,
            ram_sel => ram_sel,
            ram_we => ram_we,
            rf_sel => rf_sel,
            rm_sel => rm_sel,
            rn_sel => rn_sel,
            rd_sel => rd_sel,
            rd_wr => rd_wr,
            ula_op => ula_op,
            flag_z => flag_z,
            flag_c => flag_c,
            pc_en => pc_en,
            pc_src => pc_src,
            io_write => io_write
        );

    -- Datapath
    uut_datapath : datapath
        port map (
            rn_sel => rn_sel,
            rm_sel => rm_sel,
            rd_sel => rd_sel,
            rd_wr => rd_wr,
            op_ula => ula_op,
            rd_ram => rd_ram,
            rd_immd => rd_immd,
            sel_rd_mux => rf_sel,
            Rm => open,
            Rn => open,
            clk => clk,
            rst => rst,
            sp_out => sp_out,
            flag_z => flag_z,
            flag_c => flag_c,
            pc_en => pc_en,
            pc_src => pc_src,
            immed => immed,
            pc_out => pc_out,
            io_write => io_write,
            data_out => data_out,
            io_read => io_read
        );

    -- Estímulos
    stim_proc : process
    begin
        wait for 10 ns;
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- simula um valor externo chegando em io_read
        io_read <= x"00CD";

        -- instrucao IN R4  => opcode = 1111, R4 = "100", final "01"
        ir_data <= "1111110000000001";  -- bits 10-8 = R4

        wait for 80 ns;

        wait;
    end process;

end sim;
