library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.const.ALL;

entity cpu is
	port(
		clk0, clk1, rst: in std_logic;
		sw: in std_logic_vector(31 downto 0);
		led: out std_logic_vector(15 downto 0);
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
		state: in status;
		
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
		state: in status;
		
		alu_result: out std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0)
	);
end component;
component phymem is
	port(
		clk, rst: in std_logic;
		state: in status;
		addr: in std_logic_vector(19 downto 0);
		data: in std_logic_vector(31 downto 0);
		ram_signal: in std_logic_vector(1 downto 0);
		
		ram_addr: out std_logic_vector(19 downto 0);
		ram_data: inout std_logic_vector(31 downto 0);
		ram_ce: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;

		rxd, txd: out std_logic
	);
end component;
component loader is
	Port(
		clk: in std_logic;
		rst: in std_logic;
		state: in status;
		
		flash_data: inout std_logic_vector(15 downto 0);
		flash_addr: out std_logic_vector(22 downto 0);
		flash_out: out std_logic_vector(31 downto 0);
		flash_stop: out std_logic;
		flash_oe: out std_logic
	);
end component;
component display is
	Port ( 
		num: in STD_LOGIC_VECTOR (7 downto 0);
		display_h: out STD_LOGIC_VECTOR (6 downto 0);
		display_l: out STD_LOGIC_VECTOR (6 downto 0)
	);
end component;



signal clk : std_logic;

type array_vector is array(63 downto 0) of std_logic_vector(31 downto 0);
signal reg: array_vector := (others => (others => '0'));
signal rs_addr, rt_addr, rd_addr: std_logic_vector(5 downto 0);
signal alu_signal: std_logic_vector(5 downto 0);
signal cmp_signal: std_logic_vector(3 downto 0);
signal mem_signal: std_logic_vector(2 downto 0);
signal wb_signal: std_logic_vector(1 downto 0);
signal ram_signal: std_logic_vector(1 downto 0);
signal alu_result: std_logic_vector(31 downto 0);
signal rs_value, rt_value, rd_value: std_logic_vector(31 downto 0);
signal pc: std_logic_vector(31 downto 0);
signal npc: std_logic_vector(31 downto 0);
signal imme: std_logic_vector(31 downto 0);
signal addr_in: std_logic_vector(19 downto 0);
signal data_in: std_logic_vector(31 downto 0);
signal flash_out: std_logic_vector(31 downto 0);
signal mem_data: std_logic_vector(31 downto 0);
signal num: std_logic_vector(7 downto 0);
signal state : status:= S0;
signal alumem, flash_stop: std_logic;

begin

	process(rst, state, sw, clk0, clk1)
	begin
		if rst = '0' then
			clk <= '0';
		elsif state = S0 or state = S1 or state = S2 or state = S3 or state = S4 or state = S5 then
			clk <= clk1;
		else
			clk <= (sw(31) and clk1) xor clk0; 
		end if;
	end process;

	process(sw, reg, pc, npc, imme, ram_data, alu_signal, cmp_signal, mem_signal, wb_signal, ram_signal)
	begin
		if sw(30) = '1' then
			if sw(29) = '0' then
				led <= reg(conv_integer(sw(5 downto 0)))(15 downto 0);
			else case sw(1 downto 0) is
					when "00" => led <= pc(15 downto 0);
					when "01" => led <= npc(15 downto 0);
					when "10" => led <= imme(15 downto 0);
					when "11" => led <= ram_data(15 downto 0);
					when others => null;
				end case;
			end if;
		elsif sw(29) = '1' then
			if sw(28) = '0' then
				led <= alu_signal & "00" & cmp_signal & "0" & mem_signal;
			else
				led <= wb_signal & "0000" & ram_signal & "00000000";
			end if;
		elsif sw(28) = '1' then
			null;
		end if;
	end process;

	process(state)
	begin
		case state is
			when S0 => num <= "00000000";
			when S1 => num <= "00000001";
			when S2 => num <= "00000010";
			when S3 => num <= "00000011";
			when S4 => num <= "00000100";
			when IF0 => num <= "00010000";
			when IF1 => num <= "00010001";
			when ID => num <= "00010010";
			when EX => num <= "00010011";
			when MA0 => num <= "00010100";
			when MA2 => num <= "00010110";
			when MA3 => num <= "00010111";
			when others => num <= "11111111";
		end case;
