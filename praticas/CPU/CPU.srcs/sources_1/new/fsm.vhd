library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fsm is
  generic (N : integer := 16);
  Port (clk : in std_logic;
        rst: in std_logic;
        rom_en: out std_logic;
        pc_clr: out std_logic;
        pc_inc: out std_logic;
        ir_ld : out std_logic;
        ir_data : in std_logic_vector(N-1 downto 0);
        immed: out std_logic_vector(N-1 downto 0);
        ram_sel :out std_logic;
        ram_we:out std_logic;
        rf_sel: out std_logic_vector(2 downto 0);
        rm_sel: out std_logic_vector(2 downto 0);
        rn_sel : out std_logic_vector(2 downto 0);
        rd_sel: out std_logic_vector(2 downto 0);
        rd_wr : out std_logic;
        ula_op: out std_logic_vector(3 downto 0);
        flag_z : in std_logic;
        flag_c : in std_logic;
        pc_en : out std_logic;
        pc_src : out std_logic_vector(1 downto 0);  -- controla de onde vem o valor novo do pc
        io_write: out std_logic;
        sel_rd_mux : out std_logic_vector(2 downto 0)
   );
end fsm;

architecture Behavioral of fsm is

-- Estados da FSM
type state_type is (init,
                    fetch,
                    decode, 
                    exec_nop, 
                    exec_halt, 
                    exec_mov, 
                    exec_load, 
                    exec_store, 
                    exec_ula,
                    exec_push_write,
                    exec_push_dec,
                    exec_pop_read,
                    exec_pop_inc_sp,
                    exec_cmp,
                    exec_jmp,
                    exec_jeq,
                    exec_jlt,
                    exec_jgt,
                    exec_in,
                    exec_out_rm,
                    exec_out_im,
                    exec_shr,
                    exec_shl,
                    exec_ror,
                    exec_rol
                    );

-- Sinais para represntar os estados
signal current_state, next_state: state_type;

-- Instrução lida
signal instruction: std_logic_vector(N-1 downto 0);
signal opcode:  std_logic_vector(3 downto 0);

begin

STATE_UPDATE:
    process (clk, rst)
    begin
        if (rst='1') then
         current_state <= init;
        elsif (rising_edge(clk)) then
         current_state <= next_state;
        end if;
    end process;
    
