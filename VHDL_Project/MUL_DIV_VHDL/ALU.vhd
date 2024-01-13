Library IEEE;
use IEEE.std_logic_1164.all;

entity Full_Adder is
   port( X, Y, Cin : in std_logic;
         sum, Cout : out std_logic);
end Full_Adder;
 
architecture bhv of Full_Adder is
begin
   sum <= (X xor Y) xor Cin;
   Cout <= (X and Y) or (X and Cin) or (Cin and Y);
end bhv;

Library IEEE;
use IEEE.std_logic_1164.all;

entity AddSub_CLA is
	generic (
		inWidth : positive := 4
	);
	port (
		in1,in2 : in std_logic_vector ( inWidth-1 downto 0);
		mode : in std_logic ; 	--0 for Addition / 1 for Subtraction
		aluOut : out std_logic_vector (inWidth-1 downto 0);
		crry : out std_logic
	);

end entity AddSub_CLA;

architecture struct of AddSub_CLA is
component Full_Adder is
	port( X, Y, Cin : in std_logic;
         sum, Cout : out std_logic);
end component Full_Adder;

signal in2Xor : std_logic_vector (inWidth -1 downto 0);
signal cgen : std_logic_vector (inWidth downto 0 );
signal p : std_logic_vector (inWidth-1 downto 0 );
signal g : std_logic_vector (inWidth-1 downto 0 );
signal carryX :std_logic_vector (inWidth-1 downto 0 );  --we don't care about its value as we will calculate the carry ahead
signal outWire : std_logic_vector (inWidth-1 downto 0 );


begin
cgen(0) <= mode ;

adders : for n in 0 to inWidth-1 generate
for all : Full_Adder use entity work.Full_Adder(bhv) ;
begin

p(n) <= in1(n) xor in2Xor(n);
g(n) <= in1(n) and in2Xor(n);
cgen(n+1) <= g(n) or (p(n) and cgen(n)); 

in2Xor (n) <= in2(n) xor mode ;


	
	alu : Full_Adder 
	port map (
		in1(n) , in2Xor(n), cgen(n),outWire(n), carryX(n)
	);
	

end generate adders;

crry <= cgen(inWidth);
aluOut <= outWire;

end architecture struct;


