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
		ram_ce: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;

		rxd: in std_logic;
		txd: out std_logic
	);
end phymem;

architecture Behavioral of phymem is
begin
	process(clk, rst)
	begin
		if rst = '0' then
			ram_data <= (others => 'Z');
			ram_ce <= '1';
			ram_oe <= '1';
			ram_we <= '1';
			txd <= '1';
		elsif rising_edge(clk) then
			if state = IF0 or state = ID or state = MA0 or state = MA2 or state = S0 then
				ram_data <= (others => 'Z');
				ram_ce <= '1';
				ram_oe <= '1';
				ram_we <= '1';
				txd <= '1';
			elsif state = IF1 or state = MA1 or state = MA3 or state = S5 then
				if ram_signal(1) = '1' then
					if addr = THI(19 downto 0) then
						if ram_signal(0) = '0' then null; else
							txd <= '0';
							ram_data <= data;
						end if;
					else
						ram_addr <= addr;
						ram_ce <= '0';
						if ram_signal(0) = '0' then ram_oe <= '0'; else
							ram_we <= '0';
							ram_data <= data;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
end Behavioral;
