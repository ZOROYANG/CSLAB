library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity phymem is
	port(
		clk, rst: in std_logic;
		state: in std_logic_vector(2 downto 0);
		pc: in std_logic_vector(19 downto 0);
		alu_result: in std_logic_vector(19 downto 0);
		data_in: in std_logic_vector(31 downto 0);
		ram_signal: in std_logic_vector(1 downto 0);
		flash_signal: in std_logic_vector(1 downto 0);
		
		ram_addr: out std_logic_vector(19 downto 0);
		ram_data: inout std_logic_vector(31 downto 0);
		ram_ce: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;

		flash_addr: out STD_LOGIC_VECTOR(22 downto 0);
		flash_data: inout STD_LOGIC_VECTOR(15 downto 0);
		flash_ce0: out std_logic;
		flash_ce1: out std_logic;
		flash_ce2: out std_logic;
		flash_byte: out std_logic;
		flash_vpen: out std_logic;
		flash_rp: out std_logic;
		flash_oe: out std_logic;
		flash_we: out std_logic;

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
		flash_ce0 <= '0';
		flash_ce1 <= '0';
		flash_ce2 <= '0';
		flash_byte <= '1';
		flash_vpen <= '1';
		flash_rp <= '1';
		if rst = '0' then
		elsif rising_edge(clk) then
			if state = "000" or state = "010" or state = "100" or state = "110" then
				if state = "110" then saved <= ram_data; end if;
				ram_data <= (others => 'Z');
				ram_ce <= '1';
				ram_oe <= '1';
				ram_we <= '1';
				flash_oe <= '1';
				flash_we <= '1';
				flash_data <= (others => 'Z');
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
				elsif flash_signal(1) = '1' then
					flash_addr <= addr & "000";
					ram_oe <= '0';
				end if;
			end if;
		end if;
	end process;
end Behavioral;
