library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fourbithex is 
    port( KEY:         in     std_logic_vector(3 downto 0);     -- Push buttons 
            SW:         in     std_logic_vector(9 downto 0);     -- Toggle switches 
            LEDR:        out     std_logic_vector(9 downto 0);     -- Red LEDs 
            LEDG:        out     std_logic_vector(7 downto 0);        -- Green LEDs 
            HEX0:        out     std_logic_vector(7 downto 0);
            HEX1:        out     std_logic_vector(7 downto 0);
            HEX2:        out     std_logic_vector(7 downto 0);
            HEX3:        out     std_logic_vector(7 downto 0)
            ); 
end entity; 

architecture RTL of fourbithex is 
	signal x0, x1, x2, x3: std_logic; 
	signal y0, y1, y2, y3: std_logic; 
	signal c1, c2, c3: std_logic; 
	signal s0, s1, s2, s3, s4: std_logic; 
	signal m1, m2, xs, xs2: std_logic_vector(6 downto 0);
	signal a,b,s,sb: std_logic_vector(3 downto 0);


begin 

	x0 <= SW(0); 
	x1 <= SW(1); 
	x2 <= SW(2); 
	x3 <= SW(3); 

	y0 <= SW(4); 
	y1 <= SW(5); 
	y2 <= SW(6); 
	y3 <= SW(7); 
	 

	add_1: entity work.Full_adder(RTL) port map(x0, y0, '0', s0, c1); 
	add_2: entity work.Full_adder(RTL) port map(x1, y1, c1, s1, c2); 
	add_3: entity work.Full_adder(RTL) port map(x2, y2, c2, s2, c3); 
	add_4: entity work.Full_adder(RTL) port map(x3, y3, c3, s3, s4); 

	a <= x3 & x2 & x1 & x0;
	b <= y3 & y2 & y1 & y0;
	s <= s3 & s2 & s1 & s0;
	sb <= "000" & s4;

	sevenseg_1: entity work.seven_segment(behavioral) port map(a,'0',xa); 
	sevenseg_2: entity work.seven_segment(behavioral) port map(b,'0',xb); 
	sevenseg_3: entity work.seven_segment(behavioral) port map(s,'0',xs); 
	sevenseg_4: entity work.seven_segment(behavioral) port map(sb,'0',xs2); 


	HEX0(6 downto 0) <= xs; 
	HEX1(6 downto 0) <= xs2; 
	HEX2(6 downto 0) <= m2; 
	HEX3(6 downto 0) <= m1; 



	LEDG(0) <= s0; 
	LEDG(1) <= s1; 
	LEDG(2) <= s2; 
	LEDG(3) <= s3; 
	LEDG(4) <= s4; 
 
end architecture;
