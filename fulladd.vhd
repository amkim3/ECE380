Library ieee;
use ieee.std_logic_1164.all;

Entity fulladd IS
	PORT( CIN, x,y: IN STD_LOGIC;
			s, COUT: OUT STD_LOGIC);
END fulladd;

ARCHITECTURE Behavior of fulladd IS
BEGIN
	s <= CIN XOR x XOR y;
	COUT <= (x AND y) OR (x AND CIN) OR (y AND CIN);
END Architecture;