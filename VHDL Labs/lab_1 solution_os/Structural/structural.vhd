library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity add_sub_struct is
    Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           M : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(3 downto 0);
           Cout : out  STD_LOGIC);
end entity add_sub_struct;

architecture structural of add_sub_struct is

-- 4-bit adder/subtractor
    signal temp_result : STD_LOGIC_VECTOR(4 downto 0);
    
    -- Full Adder component
    component full_adder
        Port ( a, b, cin : in STD_LOGIC;
               sum, cout : out STD_LOGIC);
    end component;

	FOR ALL: full_adder USE ENTITY WORK.full_adder(fa_arc);

    begin
        -- Wiring the Full Adder components to create the 4-bit adder/subtractor
        FA0: full_adder port map(A(0), B(0), 	'0'		   , S(0), temp_result(0));
        FA1: full_adder port map(A(1), B(1), temp_result(0), S(1), temp_result(1));
        FA2: full_adder port map(A(2), B(2), temp_result(1), S(2), temp_result(2));
        FA3: full_adder port map(A(3), B(3), temp_result(2), S(3), Cout );

--        S <= temp_result(3 downto 0);  -- The 4-bit result
--        Cout <= temp_result(4);        -- Carry-out is the 5th bit of the temporary result

if (M = '1') then
            -- Perform binary subtraction: A - B
            S <= (A) + (not B) + "00001";  -- 2's complement of B + 1
        else
			S <= temp_result(3 downto 0);  -- The 4-bit result
			Cout <= temp_result(4);        -- Carry-out is the 5th bit of the temporary result


end architecture structural;