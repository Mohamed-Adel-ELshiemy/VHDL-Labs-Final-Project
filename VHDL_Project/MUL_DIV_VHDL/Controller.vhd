library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	generic (
		countBits : integer := 2
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

end entity controller;

architecture fsm of controller is
type states is (idle,initMul,initDiv,compareMul,compareDiv,add,shiftLm,shiftLr,sub,shiftR);
signal state : states := idle ;
signal counter : unsigned (countBits-1 downto 0);
signal biggerFlag : std_logic;
signal carryFlag : std_logic;




begin
with state select
crtlRegMode <= "11" when initMul| initDiv,
			   "00" when compareMul,
			   "00" when add,
			   "10" when shiftR,
			   "01" when shiftLr,
			   "00" when others;

with state select
accLoad <= "00" when initMul ,
		   "00" when compareMul,
		   "11" when add | sub ,
		   "10" when shiftR ,
		   "01" when shiftLm,
		   "00" when others;
with state select
AddorSub <= '0' when add,
		    '1' when sub,
		    '0' when others;

with state select
busyBit	 <= '0' when idle,
		    '1' when others;
with state select		    
validBit <= '1' when idle,
			'0' when others;


slin <= '1' when biggerFlag = '1' else '0';
carryCtrl <= '1' when carryFlag ='1' else '0' ;

sts : process (clk)
	begin
		if (rising_edge(clk)) then
			case (state) is
				when idle => 
				counter <= to_unsigned(0,countBits);
				biggerFlag <= '0';
				carryFlag<='0';

				if (start = '1') then
					if (MulorDiv = '0') then
						state <= initMul;
					else
						state <= initDiv;
					end if;
				end if;

				when initMul =>
				state <= compareMul;

				when compareMul =>
				carryFlag<='0';
					if (LSB = '1') then	
						state <= add;
					else
						state <= shiftR;
					end if;

				when add => 
				if (carryIn = '1') then
					carryFlag <='1';
				else
					carryFlag<='0';
				end if;
				state <= shiftR;

				when shiftR =>
				counter <= counter + 1 ;

				if (counter = (2**countBits-1)  ) then
					state <= idle;
					--validBit <= '1';
					else
					state <= compareMul;
				end if;

				when initDiv => 
				state <= shiftLm;
				
				when shiftLm =>
					state <= compareDiv;
					biggerFlag <='0';
				when compareDiv =>
				
				if (unsigned(regAccOut) >= unsigned(reg2out) ) then
					state <= sub;
				else
					state <= shiftLr;
				end if;


				when sub =>
				 state <= shiftLr ;
				 biggerFlag <= '1';


				when shiftLr =>
					counter <= counter + 1 ;
					if (counter = 2**countBits -1 ) then
						state <= idle;
					else 
						state <= shiftLm;
					end if;
			end case;
	
		end if;
end process sts;




end architecture fsm;