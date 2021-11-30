library IEEE;
use IEEE.std_logic_1164.all;

entity w_and is
	port(
		active_high, active_low : IN STD_LOGIC;
		S : OUT STD_LOGIC);
end entity;

architecture w_and_logic of w_and is
begin
	process(active_high, active_low)
	begin
		S <= (NOT active_low) AND active_high after 4 ns;
	end process;
end architecture;