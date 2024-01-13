---------------------------------------------------------------------
-- A testbench for a D-flip-flop that reads a set of stimuli to a
-- D-flip-flop from a file and writes error messages to another file.
---------------------------------------------------------------------
LIBRARY ieee;
USE std.textio.ALL;
use ieee.std_logic_textio.all;
USE ieee.numeric_bit.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE test_file OF testbench IS 
  COMPONENT dec IS
    PORT( a: IN std_logic_vector (2 DOWNTO 0);
		 en: IN bit;	
          y: OUT std_logic_vector (5 DOWNTO 0));
  END COMPONENT dec;

  FOR dut: dec USE ENTITY WORK.dec(design);
  SIGNAL a_in: std_logic_vector (2 DOWNTO 0);
  SIGNAL EN: bit;
  SIGNAL y_out: std_logic_vector (5 DOWNTO 0);
BEGIN 
  dut: dec PORT MAP( a_in, EN, y_out);

  Pd: PROCESS IS
    FILE vectors_f: text OPEN READ_MODE IS "dec_test_vectors.txt";
    FILE results_f: text OPEN WRITE_MODE IS "dec_test_results.txt";
	
    VARIABLE stimuli_l: line;
    VARIABLE res_l: line;
	
    VARIABLE a_in_file: std_logic_vector (2 DOWNTO 0);
	VARIABLE EN_in_file: bit;
	VARIABLE y_out_file: std_logic_vector (5 DOWNTO 0);
    VARIABLE pause: time;
    --VARIABLE message: string (1 TO 45);
  BEGIN
    a_in <= "010";
    EN <= '0';
    WAIT FOR 15 ns;
	
    WHILE NOT endfile(vectors_f) LOOP
      READLINE (vectors_f, stimuli_l);
      READ (stimuli_l, a_in_file);
      READ (stimuli_l, EN_in_file);
      READ (stimuli_l, pause);
      READ (stimuli_l, y_out_file);
      --READ (stimuli_l, message);
	  
      a_in <= a_in_file;            
      EN <= EN_in_file;           
      WAIT FOR pause;
	  
	  WRITE (res_l, string'("Time is now "));
	  WRITE (res_l, NOW);            -- Curent simulation time
	  
	  WRITE (res_l, string'(". a = ")); 			
	  WRITE (res_l, a_in_file);
	  
	  WRITE (res_l, string'(", EN = ")); 
	  WRITE (res_l, EN_in_file);
	  
	  WRITE (res_l, string'(", Expected y = ")); 
	  WRITE (res_l, y_out_file);
	  
	  WRITE (res_l, string'(", Actual Q = ")); 
	  WRITE (res_l, y_out);
	  
	  IF y_out /= y_out_file THEN
          WRITE (res_l, string'(". Test failed! Error message:"));
          --WRITE (res_l, message);
	  ELSE
          WRITE (res_l, string'(". Test passed."));
	  END IF;
	
	  WRITELINE (results_f, res_l);     
    END LOOP;
    WAIT;                             -- stop simulation run
  END PROCESS Pd;
END ARCHITECTURE test_file;