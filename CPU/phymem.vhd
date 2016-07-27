library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.const.ALL;

entity phymem is
	port(
		clk, rst: in std_logic;
		state: in status;
		addr: in std_logic_vector(19 downto 0);
		data: in std_logic_vector(31 downto 0);
		ram_signal: in std_logic_vector(1 downto 0);
		
		ram_addr: out std_logic_vector(19 downto 0);
		ram_data: inout std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0);
		ram_ce: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;

		data_ready: in std_logic;
		rdn: out std_logic;
		wrn: out std_logic
	);
end phymem;

architecture Behavioral of phymem is
signal mstate: std_logic_vector(3 downto 0);
begin
	process(clk, rst)
	begin
		if rst = '0' then
			ram_data <= (others => 'Z');
			ram_oe <= '1';
			ram_we <= '1';
			wrn <= '1';
			rdn <= '1';
		elsif rising_edge(clk) then
			case mstate is
				when "0000" =>
					ram_data <= (others => 'Z');
					if ram_signal(1) = '1' then
						if ram_signal(0) = '0' then
							if addr = CADDR then mstate <= "0101";
							elsif addr = SADDR then
								mstate <= "0000";
								data_out <= (1 => data_ready, others => '1');
							else mstate <= "0001"; end if;
						else
							if addr = CADDR then mstate <= "1101";
							else mstate <= "1001"; end if;
						end if;
					else mstate <= "0000";
					end if;
				when "0001" =>
					ram_ce <= '0';
					ram_oe <= '0';
					ram_addr <= addr(19 downto 2) & "00";
					mstate <= "0010";
				when "0010" =>
					data_out <= ram_data;
					mstate <= "0011";
				when "0011" =>
					ram_ce <= '1';
					ram_oe <= '1';
					mstate <= "0000";
				when "1001" =>
					ram_oe <= '1';
					ram_ce <= '0';
					ram_we <= '1';
					ram_addr <= addr(19 downto 2) & "00";
					ram_data <= data;
					mstate <= "1010";
				when "1010" =>
					ram_we <= '0';
					mstate <= "1011";
					data_out <= ram_data;
				when "1011" =>
					ram_ce <= '1';
					ram_we <= '1';
					mstate <= "0000";
				when "0101" =>
					rdn <= '0';
					mstate <= "0110";
				when "0110" =>
					data_out <= ram_data;
					mstate <= "0111";
				when "0111" =>
					rdn <= '1';
					mstate <= "0000";
				when "1101" =>
					ram_data <= data;
					mstate <= "1110";
				when "1110" =>
					wrn <= '0';
					mstate <= "1111";
				when "1111" =>
					wrn <= '1';
					mstate <= "0000";
				when others =>
					mstate <= "0000";
			end case;
		end if;
	end process;
end Behavioral;
