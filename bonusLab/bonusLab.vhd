library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder IS
	port(in_a, in_b : in std_logic_vector(3 downto 0);
		  control    : in std_logic_vector (1 downto 0);
		  clk        : in std_logic;
		  reset_al   : in std_logic;
		  sum        : out std_logic_vector(3 downto 0);
		  carry      : out std_logic);
end four_bit_adder;

architecture four_bit_adder_arch of four_bit_adder is
	component full_adder is
		 port(A    : in std_logic;
				B    : in std_logic;
				Cin  : in std_logic;
				S  : out std_logic;
				Cout : out std_logic);
	end component full_adder;

	component dflipflop is
		port(D, Clk, En, Reset: in std_logic;
			  Q, Qbar    : out std_logic);
	end component dflipflop;
	
	component four_shiftreg is
		port (
			  CLK, CLR, RIN, LIN: in STD_LOGIC; 
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
	signal fa_cout : std_logic;
	signal fa_cin : std_logic;
	signal internal_signal_rin : std_logic;
	signal internal_signal_b : std_logic_vector (3 downto 0);
	signal internal_enable : std_logic;
	signal internal_signal_sum : std_logic_vector (3 downto 0);
	
begin
	-- stuf here
	-- sum being here and not internal may be a problem idk
	Asr : four_shiftreg port map (clk, reset_al, internal_signal_rin, '0', control, in_a, internal_signal_sum);
	Bsr : four_shiftreg port map (clk, reset_al, '0','0',control, in_b, internal_signal_b);
	Fa_clock : w_and port map (clk, control(1), internal_enable);
	Fa_dff : dflipflop port map(fa_cout,clk,internal_enable,reset_al,fa_cin,open);
	adder : full_adder port map(internal_signal_sum(0),internal_signal_b(0),fa_cin,internal_signal_rin,fa_cout);
	sum <= internal_signal_sum;
end architecture;