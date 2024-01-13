-- Structural architecture.
library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;

ENTITY ADDER_SUBTRACTOR IS 
  PORT( A, B:   IN  std_logic_vector (3 DOWNTO 0);
        M :     IN  std_logic;
        S :     OUT std_logic_vector (3 DOWNTO 0);
        Cout :  OUT std_logic );
END ENTITY ADDER_SUBTRACTOR;


ARCHITECTURE struct OF FULL_ADDER IS
	COMPONENT FULL_ADDER IS
		PORT( A, B, Cin: IN  std_logic ;
			  S :      OUT std_logic ;
			  Cout :   OUT std_logic );
	END COMPONENT FULL_ADDER;

	FOR ALL: FULL_ADDER USE ENTITY WORK.FULL_ADDER (behav);
	COMPONENT XOR_GATE IS
		PORT(B,M: IN  std_logic ;
        R :  OUT std_logic);
	END COMPONENT XOR_GATE;
	FOR ALL: XOR_GATE USE ENTITY WORK.XOR_GATE (behav);
	SIGNAL B0: 	std_logic;
	SIGNAL B1: 	std_logic;
	SIGNAL B2: 	std_logic;
	SIGNAL B3: 	std_logic;
	SIGNAL C1:  std_logic;
	SIGNAL C2:  std_logic;
	SIGNAL C3:  std_logic;

BEGIN

	FULL_ADDER0: FULL_ADDER
		PORT MAP (A(0),B0,M,S(0),C1);

	FULL_ADDER1: FULL_ADDER
		PORT MAP (A(1),B1,C1,S(1),C2);

	FULL_ADDER2: FULL_ADDER
		PORT MAP (A(2),B2,C2,S(2),C3);

	FULL_ADDER3: FULL_ADDER
		PORT MAP (A(3),B3,C3,S(3),Cout);

	XOR_GATE0: XOR_GATE
		PORT MAP (B(0),M,B0);
	
	XOR_GATE1: XOR_GATE
	 PORT MAP (B(1),M,B1);
	
	XOR_GATE2: XOR_GATE
	 PORT MAP (B(2),M,B2);
	
	XOR_GATE3: XOR_GATE
	 PORT MAP (B(3),M,B3);


END ARCHITECTURE struct;





