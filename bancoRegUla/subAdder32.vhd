library ieee;

use ieee.std_logic_1164.all;

entity subAdder32 is 
	port(
		a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(31 downto 0);
		cIN : in std_logic;
		cOUT : out std_logic;
		o : out std_logic;
		s : out std_logic_vector(31 downto 0)
	);
end subAdder32;

architecture bhv_SA32 of subAdder32 is

function auxF(inp1: std_logic_vector; inp2: std_logic ) return std_logic_vector is
	variable temp: std_logic_vector(inp1'range);
	begin
		for i in inp1'range loop
		  temp(i):= inp2 xor inp1(i);
		end loop;
		return temp;
	end function auxF;
	
component fullAdder is 
	port(
		a : in std_logic;
		b : in std_logic;
		cIn : in std_logic;
		cOUT : out std_logic;
		s : out std_logic
	);
end component;
signal c : std_logic_vector (32 downto 0);
signal aux : std_logic_vector (31 downto 0);
begin
  aux <= auxF(b, cIn);
	gen: for i in 0 to 31 generate
		adrs: fullAdder port map (a => a(i), b => aux(i), cIN => c(i), s => s(i), cOUT => c(i+1));
	end generate;
	c(0) <= cIN;
	cOUT <= c(32);
	o <= c(32) xor c(31);
end bhv_SA32;