--		with state select
--			num <= "00000" when S0, "00001" when S1, "00010" when S2, "00011" when S3, "00100" when S4, "00101" when S5,
--				"10000" when IF0, "10001" when IF1, "10010" when ID, "10011" when EX, "10100" when MA0, "10101" when MA1,
--				"10110" when MA2, "10111" when MA3;
	end process;

	process(clk, rst)
	begin
		if rst = '0' then
			state <= S0;
			addr_in <= (others => '1');
		elsif rising_edge(clk) then		
			case state is
				when IF0 => state <= IF1;
					ram_signal <= "10";
					addr_in <= pc(19 downto 0);
				when IF1 => state <= ID;
				when ID => state <= EX;
				when MA0 => state <= MA1;
					ram_signal(0) <= (mem_signal(0) or mem_signal(1) or mem_signal(2));
					if mem_signal = "001" then ram_signal(1) <= '1';
						else ram_signal(1) <= '0'; end if;
					addr_in <= alu_result(19 downto 0);
					data_in <= mem_data;
				when MA2 => state <= MA3;
					ram_signal <= "11";
					addr_in <= alu_result(19 downto 0);
					data_in <= ram_data(31 downto 8) & mem_data(7 downto 0);
				when MA3 => state <= IF0;
				when EX =>
					if mem_signal = "000" then
						state <= IF0;
					else state <= MA0; end if;
					alumem <= '0';
				when MA1 =>
					if mem_signal = "010" then
						state <= MA2; 
					else state <= IF0; end if;
					alumem <= '1';
				when ST => state <= ST;
				when S0 => state <= S1;
				when S1 => state <= S2;
				when S2 => state <= S3;
				when S3 => state <= S4;
				when S4 => state <= S5;
					ram_signal <= "11";
				when S5 =>
					if flash_stop = '1' then state <= IF0;
						else state <= S0; end if;
					addr_in <= addr_in + "1";
					data_in <= flash_out;
				when others => null;
			end case;
		end if;
	end process;
	
	process(clk, rst)	-- branch calculation and load register
	variable sv, tv: std_logic_vector(31 downto 0);
	begin
		if rst = '0' then
			pc <= (others => '0');
		elsif rising_edge(clk) and state = EX then
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
			sv := reg(conv_integer(rs_addr));
			tv := reg(conv_integer(rt_addr));
			
			if (cmp_signal = "0001" and sv = tv) or (cmp_signal = "0010" and sv /= tv) or
				(cmp_signal = "0011" and sv > 0) or (cmp_signal = "0100" and sv >= 0) or
				(cmp_signal = "0101" and sv < 0) or (cmp_signal = "0110" and sv <= 0) or
				cmp_signal = "0111" then
				pc <= npc;
			elsif cmp_signal = "1111" then
				pc <= sv;
			elsif cmp_signal = "1000" then
				pc <= reg(conv_integer(epc));
			else
				pc <= pc + lpc;
			end if;
		end if;
	end process;
	
	process(clk, rst)	-- write back
	variable wb_result: std_logic_vector(31 downto 0);
	begin
		if rst = '0' then
			reg <= (others => (others => '0'));
		elsif rising_edge(clk) and state = IF0 then
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
					when "101" => wb_result := ext(ram_data(15 downto 0), 32);
					when "110" => wb_result := sxt(ram_data(7 downto 0), 32);
					when "111" => wb_result := ext(ram_data(7 downto 0), 32);
					when others => wb_result := ram_data;
				end case;
			end if;
			case wb_signal is
				when "01" => reg(conv_integer(rt_addr)) <= wb_result;
				when "10" => reg(conv_integer(rd_addr)) <= wb_result;
				when "11" => reg(conv_integer(ra)) <= wb_result;
				when others => null;
			end case;
		end if;
	end process;

	u_ID: decode port map(clk => clk, rst => rst,
		pc => pc, ins => ram_data,
		state => state, npc => npc,
		rs_addr => rs_addr, rt_addr => rt_addr, rd_addr => rd_addr,
		imme => imme,
		mem_signal => mem_signal, alu_signal => alu_signal,
		cmp_signal => cmp_signal, wb_signal => wb_signal);

	rs_value <= reg(conv_integer(rs_addr));
	rt_value <= reg(conv_integer(rt_addr));
	rd_value <= reg(conv_integer(rd_addr));
	
	u_EX: alu port map(clk => clk, rst => rst,
		rd_addr => rd_addr, rt_addr => rt_addr,
		rs_value => rs_value,
		rt_value => rt_value,
		rd_value => rd_value,
		imme => imme,
		mem_signal => mem_signal, alu_signal => alu_signal, wb_signal => wb_signal,
		state => state,
		alu_result => alu_result,
		data_out => mem_data);

	txd <= '1';
	rxd <= '1';
	u_MEM: phymem port map(clk => clk, rst => rst,
		state => state, addr => addr_in, data => data_in,
		ram_signal => ram_signal,
		ram_addr => ram_addr, ram_data => ram_data,
		ram_ce => ram_ce, ram_oe => ram_oe, ram_we => ram_we,
		rxd => rxd, txd => txd);

	flash_byte <= '1';
	flash_rp <= '1';
	flash_vpen <= '1';
	flash_we <= '1';
	flash_ce0 <= '0';
	flash_ce1 <= '0';
	flash_ce2 <= '0';
	u_LD: loader port map(
		clk => clk, rst => rst,
		state => state,
		flash_data => flash_data, flash_addr => flash_addr,
		flash_out => flash_out, flash_stop => flash_stop, flash_oe => flash_oe);

	u_DIS: display port map( 
		num => num,
		display_h => dyp(13 downto 7),
		display_l => dyp(6 downto 0));


end Behavioral;
