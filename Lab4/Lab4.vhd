LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Lab4 IS
	PORT ( a, b, c, d : IN STD_LOGIC ;
			f : OUT STD_LOGIC) ;
END Lab4 ;

ARCHITECTURE Behavior OF Lab4 IS
BEGIN
f<= NOT ( (NOT(b AND b)) AND (NOT(d AND NOT(a AND a))));
END Behavior;