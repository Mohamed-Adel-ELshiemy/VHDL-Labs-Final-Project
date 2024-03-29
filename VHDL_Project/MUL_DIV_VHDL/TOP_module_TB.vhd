library ieee;
library work;
USE std.textio.ALL;
use ieee.std_logic_1164.all;

ENTITY DIV_MUL_TOP_TB IS
END DIV_MUL_TOP_TB;

ARCHITECTURE TESTBENCH OF DIV_MUL_TOP_TB IS

  -- Instantiate the DIV_MUL_TOP entity
  COMPONENT topmodule IS
        GENERIC (N: INTEGER);
        PORT    (   CLK:            IN  STD_LOGIC;
                    RST:            IN  STD_LOGIC;
                    MODE:           IN  STD_LOGIC;
                    A:              IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;
                    B:              IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;        
                    M:              OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;
                    R:              OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;
                  start :in std_logic;
                    BUSY:           OUT STD_LOGIC;
                    VALID:          OUT STD_LOGIC;
                    ERROR:     OUT STD_LOGIC                       
                  );
    END COMPONENT   topmodule;

    CONSTANT        N :      INTEGER :=  4;
    CONSTANT        CLK_PERIOD:         TIME :=  20 nS;
    SIGNAL          CLK_TB:             STD_LOGIC;
    SIGNAL          RST_TB:             STD_LOGIC;
    SIGNAL          MODE_TB:            STD_LOGIC;
    SIGNAL          BUSY_TB:            STD_LOGIC;
    SIGNAL          start_TB:            STD_LOGIC;
    SIGNAL          VALID_TB:           STD_LOGIC;
    SIGNAL          ERROR_FLAG_TB:      STD_LOGIC;
    SIGNAL          A_TB:               STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;
    SIGNAL          B_TB:               STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;        
    SIGNAL          M_TB:               STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;
    SIGNAL          R_TB:               STD_LOGIC_VECTOR (N-1 DOWNTO 0) ;
    
    BEGIN

  -- Clock process
  CLK_GEN: PROCESS IS
  BEGIN
  CLK_TB <= '0';
  WAIT FOR (CLK_PERIOD/2);
  CLK_TB <= '1';
  WAIT FOR (CLK_PERIOD/2);
  END PROCESS CLK_GEN;

  -- Instantiate the DIV_MUL_TOP entity
  uut : topmodule 
            GENERIC MAP (N => N)
            PORT MAP (  CLK         =>   CLK_TB,   
                        RST         =>   RST_TB,    
                        MODE       =>    MODE_TB,
                        start       =>    start_TB,
                        A           =>   A_TB, 
                        B           =>   B_TB, 
                        M           =>   M_TB, 
                        R           =>   R_TB, 
                        BUSY        =>   BUSY_TB,
                        VALID       =>   VALID_TB,       
                        ERROR  =>   ERROR_FLAG_TB     
                      );


    -- Stimulus process
    PTB: PROCESS IS

    FILE vectors_f: text OPEN READ_MODE IS "C:\Users\compuremo\Downloads\Task1\Task1\test_vectors.txt";
    FILE results_f: text OPEN WRITE_MODE IS "C:\Users\compuremo\Downloads\Task1\Task1\write_file.txt";
    VARIABLE stimuli_l: LINE;
    VARIABLE res_l    : LINE;
    VARIABLE OP_A     : STD_LOGIC_VECTOR (N-1 DOWNTO 0);
    VARIABLE OP_B     : STD_LOGIC_VECTOR (N-1 DOWNTO 0);
    VARIABLE S        : STD_LOGIC;
 VARIABLE Start        : STD_LOGIC;
    VARIABLE PAUSE    : TIME;
    VARIABLE OUT_M    : STD_LOGIC_VECTOR (N-1 DOWNTO 0);
    VARIABLE OUT_R    : STD_LOGIC_VECTOR (N-1 DOWNTO 0);

    PROCEDURE   INITIALIZATION  IS
    BEGIN
        A_TB <= (OTHERS => '0');
        B_TB <= (OTHERS => '0');
        MODE_TB <= '0';
    END PROCEDURE INITIALIZATION;

    PROCEDURE   RESET   IS
        BEGIN
        RST_TB <= '0';
        WAIT FOR CLK_PERIOD;
        RST_TB <= '1';
    END PROCEDURE RESET;


    PROCEDURE   COMB_TB   IS
        BEGIN
        WHILE NOT endfile(vectors_f) LOOP
      READLINE (vectors_f, stimuli_l);
      READ (stimuli_l, OP_A);
      READ (stimuli_l, OP_B);
      READ (stimuli_l, S);
 READ (stimuli_l, Start);
      READ (stimuli_l, PAUSE);
      READ (stimuli_l, OUT_M);
      READ (stimuli_l, OUT_R);

      A_TB <= OP_A;
      B_TB <= OP_B;
      MODE_TB <= S; 
