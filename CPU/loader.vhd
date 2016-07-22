library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.const.ALL;

entity loader is
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
end loader;

architecture Behavioral of loader is

begin
	process (clk, rst)
	begin
		if rst = '0' then
			flash_addr <= (0 => '0', others => '1');
		elsif rising_edge(clk) then
			if flash_addr < (8 => '1', 7 => '1', others => '0') then
				flash_stop <= '0';
				case state is
					when S0 =>
						flash_oe <= '1';
						flash_data <= (others => 'Z');
						flash_addr <= flash_addr + "10";
					when S1 =>
						flash_oe <= '0';
					when S2 =>
						flash_out(31 downto 16) <= flash_data;
						flash_oe <= '1';
						flash_data <= (others => 'Z');
						flash_addr <= flash_addr + "10";
					when S3 =>
						flash_oe <= '0';
					when S4 =>
						flash_out(15 downto 0) <= flash_data;
						flash_oe <= '1';
					when others => null;
				end case;
			else
				flash_stop <= '1';
			end if;
		else flash_ie <= '1';
		end if;
	end process;
end Behavioral;

