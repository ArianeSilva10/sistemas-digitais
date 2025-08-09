library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity tb_full is
--  Port ( );
end tb_full;

architecture Behavioral of tb_full is


 constant N: integer := 16;
 constant CLK_PERIOD: time := 20ns; -- 100MHz
 
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
        io_write => s_io_write,
        sel_rd_mux => s_sel_rd_mux
    );
     
        
    clock:
    s_clk <= not s_clk after CLK_PERIOD/2;
    
    demais_sinais:
    process
    begin
    
    s_rst <= '1';
    wait for CLK_PERIOD * 2;
    s_rst <= '0';
        
        
         -- Teste 1: MOV R7, #0x0050 (atualiza SP)
         -- [15:12] = 0001
         -- [11] = 0 
         -- [10:8] = 111
         -- [7;0] = 0101 0000 (imediato)
        s_ir_data <= "0001011101010000";  -- MOV R7, #0x0050, 0x1750
        wait for CLK_PERIOD*5;
        
        -- Teste 1.1: PUSH R1 (usando SP)
        -- [15: 12] = 0000
        -- [11] = 0
        -- [4:2] = 001  --> R1
        -- [1:0] = 01
        s_ir_data <= "0000000000000101";  -- PUSH R1, 0x5
        wait for CLK_PERIOD*5;

        -- Teste 2 : topo da pilha
        s_rd_ram <= x"1234";
        
        -- Teste 2.3 : POP R2
        -- [15: 12] = 0000
        -- [11] = 0
        -- [10:8] = 010  --> R2
        -- [1:0] = 10 
        s_ir_data <= "0000001000000010";       -- 0x202
        wait for CLK_PERIOD * 5;
        
        -- Teste 3: MOV R1, #0x0005
        -- [15:12] = 0001
        -- [11] = 0 
        -- [10:8] = 001         -> R1
        -- [7;0] = 0000 0101 (imediato)
        s_ir_data <= "0001000100000101"; -- 0001000100000101, 0x1105
        wait for CLK_PERIOD * 5;
        
        -- Teste 3.1: MOV R2, #0x0005
        -- [15:12] = 0001
        -- [11] = 0 
        -- [10:8] = 010         -> R2
        -- [7;0] = 0000 0101 (imediato)
        s_ir_data <= "0001001000000101";       -- 0x1205
        wait for CLK_PERIOD * 5;
        
        -- Teste 3.2: CMP R1, R2
        -- [15:12] = 0000
        -- [11] = 0 
        -- [7:5] = 001         -> R1 
        -- [4;2] = 010         -> R2
        -- [1:0] = 11
        s_ir_data <= "0000000000101011";      -- 0x002b
        wait for CLK_PERIOD * 5;
                
        -- Teste 3.3 : MOV R3, #0x0004
        -- [15:12] = 0001
        -- [11] = 0 
        -- [10:8] = 011         -> R3
        -- [7;0] = 0000 0100    (imediato)
        s_ir_data <= "0001001100000100";            -- 0x1304
        wait for CLK_PERIOD;
        
        -- Teste 3.4: CMP R1, R3
        -- [15:12] = 0000
        -- [11] = 0 
        -- [7:5] = 001         -> R1 
        -- [4;2] = 011         -> R3
        -- [1:0] = 11
        s_ir_data <= "0000000000101111";         -- 0x002f
        wait for CLK_PERIOD;  
        
        -- Teste 4: JMP #0x000A
        -- [15:12] = 0000
        -- [11] = 1 
        -- [9;2] = 0000 1010         (imediato)
        -- [1:0] = 00
        s_ir_data <= "0000100000101000";          -- 0x0828
        wait for CLK_PERIOD; 
        
        -- Teste 5: JEQ #0x000C
        -- [15:12] = 0000
        -- [11] = 1 
        -- [9;2] = 0000 1100         (imediato)
        -- [1:0] = 01
        s_ir_data <= "0000100000110001"; -- [1:0] = 01, 0x0831
        wait for CLK_PERIOD;
        
        -- Teste 6: JLT #0x0008
        s_ir_data <= "0000100000100010";            --    0x0822 [1:0] = 10
        wait for CLK_PERIOD;
        
        -- Teste 7: JGT #0x007
        -- [15:12] = 0000
        -- [11] = 1 
        -- [9;2] = 0000 0111         (imediato)
        -- [1:0] = 11
        s_ir_data <= "0000100000011111";         -- 0x081f          -- [1:0] = 11
        wait for CLK_PERIOD;
        
        -- Teste 8: IN R4
        -- [15:12] = 1111
        -- [10:8] = 0100            -- R4
        -- [1:0] = 01
        s_io_read <= x"00CD";
        s_ir_data <= "1111010000000001";         -- 0xf401       -- [1:0] = 01
        wait for CLK_PERIOD;        
        
        -- Teste 9: MOV R5, #0x0007   
        -- [15:12] = 0001
        -- [11] = 0 
        -- [10:8] = 101         -> R3
        -- [7;0] = 0000 0111    (imediato)
        s_ir_data <= "0001010100000111";            -- 0x1507
        wait for CLK_PERIOD;
        
        -- Teste 9.1: OUT R5
        -- [15:12] = 1111
        -- [10:8]  = 101         -> R5
        -- [1:0] = 10
        s_ir_data <= "1111010100000010";       -- 0xf502           -- [1:0] = 10
        wait for CLK_PERIOD;
        
        -- Teste 10: OUT #0x55
        -- [15:12] = 1111
        -- [11] = 1
        -- [7:5]   = 000
        -- [7:0]   = 0000 0101
        s_rd_immd <= x"0055";
        s_ir_data <= "1111100000000101";  -- 0xf805  1111 1 000 00000101
        wait for CLK_PERIOD;
        
        -- Teste 11:MOV R4, #0x0008    
        -- [15:12] = 0001
        -- [11] = 0 
        -- [10:8] = 100         -> R4
        -- [7;0] = 0000 1000    (imediato)
        s_ir_data <= "0001010000001000";         -- 0x1408
        wait for CLK_PERIOD;
        
        -- Teste 11.1 : SHR R2, R4, #0x2
        -- [15:12] = 1011
        -- [10:8]  = 010     -> R2
        -- [7:5] = 100       -> R4
        -- [7:0]  = 0000 0010    (imediato)
        s_rd_immd <= x"0002";
        s_ir_data <= "1011001010000010";           -- 0xb282
        wait for CLK_PERIOD;
                
       -- Teste 12 : MOV R2, #10
       -- [15:12] = 0001
       -- [11] = 0 
       -- [10:8] = 010         -> R2
       -- [7;0] = 0000 1010    (imediato)
        s_ir_data <= "0001001000001010";         -- 0x120A
        wait for CLK_PERIOD;
        
        -- Teste 12.1: SHL R1, R2, #2
        -- [15:12] = 1100
        -- [10:8]  = 001     -> R1
        -- [7:5] = 010       -> R2
        -- [7:0]  = 0000 0010    (imediato)
        s_ir_data <= "1100000101000010";          -- 0xc142
        wait for CLK_PERIOD;
        
        -- Teste 13: MOV R1, #10
        -- [15:12] = 0001
        -- [11] = 0 
        -- [10:8] = 001         -> R1
        -- [7;0] = 0000 1010    (imediato)
        s_ir_data <= "0001000100001010";      ---  0x110a
        wait for CLK_PERIOD; 
        
        --  Teste 13.1: ROR R2, R1
        -- [15:12] = 1101
        -- [10:8]  = 001     -> R1
        -- [7:5] = 010       -> R2
        s_ir_data <= "1101001000100000";            -- 0xd220
        wait for CLK_PERIOD; 
        
        -- Teste 14: MOV R3, #10
        -- [15:12] = 0001
        -- [11] = 0 
        -- [10:8] = 011         -> R3
        -- [7;0] = 0000 1010    (imediato)
        s_ir_data <= "0001001100001010";          -- 0x110a
        wait for CLK_PERIOD; 
        
        -- Testes 14.1: ROL R4, R3
        -- [15:12] = 1110
        -- [11:9] = 100       -> R4
        -- [8:6]  = 011       -> R3
        s_ir_data <= "1110100011000000";          -- 0xe8c0
        wait for CLK_PERIOD;
        
        
       assert false report "Todos os testes concluidos com sucesso!" severity note;
    wait;
    end process;
        
        
    
    controle:
    process
    begin
        wait;
        assert false report "Fim da simulação." severity failure;
    end process;


end Behavioral;