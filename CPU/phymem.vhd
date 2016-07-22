library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.const.ALL;

entity phymem is
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
end phymem;

architecture Behavioral of phymem is
signal saved: std_logic_vector(31 downto 0);
variable addr: std_logic_vector(19 downto 0);
variable data: std_logic_vector(31 downto 0);
begin
	process(clk, rst)	-- phymem
	begin
		if rst = '0' then
		elsif rising_edge(clk) then
			if state = "000" or state = "010" or state = "100" or state = "110" then
				if state = "110" then saved <= ram_data; end if;
				ram_data <= (others => 'Z');
				ram_ce <= '1';
				ram_oe <= '1';
				ram_we <= '1';
			elsif state = "001" or state = "101" or state = "111" then
				if state = "001" then addr := pc; else addr := alu_result; end if;
				if state = "101" then data := data_in;
				elsif state = "111" then data := saved(31 downto 8) & data_in(7 downto 0);
				else data := (others => 'Z'); end if;

				if ram_signal(1) = '1' then
					ram_addr <= addr;
					ram_ce <= '0';
					if ram_signal(0) = '0' then ram_oe <= '0'; else
						ram_we <= '0';
						ram_data <= data;
					end if;
				end if;
			end if;
		end if;
	end process;
end Behavioral;
