library ieee;
use ieee.std_logic_1164.all;

entity dflipflop is 
	port(D, Clk, En, Reset : in std_logic;
			  Q, Qbar    : out std_logic);
end entity;

architecture logic of dflipflop is
	signal Dd : STD_LOGIC;
begin
	process(Clk, Reset)
	begin
		if Reset='1' then
			Q<='0' after 2 ns;
			Qbar<='1';
		elsif (Clk'event AND Clk='1') then
			Q<= (En AND D) after 2 ns;
			Qbar<= NOT ( En AND D);
		end if;
	end process;
end architecture;
			
		