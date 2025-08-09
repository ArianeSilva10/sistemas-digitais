library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity tb_datapath is
--  Port ( );
end tb_datapath;

architecture Behavioral of tb_datapath is


 constant N: integer := 16;
 constant CLK_PERIOD: time := 10ns; -- 100MHz
 
 signal s_clk    : STD_LOGIC := '0';
 signal s_reset  : STD_LOGIC := '1';


 signal s_rn_sel : std_logic_vector (2 downto 0);
 signal s_rm_sel : std_logic_vector (2 downto 0);
 signal s_rd_sel : std_logic_vector (2 downto 0);
 signal s_rd_wr  : std_logic;
 signal s_op_ula:  std_logic_vector (3 downto 0);
 signal s_rd_ram :  std_logic_vector (N-1 downto 0);
 signal s_rd_immd :  std_logic_vector (N-1 downto 0);
 signal s_sel_rd_mux:  std_logic_vector (1 downto 0);
 signal s_we  : std_logic;
 signal s_mux_ram  : std_logic;
     
     

begin
    DUT:
    entity work.datapath
     Generic map(N => N)
     Port map
     (
         rn_sel => s_rn_sel, 
         rm_sel => s_rm_sel,
         rd_sel => s_rd_sel,
         rd_wr  => s_rd_wr,
         op_ula => s_op_ula,
         rd_ram => s_rd_ram,
         rd_immd => s_rd_immd,
         sel_rd_mux => s_sel_rd_mux,
         clk => s_clk,
         rst => s_reset,
         we => s_we,
         mux_ram => s_mux_ram   
     );
     
        
    clock:
    s_clk <= not s_clk after CLK_PERIOD/2;
    
    demais_sinais:
    process
    begin
    
    wait for CLK_PERIOD;
    s_reset <= '0';
    
    wait for CLK_PERIOD;
    -- mov r0, #5
    s_rd_sel <= "000";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000101";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    -- mov r1, #6
    s_rd_sel <= "001";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000110";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    -- add r2, r0, r1
    s_rd_sel <= "010";
    s_rd_wr <= '1';
    s_rm_sel <= "000";
    s_rn_sel <= "001";
    s_sel_rd_mux <= "11";
    s_op_ula <= "0100";
    
    wait for CLK_PERIOD;
    -- mov r0, #0
    s_rd_sel <= "000";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000000";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    
    -- str [r0], r2
    s_rm_sel <= "000";
    s_rn_sel <= "010";
    s_we <= '1';    
    s_mux_ram <= '1';
    
    wait for CLK_PERIOD;
    
    -- mov r0, #4
    s_rd_sel <= "000";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000100";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    
    -- SUB Rd, Rm, Rn                          ( Rd = Rm - Rn)(sub r2, r1,r0)
    s_rd_sel <= "010";
    s_rd_wr <= '1';
    s_rm_sel <= "001";
    s_rn_sel <= "000";
    s_sel_rd_mux <= "11";
    s_op_ula <= "0101";
    
    
    wait for CLK_PERIOD;
    
    -- mov r1, #3
    s_rd_sel <= "001";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000011";
    s_sel_rd_mux <= "10";
    
    
    wait for CLK_PERIOD;
    
    -- MUL Rd, Rm, Rn                         (Rd = Rm * Rn)(mul r2, r1, r0)
    s_rd_sel <= "010";
    s_rd_wr <= '1';
    s_rm_sel <= "001";
    s_rn_sel <= "000";
    s_sel_rd_mux <= "11";
    s_op_ula <= "0110";
    
    
    wait for CLK_PERIOD;
    
    -- AND Rd, Rm, Rn                      (Rd = Rm and Rn)(and r1, r2, r0)
    s_rd_sel <= "001";
    s_rd_wr <= '1';
    s_rm_sel <= "010";
    s_rn_sel <= "000";
    s_sel_rd_mux <= "11";
    s_op_ula <= "0111";
    
    wait for CLK_PERIOD;
    
    -- ORR Rd, Rm, Rn                    (Rd = Rm or Rn)(orr r1, r2, r0)
    s_rd_sel <= "001";
    s_rd_wr <= '1';
    s_rm_sel <= "010";
    s_rn_sel <= "000";
    s_sel_rd_mux <= "11";
    s_op_ula <= "1000";
    
    wait for CLK_PERIOD;
    
    -- NOT Rd, Rm                   (Rd = ¬Rm)(r1,  ~r2)
    s_rd_sel <= "001";
    s_rd_wr <= '1';
    s_rm_sel <= "010";
    s_sel_rd_mux <= "11";
    s_op_ula <= "1001";
    
    wait for CLK_PERIOD;
    
     -- XOR Rd, Rm, Rn                   (Rd = Rm xor Rn)(xor r1, r2, r0)
    s_rd_sel <= "001";
    s_rd_wr <= '1';
    s_rm_sel <= "010";
    s_rn_sel <= "000";
    s_sel_rd_mux <= "11";
    s_op_ula <= "1010";
    
    wait for CLK_PERIOD;
    
    
    -- LDR Rd, [Rm]                        (Rd =[Rm])(ldr r1, [r0])   Copie 3 valores da memória para 3 registradores diferentes
    s_rd_sel <= "000";
    s_rd_wr <= '1';
    s_rm_sel <= "001";
    s_sel_rd_mux <= "01"; -- vem da ram
    s_we <= '0';
    s_mux_ram <= '0';
    
    
    wait for CLK_PERIOD;
    
    -- mov r0, #2
    s_rd_sel <= "000";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000010";
    s_sel_rd_mux <= "10";
    
    
    wait for CLK_PERIOD;
    
     -- LDR Rd, [Rm]                        (Rd =[Rm])(ldr r2, [r0])   Copie 3 valores da memória para 3 registradores diferentes
    s_rd_sel <= "010";
    s_rd_wr <= '1';
    s_rm_sel <= "000";
    s_sel_rd_mux <= "01"; -- vem da ram
    s_we <= '0';
    s_mux_ram <= '0';
    
    
    wait for CLK_PERIOD;
    
     -- mov r0, #3
    s_rd_sel <= "000";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000011";
    s_sel_rd_mux <= "10";
    
    
    wait for CLK_PERIOD;
    
     -- LDR Rd, [Rm]                        (Rd =[Rm])(ldr r3, [r0])   Copie 3 valores da memória para 3 registradores diferentes
    s_rd_sel <= "011";
    s_rd_wr <= '1';
    s_rm_sel <= "000";
    s_sel_rd_mux <= "01"; -- vem da ram
    s_we <= '0';
    s_mux_ram <= '0';
    
    
    wait for CLK_PERIOD;
    
    
    -- d) Copie 3 valores da memória para outra posição de memória. 
    
    -- mov r0, #0
    s_rd_sel <= "000";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000000";
    s_sel_rd_mux <= "10";
    
    
    wait for CLK_PERIOD;

    -- mov r1, #1
    s_rd_sel <= "001";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000001";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    
    -- mov r2, #2
    s_rd_sel <= "010";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000010";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    
    -- mov r3, #3
    s_rd_sel <= "011";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000011";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    
    -- mov r4, #4
    s_rd_sel <= "100";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000100";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    
    -- mov r5, #5
    s_rd_sel <= "101";
    s_rd_wr <= '1';
    s_rd_immd <= "0000000000000101";
    s_sel_rd_mux <= "10";
    
    wait for CLK_PERIOD;
    
    -- LDR Rd, [Rm]                        (Rd =[Rm])(ldr r2, [r0])   
    s_rd_sel <= "010";
    s_rd_wr <= '1';
    s_rm_sel <= "000";
    s_sel_rd_mux <= "01"; -- vem da ram
    s_we <= '0';
    s_mux_ram <= '0';
    
    
    wait for CLK_PERIOD;
    
    -- str [r1], r2
    s_rm_sel <= "001";
    s_rn_sel <= "010";
    s_we <= '1';    
    s_mux_ram <= '1';
    
    wait for CLK_PERIOD;
    
    -- LDR Rd, [Rm]                        (Rd =[Rm])(ldr r3, [r1])   
    s_rd_sel <= "011";
    s_rd_wr <= '1';
    s_rm_sel <= "001";
    s_sel_rd_mux <= "01"; -- vem da ram
    s_we <= '0';
    s_mux_ram <= '0';
    
    
    wait for CLK_PERIOD;
    
    -- str [r4], r3
    s_rm_sel <= "100";
    s_rn_sel <= "011";
    s_we <= '1';    
    s_mux_ram <= '1';
    
    wait for CLK_PERIOD;
    
    -- LDR Rd, [Rm]                        (Rd =[Rm])(ldr r5, [r4])   
    s_rd_sel <= "101";
    s_rd_wr <= '1';
    s_rm_sel <= "100";
    s_sel_rd_mux <= "01"; -- vem da ram
    s_we <= '0';
    s_mux_ram <= '0';
    
    
    wait for CLK_PERIOD;
    
    -- str [r5], r0
    s_rm_sel <= "101";
    s_rn_sel <= "000";
    s_we <= '1';    
    s_mux_ram <= '1';
    
    wait for CLK_PERIOD;

    wait;
    end process;
    
        
    
    controle:
    process
    begin
        wait for 500 ns;
        assert false report "Fim da simulação." severity failure;
    end process;


end Behavioral;