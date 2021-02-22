--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    12:12:59 12/17/06
-- Design Name:    
-- Module Name:    SevenSegmentCtrl - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SevenSegmentCtrl is
    Port ( clk : in std_logic;
	       display : in std_logic;
           reset : in std_logic;
           myauto : IN std_logic_vector(3 downto 0);
           an : out std_logic_vector(7 downto 0);
           ssg : out std_logic_vector(7 downto 0));
end SevenSegmentCtrl;

architecture SevenSegmentBehavioral of SevenSegmentCtrl is

	signal myan : 	std_logic_vector(7 downto 0);
	
begin
	
	-- processus permettant de d�caler l'affichage toutes les 200Hz (environ)
	MyClkAn : process (reset, clk)
	begin
		if (reset = '1') then
			myan <= "00000000";
		else
			if (clk'event and clk = '1') then
				case (myan) is 
     		        when "01111111" =>	myan <= "10111111";
					when "10111111" =>	myan <= "11011111";
     				when "11011111" =>	myan <= "11101111";
					when "11101111" =>	myan <= "11110111";
					when "11110111" =>	myan <= "11111011";
                    when "11111011" =>  myan <= "11111101";
                    when "11111101" =>  myan <= "11111110";
                    when others => myan <= "01111111";
   			    end case;
			end if;			
		end if;	
	end process;

	-- processus permettant de s�lectionner la valeur � afficher en fonction de l'anode affich�e
	MyAffichage : process (reset, myan, display)
	begin
		if (reset = '1') then
			ssg <= "10000001";
		else
			case (myan) is 
				when "01111111" =>	if (myauto = "0010") then ssg <= "10111111"; elsif (myauto = "0001") then ssg <= "11110111"; else ssg <= "11111110"; end if; 
                when "10111111" =>  if (myauto = "0101") then ssg <= "10111111"; elsif (myauto = "0100") then ssg <= "11110111"; else ssg <= "11111110"; end if;
                when "11011111" =>  if (myauto = "1000") then ssg <= "10111111"; elsif (myauto = "0111") then ssg <= "11110111"; else ssg <= "11111110"; end if;
                when "11101111" =>  if (myauto = "1011") then ssg <= "10111111"; elsif (myauto = "1010") then ssg <= "11110111"; else ssg <= "11111110"; end if;
                when "11110111" =>	if (display = '1') then ssg <= "11001000"; else ssg <= "11110001"; end if; 
				when "11111011" =>	if (display = '1') then ssg <= "11100011"; else ssg <= "10100011"; end if;
				when "11111101" =>	if (display = '1') then ssg <= "11111011"; else ssg <= "11100011"; end if;
				when "11111110" =>	if (display = '1') then ssg <= "10001111"; else ssg <= "10101111"; end if;
				when others => ssg <= "11000000";
			end case;			
		end if;	
	end process;

	an <= myan;

end SevenSegmentBehavioral;
