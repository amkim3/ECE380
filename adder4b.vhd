LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY adder4b IS
	PORT( Cin : IN STD_LOGIC;
	X,Y : IN SIGNED(3 DOWNTO 0);
	S : OUT SIGNED(3 DOWNTO 0);
	Cout, Over: OUT STD_LOGIC);
END adder4b;

Architecture Behavior of adder4b IS
	COMPONENT fulladd is
		PORT( CIN, x,y: IN STD_LOGIC;
			s, COUT: OUT STD_LOGIC);
	END Component;
	Signal co1,co2,co3,co4 : STD_LOGIC;
Begin
	add1: fulladd port map(Cin,X(0),Y(0),S(0),co1);
	add2: fulladd port map(co1,X(1),Y(1),S(1),co2);
	add3: fulladd port map(co2,X(2),Y(2),S(2),co3);
	add4: fulladd port map(co3,X(3),Y(3),S(3),co4);
	Cout <= co4;
	Over <= co4 XOR co3;
End Architecture;