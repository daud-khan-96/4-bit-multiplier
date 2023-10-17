library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fourbitmultiplier is 
	port( KEY: 		in 	std_logic_vector(3 downto 0); 	-- Push buttons 
			SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0); 	-- Red LEDs 
			LEDG:		out 	std_logic_vector(7 downto 0);		-- Green LEDs 
			HEX0:		out 	std_logic_vector(7 downto 0);
			HEX1:		out 	std_logic_vector(7 downto 0);
			HEX2:		out 	std_logic_vector(7 downto 0);
			HEX3:		out 	std_logic_vector(7 downto 0)
			); 
end entity; 

architecture RTL of fourbitmultiplier is 
signal x1, x2, xs, xs2: std_logic_vector(6 downto 0);
signal a,b,s,sb,ab0,ab1,ab2,ab3: std_logic_vector(3 downto 0);
signal y1, y2, y3: std_logic_vector(4 downto 0);


begin 

a(0) <= SW(0); 
a(1) <= SW(1); 
a(2) <= SW(2); 
a(3) <= SW(3); 

b(0) <= SW(4); 
b(1) <= SW(5); 
b(2) <= SW(6); 
b(3) <= SW(7); 

ab0 <= a and (ab0'Range => b(0));
ab1 <= a and (ab1'Range => b(1));
ab2 <= a and (ab2'Range => b(2));
ab3 <= a and (ab3'Range => b(3));
 
add_1: entity work.fourbitsadder(RTL) port map('0' & ab0(3 downto 1),ab1,y1); 
add_2: entity work.fourbitsadder(RTL) port map(y1(4) & y1(3 downto 1),ab2,y2); 
add_3: entity work.fourbitsadder(RTL) port map(y2(4) & y2(3 downto 1),ab3,y3); 

s <= y3(0) & y2(0) & y1(0) & ab0(0);
sb <= y3(4 downto 1);

sevenseg_1: entity work.seven_segment(behavioral) port map(a,'0',x1); 
sevenseg_2: entity work.seven_segment(behavioral) port map(b,'0',x2); 
sevenseg_3: entity work.seven_segment(behavioral) port map(s,'0',xs); 
sevenseg_4: entity work.seven_segment(behavioral) port map(sb,'0',xs2); 

HEX0(6 downto 0) <= xs; 
HEX1(6 downto 0) <= xs2; 
HEX2(6 downto 0) <= x2; 
HEX3(6 downto 0) <= x1; 

end architecture; 