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
	
		if (reset = '1') then
			myauto <= "0000";
		elsif rising_edge (clk1Hz) then
			case (myauto) is
				when "0000" =>
					myauto <= "0001";
				when "0001" =>
					if (mycpt10s = "1001") then
						myauto <= "0010";
					end if;
				when "0010" =>
				    myauto <= "0011";
				when "0011" =>
				    myauto <= "0100";
				when "0100" =>
				    if (mycpt15s = "1110") then
				        myauto <= "0101";
				    end if;
				when "0101" =>
				    if ((jour = '1' and (not (c1 = '1' or c2 = '1'))) or (jour = '1' and not c1 = '1' and not c2 = '1')) then
				        myauto <= "0000";
				    else
				        myauto <= "0110";
				    end if;
				when "0110" =>
				    myauto <= "0111";
				when "0111" =>
				    if (mycpt10s = "1001") then
				        myauto <= "1000";
				    end if;
				when "1000" =>
				    myauto <= "1001";
				when "1001" =>
				    myauto <= "1010";
				when "1010" =>
				    if (mycpt15s = "1110") then
				        myauto <= "1011";
				    end if;
				when "1011" =>
				    myauto <= "0000";
				when others =>
					myauto <= "0000";
			end case;
		end if;
		
	end process;
	
	-- Process implicite permettant l'initialisation des compteurs 
	resetcpt <= '1' when myauto = "0000" or myauto = "0011" or myauto = "0110" or myauto = "1001" else '0';
	
	-- Process implicites d'affectations immédiates des signaux de sortie pour l'automate et les compteurs
	cpt10s <= mycpt10s;
	cpt15s <= mycpt15s;
	myauto_out <= myauto;

end Behavioral;
