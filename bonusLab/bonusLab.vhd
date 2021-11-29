library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder IS
	port(in_a, in_b : in std_logic_vector(3 downto 0);
		  control    : in std_logic;
		  clk        : in std_logic;
		  reset_al   : in std_logic;
		  sum        : out std_logic(3 downto 0);
		  carry      : out std_logic);
end four_bit_adder;

architecture four_bit_adder_arch of four_bit_adder is
	component full_adder is
		 port(A    : in std_logic;
				B    : in std_logic;
				Cin  : in std_logic;
				S  : in std_logic;
				Cout : in std_logic);
	end component full_adder;

	component dff is
		port(D, Clk, En, Reset: in std_logic;
			  Q, Qbar    : out std_logic);
	end component dff;
	
	component four_shiftreg is
		port (
			  CLK, CLR, RIN, LIN, Reset: in STD_LOGIC; 
			  S: in STD_LOGIC_VECTOR (1 downto 0); -- function select
			  D: in STD_LOGIC_VECTOR (3 downto 0); -- data in
			  Q: out STD_LOGIC_VECTOR (3 downto 0) -- data out
		 );
	end component;
	
	component w_and is
		port(
			active_high, active_low : IN STD_LOGIC;
			S : OUT STD_LOGIC);
	end component;
	signal internal_s : std_logic;
begin
	-- stuf here
	Asr : four_shiftreg port map (clk, reset_al, internal_s
end architecture;