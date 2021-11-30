library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity four_shiftreg is
    port (
        CLK, CLR, RIN, LIN: in STD_LOGIC; 
        S: in STD_LOGIC_VECTOR (1 downto 0); -- function select
        D: in STD_LOGIC_VECTOR (3 downto 0); -- data in
        Q: out STD_LOGIC_VECTOR (3 downto 0) -- data out
    );
end four_shiftreg;

architecture Vshftreg_arch of four_shiftreg is

signal IQ: STD_LOGIC_VECTOR (3 downto 0);

begin
process (CLK, CLR, IQ)
  begin
    if (CLR='1') then IQ <= (others=>'0');   --- clear
   elsif (CLK'event and CLK='1') then

      case S is  -- see the abovementioned function

 -- If you don’t convert to integer,
-- you can use when “000” and &…

        when "00" => null;                         -- Hold
        when "11" => IQ <= D;                      -- Load
        when "01" => IQ <= RIN & IQ(3 downto 1);   -- Shift right
        when "10" => IQ <= IQ(2 downto 0) & LIN;   -- Shift left
        when others => null;
      end case;
    end if;

    Q <= IQ;             -- Because IQ is internal signal, it can appear on both sides.

  end process;
end architecture;
