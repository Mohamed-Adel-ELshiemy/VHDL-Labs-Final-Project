---------------------------------------------------------------------
-- A testbench for a D-flip-flop that reads a set of stimuli to a
-- D-flip-flop from a file and writes error messages to another file.
---------------------------------------------------------------------

LIBRARY ieee;
USE std.textio.ALL;
use ieee.std_logic_textio.all;
USE ieee.numeric_bit.ALL;
USE ieee.std_logic_1164.ALL;
uSE WORK.pack_a.ALL;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE test_file OF testbench IS 
  COMPONENT alu IS
    PORT( op: IN op_type;
		 a, b : IN signed (3 DOWNTO 0);
         c : OUT signed (3 DOWNTO 0)); 
  END COMPONENT alu;

  FOR dut: alu USE ENTITY WORK.alu(alu);
  SIGNAL op_in:IN op_type;
  SIGNAL a_in: IN signed (3 DOWNTO 0); 
  SIGNAL b_in: IN signed (3 DOWNTO 0); 
  SIGNAL c_out:OUT signed (3 DOWNTO 0));
BEGIN 
  dut: dec PORT MAP( op_in,a_in, b_in, c_out);

  Pd: PROCESS IS
    FILE vectors_f: text OPEN READ_MODE IS "alu_test_vectors.txt";
    FILE results_f: text OPEN WRITE_MODE IS "alu_test_results.txt";
	
    VARIABLE stimuli_l: line;
    VARIABLE res_l: line;
	
    VARIABLE op_in_file: op_type;
	VARIABLE a_in_file: signed (3 DOWNTO 0);
	VARIABLE b_in_file: signed (3 DOWNTO 0);
	VARIABLE c_out_file: signed (3 DOWNTO 0));
    VARIABLE pause: time;
    --VARIABLE message: string (1 TO 45);
  BEGIN
    a_in <= "0011";
    b_in <= "0011";
	op_in<= mul;
    WAIT FOR 15 ns;
	
    WHILE NOT endfile(vectors_f) LOOP
      READLINE (vectors_f, stimuli_l);
      READ (stimuli_l, op_in_file);
      READ (stimuli_l, a_in_file);
	  READ (stimuli_l, b_in_file);
      READ (stimuli_l, pause);
      READ (stimuli_l, c_out_file);
      --READ (stimuli_l, message);
	  
	  op_in <= op_in_file;
      a_in <= a_in_file;
	  b_in <= b_in_file;           
      WAIT FOR pause;
	  
	  WRITE (res_l, string'("Time is now "));
	  WRITE (res_l, NOW);            -- Curent simulation time
	  
	  WRITE (res_l, string'(". op = ")); 			
	  WRITE (res_l, op_in_file);
	  
	  WRITE (res_l, string'(", a = ")); 
	  WRITE (res_l, a_in_file);
	  
	  WRITE (res_l, string'(", b = ")); 
	  WRITE (res_l, b_in_file);
	  
	  WRITE (res_l, string'(", Expected c = ")); 
	  WRITE (res_l, c_out_file);
	  
	  WRITE (res_l, string'(", Actual Q = ")); 
	  WRITE (res_l, c_out);
	  
	  IF c_out /= c_out_file THEN
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