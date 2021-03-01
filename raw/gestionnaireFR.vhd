----------------------------------------------------------------------------------
-- Company: ESIGETEL
-- Engineer: Didier Meier
-- 
-- Create Date:    11:51:55 23/04/2009 
-- Design Name: 	 Gestionnaire de feu rouge - impl�mentaion VHDL pour FPGA	
-- Module Name:    gestionnaireFR - Behavioral 
-- Project Name: 	 BE Logique Programmable 1A	
-- Target Devices:	XC3S200 
-- Tool versions: 	ISE 9.2i
-- Description: 		Gestionnaire d'un feu de croisement 
--
-- Dependencies: 
--
-- Revision: V2R1
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

entity gestionnaireFR is
   Port (
	  -- sorties des feux 
	  -- AB,CD,E,F	     : out std_logic_vector(2 downto 0);
	  -- clk and reset
      clk_i          : in  std_logic;
      rstn_i         : in  std_logic;
      -- push-buttons
      btnl_i         : in  std_logic;
      btnc_i         : in  std_logic;
      btnr_i         : in  std_logic;
      btnd_i         : in  std_logic;
      btnu_i         : in  std_logic;
      -- switches
      sw_i           : in  std_logic_vector(15 downto 0);
      -- 7-segment display
      disp_seg_o     : out std_logic_vector(7 downto 0);
      disp_an_o      : out std_logic_vector(7 downto 0);
      -- leds
      led_o          : out std_logic_vector(15 downto 0);
      -- RGB leds
      rgb1_red_o     : out std_logic;
      rgb1_green_o   : out std_logic;
      rgb1_blue_o    : out std_logic;
      rgb2_red_o     : out std_logic;
      rgb2_green_o   : out std_logic;
      rgb2_blue_o    : out std_logic
);
end gestionnaireFR;

architecture Behavioral of gestionnaireFR is

-- Composant pour la préparation de la division d'horloge --
    COMPONENT PrepClk
	PORT(
		mclk : IN std_logic;
		reset : IN std_logic;          
		clk8kHz : OUT std_logic
		);
	END COMPONENT;

-- Composant pour la division d'horloge --
	COMPONENT Clock_Divider
	PORT(
		mclk : IN std_logic;
		reset : IN std_logic;          
		clk400Hz : OUT std_logic;
		clk1Hz : OUT std_logic
		);
	END COMPONENT;

-- Composant de contrôle de l'affichage 7 segments --
	COMPONENT SevenSegmentCtrl
	PORT(
		clk : IN std_logic;
		display : IN std_logic;
		reset : IN std_logic;
		myauto : IN std_logic_vector(3 downto 0);          
		an : OUT std_logic_vector(7 downto 0);
		ssg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

-- Composant constituant l'automate --
	COMPONENT Automate
	PORT(
		clk1Hz : IN std_logic;
		reset : IN std_logic;
		c1 : IN std_logic;
		c2 : IN std_logic;
		jour : IN std_logic;
		cpt10s : OUT std_logic_VECTOR (3 downto 0);
		cpt15s : OUT std_logic_VECTOR (3 downto 0);          
		myauto_out : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

-- Signaux d'horloges internes --
	signal  clk8kHz 	: std_logic := '0';
	signal 	clk400Hz 	: std_logic := '0';
	signal 	clk1Hz 		: std_logic := '0';

-- Signaux pour la gestion du reset
	signal 	rstn 	: std_logic := '0';
	
-- Signaux pour les compteurs de 10s et 15s (pour l'affichage) --
	signal 	cpt10s		: std_logic_vector(3 downto 0) := "0000";
	signal 	cpt15s		: std_logic_vector(3 downto 0) := "0000";
	
-- Signaux pour les �tats de l'automate --
	signal 	myauto		: std_logic_vector(3 downto 0) := "0000";
	
-- Signaux pour l'affichage du mode de fonctionnement
	signal  disp_seg_jn : std_logic_vector(7 downto 0) := "00000000";
	signal  disp_an_jn : std_logic_vector(7 downto 0) := "00000000";


begin

    -- Instanciation du composant de prépartion de l'horloge pour le diviseur d'horloge
	Inst_PrepClk: PrepClk PORT MAP(
		mclk => clk_i,
		reset => rstn,
		clk8kHz => clk8kHz
	);
	
	-- Instanciation du composant de diviseur d'horloge
	Inst_Clock_Divider: Clock_Divider PORT MAP(
		mclk => clk8khz,
		reset => rstn,
		clk400Hz => clk400Hz,
		clk1Hz => clk1Hz
	);

	-- Instanciation du composant du contr�leur d'afficheur 7 segments
	Inst_SevenSegmentCtrl: SevenSegmentCtrl PORT MAP(
		clk => clk400Hz,
		display => sw_i(0),
		reset => rstn,
		myauto => myauto,
		an => disp_an_jn,
		ssg => disp_seg_jn
	);

	-- Instanciation du composant de l'automate
	Inst_Automate: Automate PORT MAP(
		clk1Hz => clk1Hz,
		reset => rstn,
		c1 => sw_i(7),
		c2 => sw_i(6),
		jour => sw_i(0),
		cpt10s => cpt10s,
		cpt15s => cpt15s,
		myauto_out => myauto
	);

----------------------------------------------------------------------------
-- processus implicite permettant d'inverser la polarité du reset en entrée
----------------------------------------------------------------------------

rstn <= not rstn_i;

----------------------------------------------------------------------------
-- processus implicites permettant d'attribuer la couleur des feux
----------------------------------------------------------------------------
--AB <= "010" when myauto = "0010" else 
--		"001" when myauto = "0001" else
--		"100";
--CD <= "010" when myauto = "0101" else 
--		"001" when myauto = "0100" else
--		"100";
--E <= "010" when myauto = "0111" else 
--		"001" when myauto = "1000" else
--		"100";
--F <= "010" when myauto = "1011" else 
--		"001" when myauto = "1010" else
--		"100";

-----------------------------------------------------------------------------
-- affectation des sorties par d�faut
-----------------------------------------------------------------------------
--led(0) <= clk1Hz;
led_o(3 downto 0) <= myauto(3 downto 0);
led_o(7 downto 4) <= cpt10s when sw_i(4) = '0' else cpt15s;
led_o(15 downto 8) <= (others => '0');
--red <= '0';
--grn <= '0';
--blu <= '0';
--hs <= '0';
--vs <= '0';

rgb1_red_o <= '0';
rgb1_green_o <= '0';
rgb1_blue_o <= '0';
rgb2_red_o <= '0';
rgb2_green_o <= '0'; 
rgb2_blue_o <= '0';

disp_an_o <= disp_an_jn;
disp_seg_o <= disp_seg_jn;
-----------------------------------------------------------------------------

end Behavioral;