start_TB <= start;           
      WAIT FOR CLK_PERIOD;

	  WRITE (res_l, string'("Time is now "));
	  WRITE (res_l, NOW);            -- Curent simulation time
	  
	  WRITE (res_l, string'(". A = ")); 			
	  WRITE (res_l, OP_A);
    WRITE (res_l, string'(", B = ")); 			
	  WRITE (res_l, OP_B);

	  WRITE (res_l, string'(", M = ")); 
	  WRITE (res_l, S);
	  
 WRITE (res_l, string'(", start = ")); 
	  WRITE (res_l, Start);
	  WRITE (res_l, string'(", Expected M OUTPUT = ")); 
	  WRITE (res_l, OUT_M);

    WRITE (res_l, string'(", Expected R OUTPUT = ")); 
	  WRITE (res_l, OUT_R);

	  
	  WRITE (res_l, string'(", Actual M  = ")); 
	  WRITE (res_l, M_TB);
	  
    WRITE (res_l, string'(", Actual R = ")); 
	  WRITE (res_l, R_TB);
     
	  IF ((M_TB /= OUT_M) or (R_TB /= OUT_R)) THEN -- check the actual value = the expected value or not
      WRITE (res_l, string'(". Test failed!"));
    
      ELSE
      WRITE (res_l, string'(". Test passed."));
      END IF;
	
	  WRITELINE (results_f, res_l);     
    END LOOP;
    END PROCEDURE COMB_TB;

    PROCEDURE   SEQ_TB   IS
        BEGIN

      WHILE NOT endfile(vectors_f) LOOP
      READLINE (vectors_f, stimuli_l);
      READ (stimuli_l, OP_A);
      READ (stimuli_l, OP_B);
      READ (stimuli_l, S);
READ (stimuli_l, Start);
      READ (stimuli_l, PAUSE);
      READ (stimuli_l, OUT_M);
      READ (stimuli_l, OUT_R);

   --   WAIT FOR (N+1)*CLK_PERIOD;
      
    WAIT FOR PAUSE;
      A_TB <= OP_A;
      B_TB <= OP_B;
      MODE_TB <= S;
     start_TB <= start;
    --  WAIT FOR (N)*CLK_PERIOD;
    WAIT FOR (N+1)*CLK_PERIOD;
	  WRITE (res_l, string'("Time is now "));
	  WRITE (res_l, NOW);            -- Curent simulation time
	  
	  WRITE (res_l, string'(". A = ")); 			
	  WRITE (res_l, OP_A);
    WRITE (res_l, string'(", B = ")); 			
	  WRITE (res_l, OP_B);

	  WRITE (res_l, string'(", M = ")); 
	  WRITE (res_l, S);
	   WRITE (res_l, string'(", start = ")); 
	  WRITE (res_l, Start);
	  WRITE (res_l, string'(", Expected M OUTPUT = ")); 
	  WRITE (res_l, OUT_M);

    WRITE (res_l, string'(", Expected R OUTPUT = ")); 
	  WRITE (res_l, OUT_R);

	  
	  WRITE (res_l, string'(", Actual M  = ")); 
	  WRITE (res_l, M_TB);
	  
    WRITE (res_l, string'(", Actual R = ")); 
	  WRITE (res_l, R_TB);
     
	  IF ((M_TB /= OUT_M) or (R_TB /= OUT_R)) THEN -- check the actual value = the expected value or not
      WRITE (res_l, string'(". Test failed!"));
    
      ELSE
      WRITE (res_l, string'(". Test passed."));
      END IF;
	
	  WRITELINE (results_f, res_l);     
    END LOOP;
    END PROCEDURE SEQ_TB;

    BEGIN
   -- INITIALIZATION;
    RESET;
  --  COMB_TB;
    SEQ_TB;
    
    
    WAIT;   
        END PROCESS PTB;
    END ARCHITECTURE ;

    CONFIGURATION TopModule OF DIV_MUL_TOP_TB IS
      FOR TESTBENCH
        FOR uut : TopModule
        USE ENTITY work.TopModule(SEQUENTIAL);
        END FOR;
      END FOR;
    END TopModule;