library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;


ENTITY adder_Subtractor_tb IS
END ENTITY adder_Subtractor_tb;

ARCHITECTURE testbench OF adder_Subtractor_tb IS

   COMPONENT ADDER_SUBTRACTOR
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         M : IN  std_logic;
         S : OUT  std_logic_vector(3 downto 0);
         Cout : OUT  std_logic
        );
    END COMPONENT;


  SIGNAL  M: std_logic;
  SIGNAL  A: std_logic_vector (3 Downto 0);
  SIGNAL  B: std_logic_vector (3 Downto 0);
  SIGNAL  S: std_logic_vector  (3 Downto 0);
  SIGNAL  Cout:std_logic;
  
  BEGIN
    dut: adder_Subtractor PORT MAP ( A => A,B => B, M => M, S => S, Cout => Cout);
     test_cases: PROCESS IS BEGIN
     
      A <= "0000";
      B <= "0000";
      M <= '0';                    
      WAIT FOR 10 ns;
      ASSERT S = "0000" AND  Cout = '0'
      REPORT "Not Passed."
      SEVERITY error;
     
      A <= "0001";
      B <= "0001";
      M <= '0';                  
      WAIT FOR 10 ns;
      ASSERT S = "0010" AND  Cout = '0'
      REPORT "Not Passed."
      SEVERITY error;
      
      A <= "0010";
      B <= "0010";
      M <= '0';                  
      WAIT FOR 10 ns;
      ASSERT S = "0100" AND  Cout = '0'
      REPORT "Not Passed."
      SEVERITY error;
      
      A <= "0011";
      B <= "0011";
      M <= '0';                  
      WAIT FOR 10 ns;
      ASSERT S = "0110" AND  Cout = '0'
      REPORT "Not Passed."
      SEVERITY error;
      
      A <= "0100";
      B <= "0100";
      M <= '0';                  
      WAIT FOR 10 ns;
      ASSERT S = "1000" AND  Cout = '0'
      REPORT "Not Passed."
      SEVERITY error;
      
      
      A <= "0101";
      B <= "0101";
      M <= '0';                  
      WAIT FOR 10 ns;
      ASSERT S = "1010" AND  Cout = '0'
      REPORT "Not Passed."
      SEVERITY error;
      
      -------------------- Test in error case -------------------------------------
      A <= "0110";
      B <= "0110";
      M <= '0';                  
      WAIT FOR 10 ns;
      ASSERT S = "1110" AND  Cout = '1'
      REPORT "Not Passed"
      SEVERITY error;
      
      A <= "1000";
      B <= "1000";
      M <= '0';                  
      WAIT FOR 10 ns;
      ASSERT S = "0010" AND  Cout = '0'
      REPORT "Not Passed"
      SEVERITY error;
      -------------------------------------------------------------------------------
       
      
      
      
      
    WAIT;
    END PROCESS test_cases;
END ARCHITECTURE testbench;





















