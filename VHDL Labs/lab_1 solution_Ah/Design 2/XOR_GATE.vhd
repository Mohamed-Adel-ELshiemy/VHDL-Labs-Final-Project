library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;


ENTITY XOR_GATE IS 
  PORT( B,M: IN  std_logic ;
        R :  OUT std_logic);
END ENTITY XOR_GATE;


ARCHITECTURE behav OF XOR_GATE IS
BEGIN
  P1: PROCESS (B,M) IS 
  BEGIN
	R <= B XOR M;
  END PROCESS P1;
END ARCHITECTURE behav;