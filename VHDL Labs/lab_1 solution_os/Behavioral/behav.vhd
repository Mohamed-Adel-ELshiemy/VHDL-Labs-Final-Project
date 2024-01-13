library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity add_sub_behav is
    Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           M : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(3 downto 0);
           Cout : out  STD_LOGIC);
end entity add_sub_behav;

architecture Behavioral of add_sub_behav is
begin
    process(A, B, M)
        variable temp_result : STD_LOGIC_VECTOR(4 downto 0);
    begin
        if (M = '1') then
            -- Perform binary subtraction: A - B
            temp_result := ('0' & A) + ('0' & (not B)) + "00001";  -- 2's complement of B + 1
        else
            -- Perform binary addition: A + B
            temp_result := ('0' & A) + ('0' & B);
        end if;

        S <= temp_result(3 downto 0);
        Cout <= temp_result(4);  -- Carry-out is the 5th bit of the temporary result
    end process;

end architecture Behavioral;