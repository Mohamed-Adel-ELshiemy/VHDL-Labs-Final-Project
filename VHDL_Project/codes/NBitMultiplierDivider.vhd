
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NBitMultiplierDivider is
  generic (
    N : positive := 8
  );
  port (
    a     : in  std_logic_vector(N-1 downto 0);
    b     : in  std_logic_vector(N-1 downto 0);
    op    : in  std_logic;
    m     : out std_logic_vector(2*N-1 downto N);
    r     : out std_logic_vector(N-1 downto 0);
    error : out std_logic;
    busy  : out std_logic;
    valid : out std_logic
  );
end entity NBitMultiplierDivider;

architecture rtl of NBitMultiplierDivider is
begin
  process(a, b, op)
    variable product : std_logic_vector(2*N-1 downto 0);
    variable quotient : std_logic_vector(N-1 downto 0);
    variable remainder : std_logic_vector(N-1 downto 0);
  begin
    if op = '0' then
      -- Multiplication
      product := (others => '0');
  
      -- Perform shifting and adding to calculate the product
      for i in 0 to N-1 loop
        if a(i) = '1' then
          product(N+i downto i) := std_logic_vector(unsigned(product(N+i downto i)) + unsigned(b));
        end if;
      end loop;
  
      -- Assign the most significant bits to 'm' and least significant bits to 'r'
      m <= product(2*N-1 downto N);
      r <= product(N-1 downto 0);
      
    else
      -- Division
      product := (others => '0');
      quotient := (others => '0');
      remainder := (others => '0');
  
      -- Check for division by zero
      if b( N-1 downto 0) = "0" then
        error <= '1'; -- Division by zero error
        busy <= '0';
        valid <= '0';
      else
        busy <= '1';
  
        -- Perform shifting and subtracting to calculate the quotient and remainder
        for i in N-1 downto 0 loop
          quotient(i) := '0';
          if unsigned(remainder) >= unsigned(b) then
            quotient(i) := '1';
            remainder := std_logic_vector(unsigned(remainder) - unsigned(b));
          end if;
          remainder := remainder(N-2 downto 0) & a(i);
        end loop;
  
        -- Assign the quotient to 'm' and remainder to 'r'
        m <= quotient;
        r <= remainder;
  
        error <= '0';
        busy <= '0';
        valid <= '1';
      end if;
    end if;
  end process;
end architecture rtl;
