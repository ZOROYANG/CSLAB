library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.const.ALL;

entity decode is
	port(
		clk, rst: in std_logic;
		pc: in std_logic_vector(31 downto 0);
		ins: in std_logic_vector(31 downto 0);
		state: in std_logic_vector(2 downto 0);
		
		npc: out std_logic_vector(31 downto 0);
		rs_addr, rt_addr, rd_addr: out std_logic_vector(5 downto 0);
		imme: out std_logic_vector(31 downto 0);
		
		mem_signal: out std_logic_vector(2 downto 0);
		alu_signal: out std_logic_vector(5 downto 0);
		cmp_signal: out std_logic_vector(3 downto 0);
		wb_signal: out std_logic_vector(1 downto 0)
	);
end decode;

architecture Behavioral of decode is
begin
	process(clk, rst)	-- instruction decode
	variable first, last:std_logic_vector(5 downto 0);
	begin
		first := ins(31 downto 26);
		last := ins(5 downto 0);
		if rst = '0' then
			npc <= (others => '0');
		elsif rising_edge(clk) and state = ID then
			--- addr
			rs_addr <= '0' & ins(25 downto 21);
			rt_addr <= '0' & ins(20 downto 16);
			rd_addr <= ins(30) & ins(15 downto 11);
			
			-- case first is
				-- when F_ZERO =>
				-- case last is
					-- when L_ADDU =>
					-- when L_SLT =>
					-- when L_SLTU =>
					-- when L_SUBU =>
					-- when L_AND =>
					-- when L_OR =>
					-- when L_XOR =>
					-- when L_SLLV =>
					-- when L_SRAV =>
					-- when L_SRLV =>
					-- when L_SLL =>
					-- when L_SRA =>
					-- when L_SRL =>
					-- when L_JALR =>
					-- when L_JR =>
					-- when L_MTLO =>
					-- when L_MTHI =>
					-- when L_MULT =>
					-- when L_MFLO =>
					-- when L_MFHI =>
					-- when L_SYSCALL =>
					-- when others =>
				-- end case;
				-- when F_ADDIU =>
				-- when F_ANDI =>
				-- when F_ORI =>
				-- when F_XORI =>
				-- when F_SLTI =>
				-- when F_SLTIU =>
				-- when F_LW =>
				-- when F_SW =>
				-- when F_LB =>
				-- when F_LHU =>
				-- when F_LBU =>
				-- when F_SB =>
				-- when F_BGTZ =>
				-- when F_BLEZ =>
				-- when F_BGEZBLTZ =>
				-- when F_J =>
				-- when F_JAL =>
				-- when F_BEQ =>
				-- when F_BNE =>
				-- when F_LUI =>
				-- when F_CP =>
				-- case last is
					-- when L_ERET =>
					-- when L_TLBWI =>
					-- when L_MFC0MTC0 =>
					-- when others =>
				-- end case;
				-- when others =>
			-- end case;
			
			--- imme
			case first is
				when F_ZERO =>
				case last is
					when L_JALR => imme <= pc + lpc;
					when L_SLL | L_SRA | L_SRL => imme <= ext(ins(10 downto 6), 32);
					when others => imme <= (others => '0');
				end case;
				when F_JAL => imme <= pc + lpc;
				when F_SLTIU | F_ANDI | F_ORI | F_XORI => imme <= ext(ins(15 downto 0), 32);
				when F_LUI => imme <= ins(15 downto 0) & ZERO16;
				when others => imme <= sxt(ins(15 downto 0), 32);
			end case;
			--- PC
			case first is
				when F_ZERO => npc <= pc + lpc;
				when F_BEQ | F_BNE | F_BGEZBLTZ | F_BGTZ | F_BLEZ => npc <= pc + sxt(ins(15 downto 0), 32);
				when F_J | F_JAL => npc <= pc + sxt(ins(25 downto 0), 32);
				when others => npc <= pc + lpc;
			end case;
			--- mem:
			--- sw sb lw lb lbu lhu no
			--- 1  2  4  6  7   5   0
			case first is
				when F_LW => mem_signal <= "100";
				when F_LB => mem_signal <= "110";
				when F_LBU => mem_signal <= "111";
				when F_LHU => mem_signal <= "101";
				when F_SW => mem_signal <= "001";
				when F_SB => mem_signal <= "010";
				when others => mem_signal <= "000";
			end case;
			--- cmp_signal: 3+210
			--- s=t s!t s>0 s>=0 s<0 s<=0 1 0
			--- 1   2   3   4    5   6    7 0
			case first is
				when F_ZERO =>
				case last is
					when L_JALR | L_JR => cmp_signal <= "1111";
					when others => cmp_signal <= "0000";
				end case;
				when F_BEQ => cmp_signal <= "0001";
				when F_BNE => cmp_signal <= "0010";
				when F_BGTZ => cmp_signal <= "0011";
				when F_BGEZBLTZ => cmp_signal <= "010" & not ins(16);
				when F_BLEZ => cmp_signal <= "0110";
				when F_J | F_JAL => cmp_signal <= "0111";
				when F_CP =>
					if last = L_ERET then cmp_signal <= "1000"; else cmp_signal <= "0000"; end if;
				when others => cmp_signal <= "0000";
			end case;
			--- wb:
			--- ->t ->d ->RA no
			--- 1   2   3    0
			case first is
				when F_ZERO =>
				case last is
					when L_MULT | L_MTLO | L_MTHI | L_SYSCALL => wb_signal <= "00";
					when L_JALR => wb_signal <= "11";
					when others => wb_signal <= "10";
				end case;
				when F_BEQ | F_BNE | F_BGEZBLTZ | F_BGTZ | F_BLEZ | F_J | F_SB | F_SW => wb_signal <= "00";
				when F_JAL => wb_signal <= "11";
				when F_CP =>
					if last = L_MFC0MTC0 then
						if ins(23) = '0' then wb_signal <= "01"; else wb_signal <= "10"; end if;
					else wb_signal <= "00"; end if;
				when others => wb_signal <= "01";
			end case;
			--- alu signal: 5+4+3210
			--- + - & | ^ ~| << >>a >>l <s =d =t <u
			--- 0 1 2 3 4 5  6  7   8   9  10 11 12
			--- * ->lo ->hi <-lo <-hi
			--- 0 1    2    3    4
			case first is
				when F_ZERO =>
				case last is
					when L_ADDU => alu_signal <= "000000";
					when L_SLT => alu_signal <= "001001";
					when L_SLTU => alu_signal <= "101100";
					when L_SUBU => alu_signal <= "000001";
					when L_MULT => alu_signal <= "010000";
					when L_MFLO => alu_signal <= "010011";
					when L_MFHI => alu_signal <= "010100";
					when L_MTLO => alu_signal <= "010001";
					when L_MTHI => alu_signal <= "010010";
					when L_JALR => alu_signal <= "101011";
					when L_AND => alu_signal <= "000010";
					when L_NOR => alu_signal <= "000101";
					when L_OR => alu_signal <= "000011";
					when L_XOR => alu_signal <= "000100";
					when L_SLL => alu_signal <= "100110";
					when L_SLLV => alu_signal <= "000110";
					when L_SRA => alu_signal <= "100111";
					when L_SRAV => alu_signal <= "000111";
					when L_SRL => alu_signal <= "101000";
					when L_SRLV => alu_signal <= "001000";
					when others => alu_signal <= "000000";
				end case;
				when F_ADDIU | F_LW | F_LB | F_LBU | F_LHU | F_SB | F_SW => alu_signal <= "100000";
				when F_SLTI => alu_signal <= "101001";
				when F_SLTIU => alu_signal <= "101100";
				when F_JAL | F_LUI => alu_signal <= "101011";
				when F_ANDI => alu_signal <= "100010";
				when F_ORI => alu_signal <= "100011";
				when F_XORI => alu_signal <= "100100";
				when F_CP =>
					if last = L_MFC0MTC0 then alu_signal <= "00101" & ins(23);
					else alu_signal <= "000000"; end if;
				when others => alu_signal <= "000000";
			end case;
			
		end if;
	end process;

end Behavioral;
