-- behavioral architecture.
library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY ADDER_SUBTRACTOR IS 
  PORT( A, B:   IN  std_logic_vector (3 DOWNTO 0);
        M :     IN  std_logic;
        S :     OUT std_logic_vector (3 DOWNTO 0);
        Cout :  OUT std_logic );
END ENTITY ADDER_SUBTRACTOR;


ARCHITECTURE behav OF ADDER_SUBTRACTOR IS
BEGIN
  P1: PROCESS (A,B,M) IS 
  VARIABLE temp: std_logic_vector (4 Downto 0);
  BEGIN
    if  M = '0'   THEN    temp := ("0" & A) + ("0" & B);
    else                  temp := ("0" & A) - ("0" & B);
    END IF;
    S <= temp(3 Downto 0); 
    Cout <= temp(4);
  END PROCESS P1;
END ARCHITECTURE behav;
     
      
      
      
      
      
      
      
      
      
      
      