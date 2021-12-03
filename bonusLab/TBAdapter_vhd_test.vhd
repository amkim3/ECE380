LIBRARY ieee;
USE ieee.std_logic_1164 .all;
ENTITY TBAdapter_vhd_tst IS
END TBAdapter_vhd_tst ;
ARCHITECTURE TBAdapter_arch OF TBAdapter_vhd_tst IS
	-- constants
	-- signals
	SIGNAL carry_T : STD_LOGIC;
	SIGNAL clock_T : STD_LOGIC := '0';
	SIGNAL in_a_T : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL in_b_T : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL reset_T : STD_LOGIC;
	SIGNAL start_T : STD_LOGIC;
	SIGNAL Sum_T : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL ready_T : STD_LOGIC;
	COMPONENT TBAdapter
		PORT (
		carry : OUT STD_LOGIC;
		clock : IN STD_LOGIC;
		in_a : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		in_b : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		reset_SM : IN STD_LOGIC;
		start : IN STD_LOGIC;
		Sum : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		Sum_ready : OUT STD_LOGIC
		);
	END COMPONENT;
	function chr(sl: std_logic) return character is
		variable c: character;
		begin
			case sl is
				when 'U' => c:= 'U';
				when 'X' => c:= 'X';
				when '0' => c:= '0';
				when '1' => c:= '1';
				when 'Z' => c:= 'Z';
				when 'W' => c:= 'W';
				when 'L' => c:= 'L';
				when 'H' => c:= 'H';
				when '-' => c:= '-';
			end case;
		return c;
	end chr;

	function hstr(slv: std_logic_vector ) return string is
		variable hexlen: integer;
		variable longslv : std_logic_vector (67 downto 0) := (others => '0');
		variable hex : string(1 to 16);
		variable fourbit : std_logic_vector (3 downto 0);
		begin
			hexlen := (slv'left+1)/4;
			if (slv'left+1) mod 4 /= 0 then
				hexlen := hexlen + 1;
			end if;
			longslv(slv'left downto 0) := slv;
			for i in (hexlen -1) downto 0 loop
				fourbit := longslv(((i*4)+3) downto (i*4));
				case fourbit is
					when "0000" => hex(hexlen -I) := '0';
					when "0001" => hex(hexlen -I) := '1';
					when "0010" => hex(hexlen -I) := '2';
					when "0011" => hex(hexlen -I) := '3';
					when "0100" => hex(hexlen -I) := '4';
					when "0101" => hex(hexlen -I) := '5';
					when "0110" => hex(hexlen -I) := '6';
					when "0111" => hex(hexlen -I) := '7';
					when "1000" => hex(hexlen -I) := '8';
					when "1001" => hex(hexlen -I) := '9';
					when "1010" => hex(hexlen -I) := 'A';
					when "1011" => hex(hexlen -I) := 'B';
					when "1100" => hex(hexlen -I) := 'C';
					when "1101" => hex(hexlen -I) := 'D';
					when "1110" => hex(hexlen -I) := 'E';
					when "1111" => hex(hexlen -I) := 'F';
					when "ZZZZ" => hex(hexlen -I) := 'z';
					when "UUUU" => hex(hexlen -I) := 'u';
					when "XXXX" => hex(hexlen -I) := 'x';
					when others => hex(hexlen -I) := '?';
				 end case;
			 end loop;
		return hex(1 to hexlen);
	end hstr;
	 function str(sl: std_logic) return string is
		 variable s: string(1 to 1);
		begin
			s(1) := chr(sl);
			return s;
	 end str;
	type test_record is record
		a : std_logic_vector (3 downto 0);
		b : std_logic_vector (3 downto 0);
		sum : std_logic_vector (3 downto 0);
		cout : std_logic;
	end record;

 type test_array is array(positive range <>) of test_record ;

 -- 1-D array; the type of the array is ‘record’;

	 constant ctest_record_array : test_array := (
	 (a => "0000", b => "0100", sum => "0100", cout => '0'),
	 (a => "1100", b => "1110", sum => "1010", cout => '1'),
	 (a => "1000", b => "1010", sum => "0010", cout => '1'),
	 (a => "1111", b => "1111", sum => "1110", cout => '1'),
	 (a => "1111", b => "0001", sum => "0000", cout => '1'),
	 (a => "1010", b => "0101", sum => "0010", cout => '0'),
	 (a => "1000", b => "0111", sum => "1111", cout => '0'));

	BEGIN
		i1 : TBAdapter
		 PORT MAP (
		 -- list connections between master ports and signals
		 carry => carry_T,
		 clock => clock_T,
		 in_a => in_a_T,
		 in_b => in_b_T,
		 reset_SM => reset_T,
		 start => start_T,
		Sum => Sum_T,
		Sum_ready => ready_T
		 );

		clock_T <= not clock_T after 50 ns;
		init : PROCESS
			 -- variable declarations
			 BEGIN -- code that
			 WAIT;
		 END PROCESS init;
		 always : PROCESS
			 -- optional sensitivity list
			 -- ( )
			 -- variable declarations
			variable vtest_record : test_record ;
			variable errors: boolean := FALSE;
			begin

				for i in ctest_record_array ' range loop

				vtest_record := ctest_record_array (i);
				in_a_T <= vtest_record .a;
				in_b_T <= vtest_record .b;

				reset_T <= '0';
				start_T <= '0';

				wait until (clock_T'event and clock_T ='0');
				reset_T <= '1';
				start_T <= '1';

				wait until ( ready_T ='1' and ready_T'last_value ='0'); -- means 01

				report "run " & integer'image(i);
				report "Serial Adder result is ready" ;

				report hstr(in_a_T) & " + " & hstr(in_b_T) & " = " & hstr(Sum_T);
				report "carry is " & str(carry_T);


				if Sum_T /= vtest_record .sum then
				assert false
				report " sum incorrect " ;
				report "sum should be " & hstr(vtest_record .sum);
				errors := true;
				end if;

				if carry_T /= vtest_record .cout then
				assert false
				report " carry incorrect " ;
				report "carry should be " & str(vtest_record .cout);
				errors := true;
				end if;

				end loop;
	-- code executes for every event on sensitivity list
		END PROCESS always;
	END TBAdapter_arch ;
