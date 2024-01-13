----------------------------------------------------------
--multiplier
----------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;
USE ieee.numeric_bit.ALL;

entity mul is
generic (N: positive :=8)
port(A,B    : IN bit_vector(N-1 DOWNTO 0);
	 result : OUT bit_vector(2*N-1 DOWNTO 0));
end entity mul ;

