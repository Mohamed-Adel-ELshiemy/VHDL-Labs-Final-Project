LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_bit.all;
use std.textio.all ;
use ieee.std_logic_textio.all ;
USE WORK.pack_a.ALL;

entity alu_tb is
end entity alu_tb ;

architecture sign_tb of alu_tb is
	component alu is
		port ( op: IN op_type; a, b : IN signed (3 DOWNTO 0); c : OUT signed (3 DOWNTO 0));
	end component alu ;
	
	signal op_tb: op_type ;
	signal a_tb,b_tb,c_tb: signed (3 downto 0) ;
	
	begin
		behav: alu port map(op=>op_tb, a=>a_tb, b=>b_tb, c=>c_tb) ;
		
		prc: process is
			begin
				-- test case 1
				wait for 5 ns ;
				
				a_tb<="0010" ;
				b_tb<="0101" ;
				op_tb<=add ;
				
				wait for 5 ns ;
				
				assert c_tb="0111" 
					report "wrong summation value"
					severity note ;
					
				-- test case 2
					
				a_tb<="0111" ;
				b_tb<="0111" ;
				op_tb<=add ;
				
				wait for 5 ns ;
				
				assert c_tb="1110" ; 
					report "wrong summation value"
					severity note ;

				-- test case 3
					
				a_tb<="0011" ;
				b_tb<="0101" ;
				op_tb<=sub ;
				
				wait for 5 ns ;
				
				assert c_tb="1110" 
					report "wrong summation value"
					severity note ;					
				
				wait ;
				
			end process prc ;
	end architecture sign_tb ;