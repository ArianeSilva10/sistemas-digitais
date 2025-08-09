library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity tb_ror is
--  Port ( );
end tb_ror;

architecture Behavioral of tb_ror is


 constant N: integer := 16;
 constant CLK_PERIOD: time := 60ns; -- 100MHz
 
 signal s_clk    : STD_LOGIC := '0';
 signal s_rst  : STD_LOGIC := '1';


 -- sinais entre FSM e Datapath  
    signal s_rn_sel : std_logic_vector(2 downto 0);
    signal s_rm_sel : std_logic_vector(2 downto 0);
    signal s_rd_sel : std_logic_vector(2 downto 0);
    signal s_rd_wr : std_logic;
    signal s_rm    : std_logic_vector (N-1 downto 0);
    signal s_rn    : std_logic_vector (N-1 downto 0);
    signal s_ula_op : std_logic_vector(3 downto 0);
    signal s_rf_sel : std_logic_vector(2 downto 0);
    signal s_immed : std_logic_vector(N-1 downto 0);
    signal s_ram_sel : std_logic;
    signal s_ram_we : std_logic;
    signal s_pc_en : std_logic;
    signal s_pc_src : std_logic_vector(1 downto 0);
    signal s_io_write : std_logic;
    signal s_data_out : std_logic_vector(N-1 downto 0);
    signal s_rom_en : std_logic;
    signal s_pc_clr : std_logic;
    signal s_pc_inc : std_logic;
    signal s_ir_ld : std_logic;
    signal s_ir_data : std_logic_vector(N-1 downto 0);
    signal s_flag_z : std_logic;
    signal s_flag_c : std_logic;
    signal s_pc_out : std_logic_vector(N-1 downto 0);
    signal s_sp_out : std_logic_vector(N-1 downto 0);
    signal s_rd_ram : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s_rd_immd : std_logic_vector(N-1 downto 0);
    signal s_sel_rd_mux : std_logic_vector(2 downto 0);
    signal s_io_read : std_logic_vector(N-1 downto 0) := (others => '0');
     

begin
    DUT_DATAPATH:
    entity work.datapath
     Generic map(N => N)
     Port map
     (
         rn_sel => s_rn_sel, 
         rm_sel => s_rm_sel,
         rd_sel => s_rd_sel,
         rd_wr  => s_rd_wr,
         op_ula => s_ula_op,
         rd_ram => s_rd_ram,
         rd_immd => s_rd_immd,
         sel_rd_mux => s_sel_rd_mux,
         Rm => s_rm,
         Rn => s_rn,
         clk => s_clk,
         rst => s_rst,
         sp_out => s_sp_out,
         flag_z => s_flag_z,
         flag_c => s_flag_c,
         pc_en => s_pc_en,
         pc_src => s_pc_src,
         immed => s_immed,
         pc_out => s_pc_out,
         io_write => s_io_write,
         data_out => s_data_out,
         io_read => s_io_read
     );
     
    DUT_FSM:
    entity work.fsm
    generic map(N => N)
    Port map(
        clk => s_clk,
        rst => s_rst,
        rom_en => s_rom_en,
        pc_clr => s_pc_clr,
        pc_inc => s_pc_inc,
        ir_ld => s_ir_ld,
        ir_data => s_ir_data,
        immed => s_immed,
        ram_sel => s_ram_sel,
        ram_we => s_ram_we,
        rf_sel => s_rf_sel,
        rm_sel => s_rm_sel,
        rn_sel => s_rn_sel,
        rd_sel => s_rd_sel,
        rd_wr => s_rd_wr,
        ula_op => s_ula_op,
        flag_z => s_flag_z,
        flag_c => s_flag_c,
        pc_en => s_pc_en,
        pc_src => s_pc_src,
        io_write => s_io_write
    );
     
        
    clock:
    s_clk <= not s_clk after CLK_PERIOD/2;
    
    demais_sinais:
    process
    begin
    
    s_rst <= '1';
    wait for CLK_PERIOD * 5;
    s_rst <= '0';
    
    wait for CLK_PERIOD*2;
        -- instrução MOV R1, #0x02 (exemplo)
    --s_rd_immd <= x"000A";
    s_ir_data <= "0001000100001010";  -- opcode=0001 (MOV), R1="001", #0x02="00000010", bits 10-8 = 
    wait for CLK_PERIOD * 2;
        
        -- instrucao ROR Rd, Rm    (ROR R2, R1)
    --s_ir_data <= "1101001000100000";  -- opcode=1101, R2="010", #2 = 00000010
    --s_data_out <= s_rm;
    --wait for CLK_PERIOD * 10;

    -- saida pra ver no waveform
    s_ir_data <= "1111000100000010";       -- opcode[15:12]: 1111, bit [10:8]: Rm: R2(010); bit[1:0]: 10
    wait for CLK_PERIOD*7;  
    
    wait;
    end process;
    
    -- Processo de monitoramento (funciona no Vivado)
    monitor: process(s_clk)
    begin
        if rising_edge(s_clk) then
            if s_rm_sel = "010" then 
                report "Valor de R2: " & integer 'image(TO_INTEGER (unsigned (s_rm)));
            end if;
            if s_io_write = '1' then
                report "[DEBUG] IO_WRITE ATIVO - Valor em data_out: " & 
                       integer'image(to_integer(unsigned(s_data_out)));
            end if;
        end if;
    end process;     
        
    
    controle:
    process
    begin
        wait for 500000000 ns;
        assert false report "Fim da simulação." severity failure;
    end process;


end Behavioral;