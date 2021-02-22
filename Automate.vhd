----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:29:11 04/23/2009 
-- Design Name: 
-- Module Name:    Automate - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Automate is
    Port ( clk1Hz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           c1 : in  STD_LOGIC;
           c2 : in  STD_LOGIC;
           jour : in  STD_LOGIC;
           cpt10s : out  STD_LOGIC_VECTOR (3 downto 0);
           cpt15s : out  STD_LOGIC_VECTOR (3 downto 0);
		   myauto_out : out  STD_LOGIC_VECTOR (3 downto 0)
		   );
end Automate;

architecture Behavioral of Automate is

	-- Composant pour la gestion des compteurs --
	COMPONENT Compteur_10_15s
	PORT(
		clk1Hz : IN std_logic;
		resetcpt : IN std_logic;          
		cpt10s : OUT std_logic_vector(3 downto 0);
		cpt15s : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	-- Signaux pour les compteurs de 10s et 15s --
	signal 	mycpt10s		: std_logic_vector(3 downto 0) := "0000";
	signal 	mycpt15s		: std_logic_vector(3 downto 0) := "0000";
	signal 	resetcpt		: std_logic := '0';

	-- Signaux pour l'automate
	signal 	myauto 		: STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin

	-- Instanciation du composant de compteur 10 et 15 secondes --
	Inst_Compteur_10_15s: Compteur_10_15s PORT MAP(
		clk1Hz => clk1Hz,
		resetcpt => resetcpt,
		cpt10s => mycpt10s,
		cpt15s => mycpt15s
	);

    ----------------------------------------------------------------------------
    -- processus permettant de contrôler l'automate
    ----------------------------------------------------------------------------
	MyAutomateCtrl : process (clk1Hz, c1, c2, jour, reset)
	begin
		
	    -----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------		
		
	end process;
	
	-- Process implicite permettant l'initialisation des compteurs 
		
		-----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
	
	-- Process implicites d'affectations immédiates des signaux de sortie pour l'automate et les compteurs
	
		-----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
	

end Behavioral;

