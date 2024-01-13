-------------------------------------------------
-- Synthesis of a 3-to-6 decoder with an enable.
-------------------------------------------------

LIBRARY ieee;
USE ieee.numeric_bit.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY dec IS
  PORT( a: IN std_logic_vector (2 DOWNTO 0);
        en: IN bit;
        y: OUT std_logic_vector (5 DOWNTO 0)); 
END ENTITY dec;

ARCHITECTURE design OF dec IS
BEGIN 
  pd: PROCESS (a, en) IS
  BEGIN 
    IF en = '0' THEN
      y <= o"00";
    ELSE 
      CASE a IS
        WHEN "000" => y <= o"01"; 
        WHEN "001" => y <= o"02"; 
        WHEN "010" => y <= o"04"; 
        WHEN "011" => y <= o"10"; 
        WHEN "100" => y <= o"20"; 
        WHEN "101" => y <= o"40"; 
        WHEN OTHERS => y <= o"00"; 
        END CASE;
      END IF;
    END PROCESS pd;
END ARCHITECTURE design;
