library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;


ENTITY FULL_ADDER IS 
  PORT( A, B, Cin:   IN  std_logic ;
        S :     OUT std_logic ;
        Cout :  OUT std_logic );
END ENTITY FULL_ADDER;


ARCHITECTURE behav OF FULL_ADDER IS
BEGIN
  P1: PROCESS (A,B,Cin) IS 
  VARIABLE x: std_logic;
  VARIABLE y: std_logic;
  VARIABLE z: std_logic;
  BEGIN
	x := A XOR B;
	S <= x XOR Cin;
	y := A AND Cin;
	z := A AND B;
	Cout <= y OR z;
  END PROCESS P1;
END ARCHITECTURE behav;