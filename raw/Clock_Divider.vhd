----------------------------------------------------------------------------------
-- Company: ESIGETEL
-- Engineer: D. MEIER
-- 
-- Create Date:    11:12:13 04/23/2009 
-- Design Name:    Clock Divider 8kHz -> 800Hz -> 400 Hz -> 2 Hz -> 1Hz
-- Module Name:    Clock_Divider - Behavioral 
-- Project Name:   Gestionnaire FR
-- Target Devices: XC2S200
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: V1R1
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clock_Divider is
    Port ( 	mclk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			clk400Hz : out  STD_LOGIC;
			clk1Hz : out  STD_LOGIC);
end Clock_Divider;

architecture Behavioral of Clock_Divider is

	-- Constantes fournissant les valeurs limites des compteurs pour la division d'horloge --
	constant MyValCpt800Hz : STD_LOGIC_VECTOR (3 downto 0) := "1001";	-- décimal : 9
	constant MyValCpt2Hz : STD_LOGIC_VECTOR (7 downto 0) := "11000111";	-- décimal : 199

	-- Signaux de compteurs pour les divisions d'horloges --
	signal MyCpt800Hz : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
	signal MyClk800Hz : STD_LOGIC := '1';
	
	signal MyClk400Hz : STD_LOGIC := '1';
	
	signal MyCpt2Hz : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
	signal MyClk2Hz : STD_LOGIC := '1';
	
	signal MyClk1Hz : STD_LOGIC := '1';

begin

	-- Process permettant de diviser l'horloge de 8 kHz à 800 Hz --
	MyClk800Hz_process : process (mclk, reset)
	begin
		
		-----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
		
	end process;
	
	-- Process permettant d'obtenir une horloge de 400 Hz de rapport cyclique 0,5 --
	MyClk400Hz_process : process (MyClk800Hz, reset)
	begin
		
		-----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
		
	end process;
	
	-- Process implicite permettant de connecter l'horloge interne de 400 Hz au port de sortie 400 Hz de l'entité --
	    
	    -----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
	
	-- Process permettant de diviser l'horloge de 400 Hz à 2 Hz --
	MyClk2Hz_process : process (MyClk400Hz, reset)
	begin
	
		-----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
	
	end process;
	
	-- Process permettant d'obtenir une horloge de 1 Hz de rapport cyclique 0,5 --
	MyClk1Hz_process : process (MyClk2Hz, reset)
	begin
	    
	    -----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
	
	end process;
	
	-- Process implicite permettant de connecter l'horloge interne de 1 Hz au port de sortie 1 Hz de l'entité
	    
	    -----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------

end Behavioral;

