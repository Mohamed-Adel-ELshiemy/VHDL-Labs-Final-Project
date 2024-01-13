-- dataflow architecture.
library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY ADDER_SUBTRACTOR IS
PORT( A, B:  IN  STD_LOGIC_vector (3 DOWNTO 0);
	  M :      IN  STD_LOGIC;	
	  S :      OUT STD_LOGIC_vector (3 DOWNTO 0);
	  Cout :   OUT STD_LOGIC);
END ENTITY ADDER_SUBTRACTOR;

ARCHITECTURE dataflow OF ADDER_SUBTRACTOR IS
  SIGNAL R: STD_LOGIC_vector (4 DOWNTO 0);
  BEGIN
    R <= ("0" & A) + ("0" & B) WHEN M = '0' ELSE
           ("0" & A) - ("0" & B);
    S <= R(3 DOWNTO 0);
    Cout <= R(4);


END ARCHITECTURE dataflow;