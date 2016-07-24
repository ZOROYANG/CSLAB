----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:05:27 11/05/2015 
-- Design Name: 
-- Module Name:    display - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
	Port ( 
		num: in STD_LOGIC_VECTOR (7 downto 0);
		display_h: out STD_LOGIC_VECTOR (6 downto 0);
		display_l: out STD_LOGIC_VECTOR (6 downto 0)
	);
end display;

architecture Behavioral of display is

begin
	process(num)
	begin
		case num(3 downto 0) is
			when "0000"=>display_l<="0111111";
			when "0001"=>display_l<="0000110";
			when "0010"=>display_l<="1011011";
			when "0011"=>display_l<="1001111";
			when "0100"=>display_l<="1100110";
			when "0101"=>display_l<="1101101";
			when "0110"=>display_l<="1111101";
			when "0111"=>display_l<="0000111";
			when "1000"=>display_l<="1111111";
			when "1001"=>display_l<="1101111";
			when "1010"=>display_l<="1110111";
			when "1011"=>display_l<="1111100";
			when "1100"=>display_l<="0111001";
			when "1101"=>display_l<="1011110";
			when "1110"=>display_l<="1111001";
			when "1111"=>display_l<="1110001";
			when others=>display_l<="0000000";
		end case;
		case num(7 downto 4) is
			when "0000"=>display_h<="0111111";
			when "0001"=>display_h<="0000110";
			when "0010"=>display_h<="1011011";
			when "0011"=>display_h<="1001111";
			when "0100"=>display_h<="1100110";
			when "0101"=>display_h<="1101101";
			when "0110"=>display_h<="1111101";
			when "0111"=>display_h<="0000111";
			when "1000"=>display_h<="1111111";
			when "1001"=>display_h<="1101111";
			when "1010"=>display_h<="1110111";
			when "1011"=>display_h<="1111100";
			when "1100"=>display_h<="0111001";
			when "1101"=>display_h<="1011110";
			when "1110"=>display_h<="1111001";
			when "1111"=>display_h<="1110001";
			when others=>display_h<="0000000";
		end case;
	end process;

end Behavioral;

