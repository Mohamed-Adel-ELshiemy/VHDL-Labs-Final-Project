---------------------------------------------------------------------------------------
-- Entity and architecture declarations for an address decoder using a CASE statement.
---------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

package test_comparator is
    component comparator is
        Port( a : IN  std_logic_vector (7 DOWNTO 0);
         b: IN std_logic_vector (7 DOWNTO 0);
         equal_out : OUT std_logic;
         not_equal_out: OUT std_logic); 
    end component comparator;
end package;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use work.test_comparator.all;

ENTITY comparator_tb IS 
END ENTITY comparator_tb;

ARCHITECTURE testbench OF comparator_tb IS 
  signal a_tb            : std_logic_vector (7 DOWNTO 0);
  signal b_tb            : std_logic_vector (7 DOWNTO 0);
  signal equal_out_tb    : std_logic;
  signal not_equal_out_tb: std_logic;
BEGIN 
  -- DUT instantiation
  DUT: comparator port map (
    a => a_tb,
    b => b_tb,
    equal_out => equal_out_tb,
    not_equal_out => not_equal_out_tb
  );
  test: PROCESS IS 
  BEGIN 
    -- initialize the input
    -- Test Case 1
    a_tb  <= "00000101";
    b_tb  <= "00000100";
    wait for 1 ns;
    assert (equal_out_tb = '0' and not_equal_out = '1') report "Test Case 1 failed" severity note;

    -- Test Case 2
    a_tb  <= "00001010";
    b_tb  <= "00001010";
    wait for 1 ns;
    assert (equal_out_tb = '1' and not_equal_out = '0') report "Test Case 2 failed" severity note;

    -- Test Case 3
    a_tb  <= "00001110";
    b_tb  <= "00001111";
    wait for 1 ns;
    assert (equal_out_tb = '0' and not_equal_out = '1') report "Test Case 3 failed" severity note;

    wait;

  END PROCESS test;
END ARCHITECTURE testbench;