SIGNALS_UPDATE:
    process (rst, current_state, instruction)
    begin
        if (rst='0') then
        case current_state is
        
            when init => 
              -- atualizar as saídas
                  pc_clr <= '1';
                  pc_inc <= '0';
                  rom_en <= '0';
                  ir_ld <= '0';
                  immed <= X"0000";
                  ram_sel <= '0';
                  ram_we  <= '0';
                  rf_sel <= "000";
                  rd_sel <= "000";
                  rd_wr  <= '0';
                  rm_sel <= "000";
                  rn_sel <= "000";
                  ula_op <= "0000";
                  pc_en <= '0';
                  io_write <= '0';
                  sel_rd_mux <= "000";
              -- transicao de estado
              next_state <= fetch;
              
            when fetch => 
            -- atualizar as saídas
              pc_clr <= '0';
              pc_inc <= '1';
              pc_en <= '1';
              rom_en <= '1';
              ir_ld <= '1';
              immed <= X"0000";
              ram_sel <= '0';
              ram_we  <= '0';
              rf_sel <= "000";
              rd_sel <= "000";
              rd_wr  <= '0';
              rm_sel <= "000";
              rn_sel <= "000";
              ula_op <= "0000";
              io_write <= '0';
              sel_rd_mux <= "000";
            -- transicao de estado
            next_state <= decode;
              
              
            when decode =>  
            -- atualizar as saídas
              pc_clr <= '0';
              pc_inc <= '0';
              rom_en <= '0';
              ir_ld <= '0';
              immed <= X"0000";
              ram_sel <= '0';
              ram_we  <= '0';
              rf_sel <= "000";
              rd_sel <= "000";
              rd_wr  <= '0';
              rm_sel <= "000";
              rn_sel <= "000";
              ula_op <= "0000";
              io_write <= '0';
              sel_rd_mux <= "000";
              
            -- transicao de estado
            if (opcode = "0000") then -- 0
                if instruction(11) = '0' then
                    case instruction(1 downto 0) is
                        when "01" => next_state <= exec_push_write;
                        when "10" => next_state <= exec_pop_read;
                        when "11" => next_state <= exec_cmp;
                        when others => next_state <= exec_nop;
                    end case;
                    
                 elsif instruction(11) = '1' then
                    case instruction(1 downto 0) is
                        when "00" => next_state <= exec_jmp;
                        when "01" => next_state <= exec_jeq;
                        when "10" => next_state <= exec_jlt;
                        when "11" => next_state <= exec_jgt;
                        when others => next_state <= exec_halt;
                    end case;
                end if;
            elsif (opcode = "1111") then -- 15
                    -- Verifica primeiro os bits específicos para OUT
                if instruction(1 downto 0) = "10" then  -- Formato OUT Rm
                    next_state <= exec_out_rm;
                elsif instruction(1 downto 0) = "01" then  -- Formato IN Rd
                    next_state <= exec_in;
                -- Verifica OUT imediato somente se os bits específicos estão corretos
                elsif instruction(11) = '1' and instruction(7 downto 5) = "000" then
                    next_state <= exec_out_im;
                else
                    next_state <= exec_nop;
                end if;
            elsif (opcode = "0001") then  -- 1
                next_state <= exec_mov;
            elsif (opcode = "0010") then  --2
                next_state <=exec_store;
            elsif (opcode = "0011") then --3
                next_state <= exec_load;
            elsif (opcode = "0100") then   --4
                next_state <= exec_ula;
            elsif (opcode = "0101") then  -- 5
                 next_state <= exec_ula;
            elsif (opcode = "0110") then   -- 6
                next_state <= exec_ula;
            elsif (opcode = "0111") then      -- 7
                next_state <= exec_ula;
            elsif (opcode = "1000") then       -- 8
                next_state <= exec_ula;
            elsif (opcode = "1001") then      -- 9
                next_state <= exec_ula;
            elsif (opcode = "1010") then      --10
                next_state <= exec_ula;
            elsif (opcode = "1011") then        -- 11
                next_state <= exec_shr;
            elsif (opcode = "1100") then      -- 12
                next_state <= exec_shl;
            elsif (opcode <= "1101") then      --13
                next_state <= exec_ror;
            elsif (opcode = "1110") then    -- 14
                next_state <= exec_rol;
            else 
                next_state <= exec_nop;
            end if;
            
            when  exec_nop => 
            -- atualizar as saídas
              
            -- transicao de estado
                next_state <= fetch;
            when  exec_halt => 
            -- atualizar as saídas
              
            -- transicao de estado
            next_state <= exec_halt;
            
            when  exec_mov => 
            -- atualizar as saídas
                immed <= X"00" & instruction(7 downto 0);
                rd_sel <= instruction(10 downto 8);
                rm_sel <= instruction(7 downto 5);
                rf_sel <= instruction(11) & "00";
                rd_wr  <= '1';
                io_write <= '0';
                sel_rd_mux <= "010";
            -- transicao de estado
                next_state <= fetch;
                
            when  exec_store => 
            -- atualizar as saídas
               immed <= X"00" & instruction(10 downto 8) & instruction(4 downto 0);
               rm_sel <= instruction(7 downto 5);
               rn_sel <= instruction(4 downto 2);
               ram_sel <= instruction(11);
               ram_we  <= '1';
                io_write <= '0';
                sel_rd_mux <= "000";
              
            -- transicao de estado
            next_state <= fetch;
            
            when exec_load => 
            -- atualizar as saídas
              rf_sel <= "001";
              rd_sel <= instruction(10 downto 8);
              rd_wr  <= '1';
              rm_sel <= instruction(7 downto 5);
              io_write <= '0';
              sel_rd_mux <= "001";
            -- transicao de estado
            next_state <= fetch;

            
            when  exec_ula=> 
            -- atualizar as saídas

              
              rm_sel <= instruction(7 downto 5);
              rn_sel <= instruction(4 downto 2);
              rd_sel <= instruction(10 downto 8);
              rd_wr  <= '1';
              rf_sel <= "011";       
              ula_op <= instruction(15 downto 12);
              io_write <= '0';
              sel_rd_mux <= "000";
            -- transicao de estado
            next_state <= fetch;
            
            
            when exec_push_write =>
    -- Escreve Rn na pilha
            rm_sel <= "111";
            rn_sel <= instruction(4 downto 2); -- dado
            ram_sel <= '0';
            ram_we <= '1';
            next_state <= exec_push_dec;  
    -- Decrementa SP usando imediato
            when exec_push_dec =>
            
            ula_op <= "0101";
            rm_sel <= "111";
            immed <= X"0001";
            rf_sel <= "011";
            rd_sel <= "111";
            rd_wr <= '1';
            ram_sel <= '1';
            next_state <= fetch;
            
            
            
            when exec_pop_read =>
            
            ula_op <= "0100";
            rm_sel <= "111";
            immed <= X"0001";
            rf_sel <= "011";
            rd_sel <= "111";
            rd_wr <= '1';
            ram_sel <= '1';
            next_state <= exec_pop_inc_sp;
                
    -- Próximo estado: incrementa SP
            next_state <= exec_pop_inc_sp;

            when exec_pop_inc_sp =>
    -- Atualiza SP ← SP + 1
            rm_sel <= "111";
            rd_sel <= instruction(10 downto 8);
            rf_sel <= "001";
            rd_wr <= '1';
            next_state <= fetch;

            -- Instruçao cmp Z = (Rm = Rn)? 1 : 0 ; C = (Rm < Rn)? 1 : 0 
            when exec_cmp =>
                
                rm_sel <= instruction(7 downto 5);    -- Rm
                rn_sel <= instruction(4 downto 2);    -- Rn
                rd_wr <= '0';
                rf_sel <= "011";                        -- resultado da ula(flags)
                ula_op <= "1011";                      -- opcode do cmp na ula
                immed <= (others => '0');              -- nao usa imediato
                ram_sel <= '0';
                ram_we <= '0';
                rd_sel <= "000";
                io_write <= '0';
                sel_rd_mux <= "000";
                
            next_state <= fetch;
            
            -- instrucaoo JMP
             when exec_jmp =>
                immed <= X"00" & instruction(9 downto 2); -- imediato estendido
                pc_src <= "01";      -- soma com imediato
                pc_en  <= '1';       -- sempre habilita atualização do PC

                rom_en <= '0';
                pc_clr <= '0';
                pc_inc <= '0';
                ir_ld  <= '0';
                ram_sel <= '0';
                ram_we <= '0';
                rf_sel <= "000";
                rd_sel <= "000";
                rd_wr  <= '0';
                rm_sel <= "000";
                rn_sel <= "000";
                ula_op <= "0000";

            next_state <= fetch;
            
            -- intrucao jeq #Im (PC = PC + #Im)tipo desvio
            when exec_jeq =>
                immed <= X"00" & instruction(9 downto 2);
                pc_src <= "01";      -- soma com imediato
                sel_rd_mux <= "000";
                if flag_z = '1' and flag_c = '0' then
                    pc_en <= '1';    -- habilita escrita no pc
                else
                    pc_en <= '0';       -- nao altera o pc
                    pc_src <= "00";
                end if;
                
                rom_en <= '0';
                pc_clr <= '0';
                pc_inc <= '0';
                ir_ld <= '0';
                ram_sel <= '0';
                ram_we <= '0';
                rf_sel <= "000";
                rd_sel <= "000";
                rd_wr <= '0';
                rm_sel <= "000";
                rn_sel <= "000";
                ula_op <= "0000";
                io_write <= '0';
            next_state <= fetch;
            
            -- instrução jlt #im (PC = PC + #Im), se Z=0 e C=1
            when exec_jlt =>
                immed <= X"00" & instruction (9 downto 2);
                sel_rd_mux <= "000";
                pc_src <= "01";     -- soma com o imediato
                if flag_z = '0' and flag_c = '1' then
                    pc_en <= '1';       -- habilita escrita no pc
                
                else
                    pc_en <= '0';       -- pc n muda
                    pc_src <= "00";
                end if;
                
                rom_en <= '0';
                pc_clr <= '0';
                pc_inc <= '0';
                ir_ld <= '0';
                ram_sel <= '0';
                ram_we <= '0';
                rf_sel <= "000";
                rd_sel <= "000";
                rd_wr <= '0';
                rm_sel <= "000";
                rn_sel <= "000";
                ula_op <= "0000";
                io_write <= '0';
            next_state <= fetch;
            
            -- instrução jgt #im (PC = PC + #Im), se Z=0 e C=0
            when exec_jgt =>
                immed <= X"00" & instruction (9 downto 2);
                sel_rd_mux <= "000";
                pc_src <= "01";     -- soma com o imediato
                if flag_z = '0' and flag_c = '0' then
                    pc_en <= '1';       -- habilita escrita no pc
                
                else
                    pc_en <= '0';       -- pc n muda
                    pc_src <= "00";
                end if;
                
                rom_en <= '0';
                pc_clr <= '0';
                pc_inc <= '0';
                ir_ld <= '0';
                ram_sel <= '0';
                ram_we <= '0';
                rf_sel <= "000";
                rd_sel <= "000";
                rd_wr <= '0';
                rm_sel <= "000";
                rn_sel <= "000";
                ula_op <= "0000";
                io_write <= '0';
            next_state <= fetch;
            
            when exec_out_rm =>
                io_write <= '1';
                rm_sel <= instruction(10 downto 8);  -- Seleciona o registrador fonte
                sel_rd_mux <= "000";
    
                -- Controles secundários
                rd_wr <= '0';
                ram_we <= '0';
                rf_sel <= "000";
                ula_op <= "0000";
                pc_en <= '0';
                
                rom_en <= '0';
                pc_clr <= '0';
                pc_inc <= '0';
                ir_ld <= '0';
                immed <= (others => '0');
                rn_sel <= "000";
                rd_sel <= "000";
                
                next_state <= fetch;
                
                -- instruçao IN Rd Rd = IO_read(7 . . 0) E/S 1 1 1 1 - - - - - - - 0 1
                when exec_in =>
                    rom_en   <= '0';
                    pc_en    <= '0';
                    pc_inc   <= '0';
                    pc_clr   <= '0';
                    ir_ld    <= '0';
                    ram_sel  <= '0';
                    ram_we   <= '0';
                    
                    rf_sel   <= "100";       -- io_read como fonte para o banco de reg
                    rd_sel   <= instruction(10 downto 8);           -- seleciona rd da instrucao
                    rd_wr    <= '1';                                -- escrita no reg de destino
                    
                    rm_sel   <= "000";
                    rn_sel   <= "000";
                    ula_op   <= "0000";
                    immed    <= (others => '0');
                    io_write <= '0';
                    sel_rd_mux <= "100";
                        
                next_state <= fetch;
                
                -- OUT #Im  (IO_write = #Im)
                 when exec_out_im =>
                    -- Envia imediato para saída
                    io_write <= '1'; 
                    immed <= X"00" & instruction(7 downto 0); -- valor imediato nos bits [7:0]
    
                -- Desabilita todas as outras escritas
                    rom_en   <= '0';
                    pc_en    <= '0';
                    pc_inc   <= '0';
                    pc_clr   <= '0';
                    ir_ld    <= '0';
                    ram_sel  <= '0';
                    ram_we   <= '0';
                    rf_sel   <= "000";
                    rd_sel   <= "000";
                    rd_wr    <= '0';
                    rm_sel   <= "000";
                    rn_sel   <= "000";
                    ula_op   <= "0000";

                next_state <= fetch;
                
                -- instrucao SHR Rd,Rm, #Im  (Rd = Rm >> #Im)
                when exec_shr =>
                    ula_op  <= "1100";
                    rm_sel  <=  instruction(7 downto 5);
                    rd_sel  <= instruction(10 downto 8);
                    immed   <= X"00" & instruction(7 downto 0);
                    rf_sel  <= "010";
                    rd_wr   <= '1';
                    ram_sel <= '0';
                    ram_we  <= '0';
                    rn_sel  <= "000";
                    io_write <= '0';
                    sel_rd_mux <= "000";
                    
                next_state <= fetch;
                
                when exec_shl =>
                    rm_sel <= instruction(7 downto 5);         -- Rm (valor a ser deslocado)
                    rd_sel <= instruction(10 downto 8);        -- Rd (destino)
                    rd_wr  <= '1';                             -- habilita escrita em Rd
                    rf_sel <= "010";                            -- usa imediato como entrada B da ULA
                    ula_op <= "1110";                          -- código do SHL na ULA
                    immed <= "00000000000" & instruction(4 downto 0);  -- 11 + 5 = 16 bits                ram_sel <= '0';                            -- RAM não usada
                    ram_we  <= '0';                            -- não é escrita
                    rn_sel  <= "000";                          -- não usado
                    io_write <= '0';

                next_state <= fetch;
                
                -- instrucao ROR Rd, Rm   (Rd = Rm >> 1; Rd(MSB) = Rm(LSB))
                when exec_ror =>
                    ula_op  <= "1101";
                    rm_sel  <=  instruction(7 downto 5);    -- Rm: operando de entrada
                    rd_sel  <= instruction(10 downto 8);    -- Rd: destino do resultado
                    immed   <= (others => '0');
                    rf_sel  <= "011";                       -- saida da ula
                    rd_wr   <= '1';
                    ram_sel <= '0';
                    ram_we  <= '0';
                    rn_sel  <= "000";
                    io_write <= '0';
                    sel_rd_mux <= "000";
                    
                next_state <= fetch;
                
                when exec_rol =>
                    rm_sel  <= instruction(8 downto 6);  -- Rm
                    rd_sel  <= instruction(11 downto 9); -- Rd
                    rd_wr   <= '1';
                    rf_sel  <= "000";                     -- Usa saída da ULA
                    ula_op  <= "1111";                   -- Código para ROL
                    immed   <= (others => '0');          -- Não utilizado
                    ram_sel <= '0';
                    ram_we  <= '0';
                    rn_sel  <= "000";
                    io_write <= '0';
                    next_state <= fetch;
                
             when others => next_state <= exec_nop;
            
        end case;
    end if;
    
    
    end process;
    



instruction <= ir_data;
opcode <= ir_data(15 downto 12);

end Behavioral;