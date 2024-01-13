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
    N : positive :=4   );
PORT(
   clk : std_logic ;
    rst : std_logic;
   in1     : in  std_logic_vector(N-1 downto 0);
    in2     : in  std_logic_vector(N-1 downto 0);
    modesel    : in  std_logic;
	start: std_logic;

    m     : out std_logic_vector(2*N-1 downto N);
    r     : out std_logic_vector(N-1 downto 0);
    erroB : out std_logic;
    busyB  : out std_logic;
    validB : out std_logic
  );
  END COMPONENT mult_div;
   signal clk_tb : std_logic ;
	signal rst_tb : std_logic;
   SIGNAL in1_tb: std_logic_vector (3 DOWNTO 0);
   SIGNAL in2_tb: std_logic_vector (3 DOWNTO 0);
   SIGNAL modesel_tb: std_logic;
   	signal start_tb: std_logic;

   SIGNAL m_tb: std_logic_vector(2*4-1 downto 4);
   SIGNAL r_tb: std_logic_vector(4-1 downto 0);
   SIGNAL erroB_tb: std_logic;
   SIGNAL busyB_tb: std_logic;
   SIGNAL validB_tb: std_logic;

  

begin
uut : entity work.TopModule(behav)
port map (
               clk => clk_tb,
               rst => rst_tb,
		in1 => in1_tb,
		in2 => in2_tb,
		modesel => modesel_tb,
		start => start_tb,
		m => m_tb,
		r => r_tb,
		erroB => erroB_tb,
		busyB => busyB_tb,
		validB => validB_tb	
		);
	
  
  
 file_process: PROCESS
    FILE vectors_f: TEXT OPEN READ_MODE IS "test_vectors2.txt";
    FILE results_f: TEXT OPEN WRITE_MODE IS "out_vectors2.txt";
	  
	  variable vector_l, res_l: line;
	      variable clk_file: std_logic;
    variable rst_file: std_logic;

    variable in1_file : std_logic_vector (3 DOWNTO 0);
    variable in2_file: std_logic_vector (3 DOWNTO 0);
    variable modesel_file: std_logic;
	variable start_file: std_logic;
	variable m_file: std_logic_vector(2*4 downto 4);
	variable r_file: std_logic_vector(3 downto 0);
	variable erroB_file: std_logic;
	variable  busyB_file: std_logic;
	variable validB_file: std_logic;	
    variable pause: time;
	
	 BEGIN
        WHILE NOT endfile (vectors_f) LOOP

            READLINE (vectors_f, vector_l);
		    READ (vector_l, clk_file);
            READ (vector_l, rst_file);

            READ (vector_l, in1_file);
            READ (vector_l, in2_file);
			READ (vector_l, pause);
            READ (vector_l, modesel_file);
		    READ (vector_l, start_file);
            READ (vector_l, m_file);
			READ (vector_l, r_file);
			READ (vector_l, erroB_file);
			READ (vector_l, busyB_file);
			READ (vector_l, validB_file);
			
            ---------------------operation-----------------------
            		
				in1_tb<=in1_file;
		in2_tb<=in2_file;
		modesel_tb<=modesel_file;
		start_tb <= start_file;
		m_tb<=m_file;
		erroB_tb<=erroB_file;
		busyB_tb<=busyB_file;
		validB_tb<=validB_file;
            WAIT FOR pause;
            -----------------------write---------------------
            WRITE (res_l, string'("Time is now "));
            WRITE (res_l, NOW);                                 -- Current simulation time
            WRITE (res_l, string'(" in1_file = "));
            WRITE (res_l, in1_file);
            WRITE (res_l, string'(" m_file = "));
            WRITE (res_l, m_file);
			WRITE (res_l, string'(" erroB_file = "));
            WRITE (res_l, erroB_file);
			WRITE (res_l, string'(" busyB_file = "));
            WRITE (res_l, busyB_file);
			WRITE (res_l, string'(" validB_file = "));
            WRITE (res_l, validB_file);
			WRITE (res_l, string'(" modesel_file = "));
            WRITE (res_l, modesel_file);
			
			
			
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