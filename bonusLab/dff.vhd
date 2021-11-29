library ieee;
use ieee.std_logic_1164.all;

entity dff is 
	port(D, Clk, En, Reset : in std_logic;
			  Q, Qbar    : out std_logic);
end entity;

architecture logic of dff is
begin
	signal Dd : STD_LOGIC;
	process(Clk, Reset)
		if Reset='1' then
			Q<='0' after 2 ns;
		elsif (Clk'event AND Clk='1') then
			Q<= (En AND D) after 2 ns;
		end if
		Qbar=NOT Q;
	end process;
end architecture;
			
		