library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.const.ALL;

entity cpu is
	port(
		clk, rst: in std_logic;
		sw: in std_logic_vector(31 downto 0);
		led: out std_logic_vector(16 downto 0);
		dyp: out std_logic_vector(13 downto 0);
		rxd, txd: out std_logic;

		ram_addr: out std_logic_vector(19 downto 0);
		ram_data: inout std_logic_vector(31 downto 0);
		ram_ce, ram_oe, ram_we: out std_logic;
		flash_addr: out std_logic_vector(22 downto 0);
		flash_data: inout std_logic_vector(15 downto 0);
		flash_ce0, flash_ce1, flash_ce2: out std_logic;
		flash_rp, flash_oe, flash_we: out std_logic;
		flash_vpen, flash_byte: out std_logic
	);
end cpu;

architecture Behavioral of cpu is
component decode is
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
end component;
component alu is
	port(
		clk, rst: in std_logic;
		
		rd_addr, rt_addr: in std_logic_vector(5 downto 0);
		rs_value, rt_value, rd_value, imme: in std_logic_vector(31 downto 0);
		mem_signal: in std_logic_vector(2 downto 0);
		alu_signal: in std_logic_vector(5 downto 0);
		wb_signal: in std_logic_vector(1 downto 0);
		state: in std_logic_vector(2 downto 0);
		
		alu_result: out std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0)
	);
end component;
component phymem is
	port(
		clk, rst: in std_logic;
		state: in std_logic_vector(2 downto 0);
		pc: in std_logic_vector(19 downto 0);
		alu_result: in std_logic_vector(19 downto 0);
		data_in: in std_logic_vector(31 downto 0);
		ram_signal: in std_logic_vector(1 downto 0);
		
		ram_addr: out std_logic_vector(19 downto 0);
		ram_data: inout std_logic_vector(31 downto 0);
		ram_ce: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;

		rxd, txd: out std_logic
	);
end component;



signal reg: array(63 downto 0) of std_logic_vector(31 downto 0);
signal rs_addr, rt_addr, rd_addr: std_logic_vector(5 downto 0);
signal alu_signal: std_logic_vector(5 downto 0);
signal mem_signal: std_logic_vector(2 downto 0);
signal wb_signal: std_logic_vector(1 downto 0);
signal alu_result: std_logic_vector(31 downto 0);
signal pc: std_logic_vector(31 downto 0);
signal imme: std_logic_vector(31 downto 0);
signal state : std_logic_vector(2 downto 0):= "000";

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
					if mem_signal = "010" then state <= "110";
						else state <= "000"; end if;
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
			--- mem:
			--- sw sb lw lb lbu lhu no
			--- 1  2  4  6  7   5   0
			if alumem = '0' then
				wb_result := alu_result;
			else
			 	case mem_signal is
					when "101" => wb_result := ext(mem_result(15 downto 0), 32);
					when "110" => wb_result := sxt(mem_result(7 downto 0), 32);
					when "111" => wb_result := ext(mem_result(7 downto 0), 32);
					when others => wb_result := mem_result;
				end case;
			end if;
			case wb_signal is
				when "01" => reg(rt_addr) <= wb_result;
				when "10" => reg(rd_addr) <= wb_result;
				when "11" => reg(ra) <= wb_result;
				when others => null;
			end case;
		end if;
	end process;

	u_ID: decode port map(clk => clk, rst => rst,
		pc => pc, ins => ram_data,
		state => state, npc => pc,
		rs_addr => rs_addr, rt_addr => rt_addr, rd_addr => rd_addr,
		imme => imme,
		mem_signal => mem_signal, alu_signal => alu_signal,
		cmp_signal => cmp_signal, wb_signal => wb_signal);

	u_EX: alu port map(clk => clk, rst => rst,
		rd_addr => rd_addr, rt_addr => rt_addr,
		rs_value => reg(rs_addr), rt_value => reg(rt_addr), rd_value => reg(rd_addr),
		imme => imme,
		mem_signal => mem_signal, alu_signal => alu_signal, wb_signal => wb_signal,
		state => state,
		alu_result => alu_result, data_out => mem_data);

	u_MEM: phymem port map(clk => clk, rst => rst,
		state => state, pc => pc,
		alu_result => alu_result, data_in => mem_data,
		ram_signal => ram_signal,
		ram_addr => mem_addr, ram_data => mem_data,
		ram_ce => ram_ce, ram_oe => ram_oe, ram_we => ram_we,
		rxd => rxd, txd => txd);

end Behavioral;
