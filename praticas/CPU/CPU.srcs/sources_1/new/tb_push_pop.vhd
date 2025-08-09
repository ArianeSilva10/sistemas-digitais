library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_datapath is
end tb_datapath;

architecture Behavioral of tb_datapath is
    constant N : integer := 16;
    
    -- Component Declaration for the Unit Under Test (UUT)
    component datapath
        generic (N : integer := 16);
        port (
            rn_sel : in std_logic_vector(2 downto 0);
            rm_sel : in std_logic_vector(2 downto 0);
            rd_sel : in std_logic_vector(2 downto 0);
            rd_wr  : in std_logic;
            op_ula : in std_logic_vector(3 downto 0);
            rd_ram : in std_logic_vector(N-1 downto 0);
            rd_immd : in std_logic_vector(N-1 downto 0);
            sel_rd_mux : in std_logic_vector(1 downto 0);
            Rm : out std_logic_vector(N-1 downto 0);
            Rn : out std_logic_vector(N-1 downto 0);
            clk : in std_logic;
            rst : in std_logic;
            sp_inc : in std_logic;
            sp_dec : in std_logic;
            sp_out : out std_logic_vector(7 downto 0);
            ram_addr_sel : in std_logic;
            addr_ram_out : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Inputs
    signal rn_sel : std_logic_vector(2 downto 0) := (others => '0');
    signal rm_sel : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_sel : std_logic_vector(2 downto 0) := (others => '0');
    signal rd_wr : std_logic := '0';
    signal op_ula : std_logic_vector(3 downto 0) := (others => '0');
    signal rd_ram : std_logic_vector(N-1 downto 0) := (others => '0');
    signal rd_immd : std_logic_vector(N-1 downto 0) := (others => '0');
    signal sel_rd_mux : std_logic_vector(1 downto 0) := (others => '0');
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal sp_inc : std_logic := '0';
    signal sp_dec : std_logic := '0';
    signal ram_addr_sel : std_logic := '0';

    -- Outputs
    signal Rm : std_logic_vector(N-1 downto 0);
    signal Rn : std_logic_vector(N-1 downto 0);
    signal sp_out : std_logic_vector(7 downto 0);
    signal addr_ram_out : std_logic_vector(7 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: datapath
        generic map (N => N)
        port map (
            rn_sel => rn_sel,
            rm_sel => rm_sel,
            rd_sel => rd_sel,
            rd_wr => rd_wr,
            op_ula => op_ula,
            rd_ram => rd_ram,
            rd_immd => rd_immd,
            sel_rd_mux => sel_rd_mux,
            Rm => Rm,
            Rn => Rn,
            clk => clk,
            rst => rst,
            sp_inc => sp_inc,
            sp_dec => sp_dec,
            sp_out => sp_out,
            ram_addr_sel => ram_addr_sel,
            addr_ram_out => addr_ram_out
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        rst <= '1';
        wait for clk_period*2;
        rst <= '0';
        wait for clk_period;
        
        -- Test 1: Verify SP initialization (should be 0xFFFE)
        wait for clk_period;
        assert sp_out = x"FE" report "Error in SP initialization" severity error;
        
        -- Test 2: PUSH operation (decrement SP before write)
        -- Configure a value in register R1 (selected by rm_sel)
        rm_sel <= "001"; -- R1
        rd_sel <= "001"; -- R1
        rd_wr <= '1';
        rd_immd <= x"ABCD"; -- Value to write to R1
        sel_rd_mux <= "10"; -- Select rd_immd
        wait for clk_period;
        
        -- Prepare for PUSH (write R1 to memory)
        rd_wr <= '0';
        sp_dec <= '1'; -- Decrement SP (prepare address for PUSH)
        ram_addr_sel <= '1'; -- Select SP as RAM address
        wait for clk_period;
        
        -- Simulate RAM write (R1 value appears on Rm)
        -- At this point, SP has been decremented and address is 0xFFFD
        sp_dec <= '0';
        assert sp_out = x"FD" report "Error in SP decrement" severity error;
        assert addr_ram_out = x"FD" report "Error in RAM address" severity error;
        
        -- Test 3: POP operation (increment SP after read)
        -- Simulate RAM read (fake value)
        rd_ram <= x"1234"; -- Value that would be read from RAM
        sel_rd_mux <= "01"; -- Select rd_ram
        rd_sel <= "010"; -- R2 (POP destination)
        rd_wr <= '1'; -- Enable register write
        sp_inc <= '1'; -- Increment SP after read
        wait for clk_period;
        
        -- Verify value was written to register and SP incremented
        sp_inc <= '0';
        rd_wr <= '0';
        assert sp_out = x"FE" report "Error in SP increment" severity error;
        
        -- Verify value was written to R2
        rm_sel <= "010"; -- Select R2 for reading
        wait for clk_period;
        assert Rm = x"1234" report "Error in POP value to register" severity error;
        
        -- End simulation
        wait for clk_period*2;
        report "Simulation completed" severity note;
        wait;
    end process;

end Behavioral;