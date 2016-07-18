library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity cpu is
	port(
		clk, rst: in std_logic;
	);
end cpu;

architecture Behavioral of cpu is

signal reg: array(63 downto 0) of std_logic_vector(31 downto 0);
signal rs_addr, rt_addr, rd_addr: std_logic_vector(5 downto 0);
signal pc: std_logic_vector(31 downto 0);
signal rs_value, rt_value, rd_value: std_logic_vector(31 downto 0);
signal state : std_logic_vector(1 downto 0):= "000";
signal alumem: std_logic;

begin

	process(clk, rst)
	variable reg:std_logic_vector(3 downto 0);
	begin
		if rst = '0' then
			state <= "000";
			reg <= (others => '0');
		elsif rising_edge(clk) then
			case state is
				when "000" | "001" | "010" | "100" | "110" | "111" => state <= state + "001"; alumem <= '1';
				when "011" =>
					if mem_signal = "000" then state <= "000"; alumem <= '0';
						else state <= "100"; alumem <= '1'; end if;
				when "101" =>
					if is_sb = "1" then state <= "110";
						else state <= "000"; end if;
					alumem <= '1';
			end case;
		end if;
	end process;
	
	process(clk, rst)	-- branch calculation and load register
	variable sv, rv: std_logic_vector(31 downto 0);
	begin
		if rst = '0' then
			pc <= (others => '0');
		elsif rising_edge(clk) and state = "011" then
			--- cmp_signal: 3+210
			--- s=t s!t s>0 s>=0 s<0 s<=0 1 0
			--- 1   2   3   4    5   6    7 0
			-- case first is
				-- when F_ZERO =>
				-- case last is
					-- when L_JALR | L_JR => cmp_signal <= "1111";
					-- when others => cmp_signal <= "0000";
				-- end case;
				-- when F_BEQ => cmp_signal <= "0001";
				-- when F_BNE => cmp_signal <= "0010";
				-- when F_BGTZ => cmp_signal <= "0011";
				-- when F_BGEZBLTZ => cmp_signal <= "010" & not ins(16);
				-- when F_BLEZ => cmp_signal <= "0110";
				-- when F_J | F_JAL => cmp_signal <= "0111";
				-- when F_ERETTLBWI =>
					-- if last = L_ERET then cmp_signal <= "1000"; else cmp_signal <= "0000"; end if;
				-- when others => cmp_signal <= "0000";
			-- end case;
			sv := reg(rs_addr)
			tv := reg(rt_addr)
			rs_value <= sv;
			rt_value <= tv;
			rd_value <= reg(rd_addr);
			
			if cmp_signal = "0001" and sv = tv or cmp_signal = "0010" and sv /= tv or
				cmp_signal = "0011" and sv > 0 or cmp_signal = "0100" and sv >= 0 or
				cmp_signal = "0101" and sv < 0 or cmp_signal = "0110" and sv <= 0 or
				cmp_signal = "0111" then
				pc <= npc;
			elsif cmp_signal = "1111" then
				pc <= sv;
			elsif cmp_signal = "1000" then
				pc <= reg(epc);
			else
				pc <= pc + lpc;
			end if;
		end if;
	end process;
	
	process(clk, rst)	-- write back
	variable wb_result: std_logic_vector(31 downto 0);
	begin
		if rst = '0' then
			null;
		elsif rising_edge(clk) and state = "000" then
			--- wb:
			--- ->t ->d ->RA no
			--- 1   2   3    0
			if alumem = '0' then wb_result := alu_result;
				else wb_result := mem_result; end if;
			case wb_signal is
				when "01" => reg(rt_addr) <= wb_result;
				when "10" => reg(rd_addr) <= wb_result;
				when "11" => reg(ra) <= wb_result;
				when others => null;
			end case;
		end if;
	end process;

end Behavioral;
