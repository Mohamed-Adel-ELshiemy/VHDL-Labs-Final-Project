library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package componentPackage is

component controller is
	generic (
		countBits : positive := 2
	);
	port (
		clk : in std_logic ;

		MSB :in std_logic ;
		LSB : in std_logic;
		start : in std_logic;
		reg2out : in std_logic_vector((2**countBits-1) downto 0);
		regAccOut :in std_logic_vector((2**countBits-1) downto 0);
		carryIn :in std_logic;
		carryCtrl : out std_logic;
		
		MulorDiv : in std_logic ; --0 mul
								  --1 div

		AddorSub : out std_logic ;--0 add
								  --1 sub
		crtlRegMode : out std_logic_vector (1 downto 0);
		accLoad : out std_logic_vector (1 downto 0);
		slin : out std_logic := '0' ;
		validBit : out std_logic ;
		busyBit : out std_logic
	);

end component controller;

component AddSub_CLA is
	generic (
		inWidth : positive := 4
	);
	port (
		in1,in2 : in std_logic_vector ( inWidth-1 downto 0);
		mode : in std_logic ; 	--0 for Addition / 1 for Subtraction
		aluOut : out std_logic_vector (inWidth-1 downto 0);
		crry : out std_logic
	);
end component AddSub_CLA;

component UnvShiftReg is
	generic (
		inWidth : positive := 4 
	);
	port (
		clk : in std_logic ;
		rst : in std_logic ;
		
		prlIN : in std_logic_vector ( inWidth-1 downto 0);
		prlOut : out std_logic_vector(inWidth-1 downto 0);
		regMode : in std_logic_vector (1 downto 0); -- (11) --> parllel load
											 -- (01) --> shift left
											 -- (10) --> shift Right
											 -- (00) --> hold

		sLIn : in std_logic;
		sRIn : in std_logic
	);
end component UnvShiftReg;

end package componentPackage;

