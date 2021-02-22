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
component Compteur_10_15s is
    port ( clk1Hz : in  STD_LOGIC;
       resetcpt : in  STD_LOGIC;
       cpt10s : out  STD_LOGIC_VECTOR (3 downto 0);
       cpt15s : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal clk1Hzin : std_logic := '0';
signal resetcptin : std_logic := '0';
signal cpt10sin : std_logic_vector(3 downto 0) := "0000";
signal cpt15sin : std_logic_vector(3 downto 0) := "0000";

begin

-- Instanciation du composant à tester
MyCompUnderTest_01 : Compteur_10_15s
port map (
    clk1Hz => clk1Hzin,
    resetcpt => resetcptin,
    cpt10s => cpt10sin,
    cpt15s => cpt15sin
);

-- Description des évolution des signaux d'entrées (stimuli)
  
  -- Description de l'évolution de l'horloge clk
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
    resetcptin <= '1';
    WAIT FOR 1200 ms;
    resetcptin <= '0';
    WAIT;
  end process;

end Behavioral;
