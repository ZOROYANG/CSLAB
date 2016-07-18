library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity decode is
	port(
		clk, rst: in std_logic;
		state: in std_logic_vector(2 downto 0);
		addr: in std_logic_vector(19 downto 0);
		data_in: in std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0);
		ram_signal: in std_logic_vector(1 downto 0);
		
		ram_addr: out std_logic_vector(19 downto 0);
		ram_data: inout std_logic_vector(31 downto 0);
		ram_ce: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;
	);
end decode;

architecture Behavioral of decode is
begin
	process(clk, rst)	-- ram
	begin
		if rst = '0' then
		elsif rising_edge(clk) then
			if state = "000" or state = "010" or state = "100" or state = "110" then
				ram_data <= (others => 'Z');
				ram_ce <= '1';
				ram_oe <= '1';
				ram_we <= '1';
			elsif state = "001" or state = "101" or state = "111" then
				if ram_signal(1) = '1' then
					ram_addr <= addr;
					ram_ce <= '0';
					if ram_signal(0) = '0' then ram_oe <= '0'; else ram_we <= '0'; end if;
				end if;
			end if;
		end if;
	end process;
end Behavioral;
