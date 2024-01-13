Library IEEE;
use IEEE.std_logic_1164.all;

entity UnvShiftReg is
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
end entity UnvShiftReg;


architecture bhv of UnvShiftReg is
signal temp : std_logic_vector (inWidth-1 downto 0 );

begin
process(rst,clk)

    begin

    if rst='1' then
    temp <= (others => '0');


    elsif (clk='1' and clk'event) then

        case regMode is
        -- PARALLEL LOAD 
        when "11" =>
        temp <= prlIN;
        
        -- SHIFT LEFT       [0] [0] [0] [0]
        --                  [0] [0] [0] [sLIn]
        when "01" =>
        temp <= prlIN;
        temp(inWidth -1 downto 1) <= temp(inWidth-2 downto 0);
        temp(0) <= sLIn;

        -- SHIFT RIGHT      [0] [0] [0] [0]
        --                [sRIn] [0] [0] [0]
        when "10" => 
        temp <= prlIN;
        temp(inWidth-2 downto 0) <= temp(inWidth-1 downto 1);
        temp(inWidth-1) <= sRIn;

        -- HOLD
        when "00" =>
        temp <= temp;

        when others => temp <= temp;

        end case;
    end if;
end process; 

prlOut <= temp ;


	
end architecture bhv;