----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2020 09:17:13
-- Design Name: 
-- Module Name: PrepClk - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PrepClk is
    Port ( 	mclk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			clk8kHz : out  STD_LOGIC);
end PrepClk;

architecture Behavioral of PrepClk is

    -- Constantes fournissant les valeurs limites des compteurs pour la division d'horloge --
	constant MyValCpt8kHz : STD_LOGIC_VECTOR (15 downto 0) := "0011000011010011";	-- décimal : 12 499
	constant MyValCpt8kHzDiv2 : STD_LOGIC_VECTOR (15 downto 0) := "0001100001101001";	-- décimal : 6 249
	
	-- Signaux de compteurs pour les divisions d'horloges --
	signal MyCpt8kHz : STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
	signal MyClk8kHz : STD_LOGIC := '1';
	
begin

	MyClk8kHz_process : process (mclk, reset)
	begin
		if (reset = '1') then 
			MyCpt8kHz <= (others=>'0');
			MyClk8kHz <= '0';
		elsif (mclk'event and mclk = '1') then
			if (MyCpt8kHz = MyValCpt8kHz) then
				MyCpt8kHz <= (others=>'0');
				MyClk8kHz <= '1';
			elsif (MyCpt8kHz > MyValCpt8kHzDiv2 and MyCpt8kHz < MyValCpt8kHz) then
				MyCpt8kHz <= MyCpt8kHz + 1;
				MyClk8kHz <= '1';
            else
                MyCpt8kHz <= MyCpt8kHz + 1;
				MyClk8kHz <= '0';
			end if;			
		end if;
	end process;
	
	clk8kHz <= MyClk8kHz ;
	
end Behavioral;
