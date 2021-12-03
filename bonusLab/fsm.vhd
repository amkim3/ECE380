LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY FSM IS
	PORT (	start, clock, resetSM 	: IN 	STD_LOGIC ;
				control				: OUT 	STD_LOGIC_VECTOR(3 downto 0) ) ;
END FSM ;

ARCHITECTURE Behavior OF FSM IS
	TYPE State_type IS (Idle, Reset, Load, S1,S2,S3,S4, Ready);
	SIGNAL y : State_type ;
BEGIN
	PROCESS ( ResetSM, Clock )
	BEGIN
		IF ResetSM = '1' THEN
			y <= Idle;
		ELSIF (Clock'EVENT AND Clock = '1') THEN	
			CASE y IS
				WHEN Idle =>
					IF start = '0' THEN
						y <= Idle ;
					ELSE
						y <= Reset ;
					END IF ;
				WHEN Reset =>
					IF start = '0' THEN
						y <= Reset;
					ELSE
						y <= Load ;
					END IF ;
				WHEN Load =>
					IF start = '0' THEN
						y <= Load ;
					ELSE
						y <= S1 ;
					END IF ;
				WHEN S1 =>
					IF start = '0' THEN
						y <= S1 ;
					ELSE
						y <= S2 ;
					END IF ;
				WHEN S2 =>
					IF start = '0' THEN
						y <= S2 ;
					ELSE
						y <= S3 ;
					END IF ;
				WHEN S3 =>
					IF start = '0' THEN
						y <= S3 ;
					ELSE
						y <= S4 ;
					END IF ;
				WHEN S4 =>
					IF start = '0' THEN
						y <= S4 ;
					ELSE
						y <= Ready ;
					END IF ;
				WHEN Ready =>
					IF start = '0' THEn
						y<= Ready;
					ELSE
						y<=Idle;
					end if;
			END CASE ;
		END IF ;
	END PROCESS ;
-- z <= '1' WHEN y = Ready ELSE '0' ;
	PROCESS (y)
	BEGIN
		CASE y is
			WHEN Idle =>
				control <= "0000";
			WHEN Reset =>
				control <= "0100";
			WHEN Load =>
				control <= "0011";
			WHEN S1 =>
				control <= "0001";
			WHEN S2 =>
				control <= "0001";
			WHEN S3 =>
				control <= "0001";
			WHEN S4 =>
				control <= "0001";
			WHEN Ready =>
				control <= "1000";
		END CASE;
	end PRocess;
			
	
END Behavior ;