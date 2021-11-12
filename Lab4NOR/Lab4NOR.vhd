LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY Lab4NOR IS
PORT ( a, b, c, d : IN STD_LOGIC ;
 f : OUT STD_LOGIC) ;
END Lab4NOR ;
ARCHITECTURE Behavior OF Lab4NOR IS
BEGIN
f<= NOT (  B OR NOT (A OR NOT(D OR D) ));
END Behavior;