library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity tb_add_sub_behav is
end entity tb_add_sub_behav;

architecture testbench of tb_add_sub_behav is
    -- Component declaration for the DUT (Design Under Test)
    component add_sub_behav
        Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
               M : in  STD_LOGIC;
               S : out  STD_LOGIC_VECTOR(3 downto 0);
               Cout : out  STD_LOGIC);
    end component;

    -- Test signal declarations
    signal A_test, B_test : STD_LOGIC_VECTOR(3 downto 0);
    signal M_test : STD_LOGIC;
    signal S_test : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout_test : STD_LOGIC;

    -- Clock signal for simulation
    signal clk : STD_LOGIC := '0';

    -- Test constants
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the DUT
    dut: add_sub_behav port map(A_test, B_test, M_test, S_test, Cout_test);

    -- Clock process for toggling the clock signal
    clk_process: process
    begin
        wait for CLK_PERIOD / 2;
        clk <= not clk;
    end process;

    -- Test stimulus process
    stimulus_process: process
    begin
        -- Test case 1: Addition
        A_test <= "0010";
        B_test <= "0001";
        M_test <= '0';
        wait for CLK_PERIOD;
        assert S_test = "0011" report "Test case 1 failed: Addition" severity error;
        assert Cout_test = '0' report "Test case 1 failed: Addition - Carry-out is incorrect" severity error;

        -- Test case 2: Subtraction
        A_test <= "0010";
        B_test <= "0001";
        M_test <= '1';
        wait for CLK_PERIOD;
        assert S_test = "0001" report "Test case 2 failed: Subtraction" severity error;
        assert Cout_test = '1' report "Test case 2 failed: Subtraction - Carry-out is incorrect" severity error;

        -- End the simulation
        wait;
    end process;

end architecture testbench;
