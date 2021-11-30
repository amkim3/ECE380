library IEEE;
use IEEE.std_logic_1164.all;

entity w_and is
	port(
		active_high, active_low : IN STD_LOGIC;
		S : OUT STD_LOGIC);
end entity;

architecture w_and_logic of w_and is
begin
	process
		S <= (NOT active_low) AND active_high;
	end process;
end architecture;