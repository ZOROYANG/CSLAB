library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
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
end alu;

architecture Behavioral of alu is

signal hilo : std_logic_vector(63 downto 0);

begin
	process(clk, rst)
	variable imreg :std_logic_vector(5 downto 0);
	begin
		if rst = '0' then
			null;
		elsif rising_edge(clk) and state = "011" then
			data_out <= rt_value;
			if alu_signal(5) = '1' then
				imreg := imme;
			else
				if alu_signal(3 downto 0) = "0110" or alu_signal(3 downto 0) = "0110" or
					alu_signal(3 downto 0) = "0110" then
					imreg := rt_value;
				else
					imreg := rs_value;
				end if;
			end if;
			--- alu signal: 5+4+3210
			--- + - & | ^ ~| << >>a >>l <s =d =t <u
			--- 0 1 2 3 4 5  6  7   8   9  10 11 12
			--- * ->lo ->hi <-lo <-hi
			--- 0 1    2    3    4
			if alu_signal(4) = '1' then
				case alu_signal(3 downto 0) is
					when "0000" =>
						hilo <= std_logic_vector(signed(rs_value) * signed(rt_value));
					when "0001" =>
						hilo(31 downto 0) <= rs_value;
					when "0010" =>
						hilo(63 downto 32) <= rs_value;
					when "0011" =>
						alu_result <= hilo(31 downto 0);
					when "0100" =>
						alu_result <= hilo(63 downto 32);
					when others => null;
				end case;
			else
				case alu_signal(3 downto 0) is
					when "0000" => alu_result <= rs_value + imreg;
					when "0001" => alu_result <= rs_value - imreg;
					when "0010" => alu_result <= rs_value and imreg;
					when "0011" => alu_result <= rs_value or imreg;
					when "0100" => alu_result <= rs_value xor imreg;
					when "0101" => alu_result <= not (rs_value or imreg);
					when "0110" =>
						alu_result <= to_stdlogicvector(to_bitvector(rt_value) sll to_integer(unsigned(imreg)));
					when "0111" =>
						alu_result <= to_stdlogicvector(to_bitvector(rt_value) sra to_integer(unsigned(imreg)));
					when "1000" =>
						alu_result <= to_stdlogicvector(to_bitvector(rt_value) srl to_integer(unsigned(imreg)));
					when "1001" =>
						if (signed(rs_value) < signed(imreg)) then
							alu_result <= (0 => '1', others => '0');
						else
							alu_result <= (others => '0');
						end if;
					when "1010" => alu_result <= rd_value;
					when "1011" => alu_result <= rt_value;
					when "1100" =>
						if (unsigned(rs_value) < unsigned(imreg)) then
							alu_result <= (0 => '1', others => '0');
						else
							alu_result <= (others => '0');
						end if;
					when others => null;
				end case;
			end if;
		end if;
	end process;

end Behavioral;
