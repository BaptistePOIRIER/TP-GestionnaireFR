----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2021 15:24:25
-- Design Name: 
-- Module Name: testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

	-- Déclaration du composant à tester
component Clock_Divider is
    port ( mclk : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      clk400Hz : out  STD_LOGIC;
      clk1Hz : out  STD_LOGIC);
end component;

signal mclkin : std_logic := '0';
signal resetin : std_logic := '0';
signal clk400Hzin : std_logic := '0';
signal clk1Hzin : std_logic := '0';

begin

-- Instanciation du composant à tester
MyClockDividerUnderTest_01 : Clock_Divider
port map (
  mclk => mclkin,
  reset => resetin,
  clk400Hz => clk400Hzin,
  clk1Hz => clk1Hzin
);

-- Description des évolution des signaux d'entrées (stimuli)
  
  -- Description de l'évolution de l'horloge mclk
  MyClkProc : process
  begin
    mclkin <= '0';
    WAIT FOR 62.5 us;
    mclkin <= '1';
    WAIT FOR 62.5 us;
  end process;
    
  -- Description de l'évolution de l'entrée resetin
  MyResetProc : process
  begin
    resetin <= '1';
    WAIT FOR 1 ms;
    resetin <= '0';
    WAIT;
  end process;

end Behavioral;
