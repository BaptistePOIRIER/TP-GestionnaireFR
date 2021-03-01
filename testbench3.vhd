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
component Automate is
    port ( clk1Hz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           c2 : in  STD_LOGIC;
           jour : in  STD_LOGIC;
           cpt10s : out  STD_LOGIC_VECTOR (3 downto 0);
           cpt15s : out  STD_LOGIC_VECTOR (3 downto 0);
		   myauto_out : out  STD_LOGIC_VECTOR (3 downto 0)
		   );
end component;

signal clk1Hzin : std_logic := '0';
signal resetin : std_logic := '0';
signal c1in : std_logic := '0';
signal c2in : std_logic := '0';
signal jourin : std_logic := '1';
signal cpt10sin : std_logic_vector(3 downto 0) := "0000";
signal cpt15sin : std_logic_vector(3 downto 0) := "0000";
signal myauto_outin : std_logic_vector(3 downto 0) := "0000";
begin

-- Instanciation du composant à tester
MyAutomateUnderTest_01 : Automate
port map (
  clk1Hz => clk1Hzin,
  reset => resetin,
  c1 => c1in,
  c2 => c2in,
  jour => jourin,
  cpt10s => cpt10sin,
  cpt15s => cpt15sin,
  myauto_out => myauto_outin
);

-- Description des évolution des signaux d'entrées (stimuli)
  
  -- Description de l'évolution de l'horloge mclk
  MyClkProc : process
  begin
    clk1Hzin <= '0';
    WAIT FOR 500 ms;
    clk1Hzin <= '1';
    WAIT FOR 500 ms;
  end process;
    
  -- Description de l'évolution de l'entrée resetin
  MyResetProc : process
  begin
    resetin <= '1';
    WAIT FOR 3sec;
    resetin <= '0';
    WAIT FOR 60sec;
    jourin <= '0';
    WAIT FOR 60sec;
    c1in <= '1';
    WAIT FOR 20sec;
    c1in <= '0';
    WAIT FOR 30sec;
    c2in <= '1';
    WAIT FOR 20sec;
    jourin <= '1';
    WAIT FOR 60sec;
    c2in <= '0';
    WAIT;
  end process;
  

end Behavioral;
