LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

LIBRARY std;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;


entity NBitMultiplierDivider_tb is
end NBitMultiplierDivider_tb;

architecture behavior of NBitMultiplierDivider_tb is
COMPONENT mult_div
generic (
    N : positive :=4  );
PORT(
   a     : in  std_logic_vector(N-1 downto 0);
    b     : in  std_logic_vector(N-1 downto 0);
    op    : in  std_logic;
    m     : out std_logic_vector(2*N-1 downto N);
    r     : out std_logic_vector(N-1 downto 0);
    error : out std_logic;
    busy  : out std_logic;
    valid : out std_logic
  );
  END COMPONENT mult_div;

   SIGNAL a_tb: std_logic_vector (4-1 DOWNTO 0);
   SIGNAL b_tb: std_logic_vector (4-1 DOWNTO 0);
   SIGNAL op_tb: std_logic;
   SIGNAL m_tb: std_logic_vector(2*4-1 downto 4);
   SIGNAL r_tb: std_logic_vector(4-1 downto 0);
   SIGNAL error_tb: std_logic;
   SIGNAL busy_tb: std_logic;
   SIGNAL valid_tb: std_logic;

  

begin
  uut : entity work.NBitMultiplierDivider(behav)
  port map (
		a => a_tb,
		b => b_tb,
		op => op_tb,
		m=> m_tb,
		error => error_tb,
		busy => busy_tb,
		valid => valid_tb	
		);
	
  
  
 file_process: PROCESS
    FILE vectors_f: TEXT OPEN READ_MODE IS "test_vectors.txt";
    FILE results_f: TEXT OPEN WRITE_MODE IS "out_vectors.txt";
	  
	  variable vector_l, res_l: line;
    variable a_file : std_logic_vector (4-1 DOWNTO 0);
    variable b_file: std_logic_vector (4-1 DOWNTO 0);
    variable op_file: std_logic;
	variable m_file: std_logic_vector(2*4-1 downto 4);
	variable r_file: std_logic_vector(4-1 downto 0);
	variable error_file: std_logic;
	variable  busy_file: std_logic;
	variable valid_file: std_logic;	
    variable pause: time;
	
	 BEGIN
        WHILE NOT endfile (vectors_f) LOOP

            READLINE (vectors_f, vector_l);
            READ (vector_l, a_file);
            READ (vector_l, b_file);
			READ (vector_l, pause);
            READ (vector_l, op_file);
            READ (vector_l, m_file);
			READ (vector_l, r_file);
			READ (vector_l, error_file);
			READ (vector_l, busy_file);
			READ (vector_l, valid_file);
			
            ---------------------operation-----------------------
            	a_tb<=a_file;
		b_tb<=b_file;
		op_tb<=op_file;
		m_tb<=m_file;
		error_tb<=error_file;
		busy_tb<=busy_file;
		valid_tb<=valid_file;
            WAIT FOR pause;
            -----------------------write---------------------
            WRITE (res_l, string'("Time is now "));
            WRITE (res_l, NOW);                                 -- Current simulation time
            WRITE (res_l, string'(" a_file = "));
            WRITE (res_l, a_file);
            WRITE (res_l, string'(" m_file = "));
            WRITE (res_l, m_file);
			WRITE (res_l, string'(" error_file = "));
            WRITE (res_l, error_file);
			WRITE (res_l, string'(" busy_file = "));
            WRITE (res_l, busy_file);
			WRITE (res_l, string'(" valid_file = "));
            WRITE (res_l, valid_file);
			WRITE (res_l, string'(" op_file = "));
            WRITE (res_l, op_file);
			
			
			
			 IF m_tb /= m_file THEN
            WRITE (res_l, string'(". Test failed! "));
            -- WRITE (res_l, message);
            ELSE
            WRITE (res_l, string'(". Test passed."));
            END IF;
            WRITELINE (results_f, res_l);

        END LOOP;
        WAIT;
    END PROCESS;
    
END ARCHITECTURE behavior;