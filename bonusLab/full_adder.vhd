library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
	port(
	A, B, Cin: in STD_LOGIC;
	S, Cout : out STD_LOGIC);
end entity;

architecture logic of full_adder is
begin
	process(A,B,Cin)
	begin
		S <= A XOR B XOR CIN after 8 ns;
		Cout <= (A AND B) OR (B AND Cin);
	end process;
end architecture;
			