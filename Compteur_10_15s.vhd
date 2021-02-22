----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:48:03 04/23/2009 
-- Design Name: 
-- Module Name:    Compteur_10_15s - Behavioral 
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

entity Compteur_10_15s is
    Port ( clk1Hz : in  STD_LOGIC;
           resetcpt : in  STD_LOGIC;
           cpt10s : out  STD_LOGIC_VECTOR (3 downto 0);
           cpt15s : out  STD_LOGIC_VECTOR (3 downto 0));
end Compteur_10_15s;

architecture Behavioral of Compteur_10_15s is
	
	-- Signaux pour les compteurs de 10s et 15s --
	signal 	mycpt10s		: std_logic_vector(3 downto 0) := "0000";
	signal 	mycpt15s		: std_logic_vector(3 downto 0) := "0000";
	
begin

	-- Process explicites internes permettant de décrire les deux compteurs 10 et 15 secondes 
	    
	    -----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
		MyCpt10sProc : process (clk1Hz, resetcpt)
		begin 
			if (resetcpt = '1') then
				mycpt10s <= "0000";
			elsif rising_edge (clk1Hz) then
				if mycpt10s = "1010" then
					mycpt10s <= "0000";
				else
					mycpt10s <= mycpt10s + 1;
				end if;
			end if;
		end process

		MyCpt15sProc : process (clk1Hz, resetcpt)
		begin 
			if (resetcpt = '1') then
				mycpt10s <= "0000";
			elsif rising_edge (clk1Hz) then
				if mycpt10s = "1111" then
					mycpt10s <= "0000";
				else
					mycpt10s <= mycpt10s + 1;
				end if;
			end if;
		end process
	
	-- Process implicites permettant de connecter les compteurs internes aux ports de sortie adéquats de l'entité
	    
	    -----------------------------------
		-- A compléter par les étudiants --
		-----------------------------------
		cpt10s <= mycpt10s;
		cpt15s <= mycpt15s;
		
end Behavioral;

