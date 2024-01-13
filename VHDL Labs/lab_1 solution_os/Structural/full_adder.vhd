library IEEE;
LIBRARY std;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_bit.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity full_adder is
    port (a : in STD_LOGIC;
          b : in STD_LOGIC;
          cin : in STD_LOGIC;
          sum : out STD_LOGIC;
          cout : out STD_LOGIC
          );
end full_adder;

architecture fa_arc of full_adder is
begin
   
    sum <= a xor b xor cin;
    cout <= (a and b) or (b and cin) or (cin and a);
   
end fa_arc;