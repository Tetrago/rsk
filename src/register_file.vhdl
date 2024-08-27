library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.math_real.all;

entity register_file is
  generic (
    width_g : natural := 32;
    count_g : natural := 32;
    index_g : natural := natural(ceil(log2(real(count_g))))
  );
  port (
    rst_i   : in    std_logic;
    clk_i   : in    std_logic;
    a_i     : in    std_logic_vector(index_g - 1 downto 0);
    b_i     : in    std_logic_vector(index_g - 1 downto 0);
    a_o     : out   std_logic_vector(width_g - 1 downto 0);
    b_o     : out   std_logic_vector(width_g - 1 downto 0);
    value_i : in    std_logic_vector(width_g - 1 downto 0);
    rw_i    : in    std_logic
  );
end entity register_file;

architecture behave of register_file is

  type t_registers is array (1 to count_g - 1) of std_logic_vector(width_g - 1 downto 0);

  signal r_registers : t_registers;

begin

  clock : process (clk_i) is
  begin

    if rising_edge(clk_i) then
      if (rst_i = '1') then
        a_o         <= (others => '0');
        b_o         <= (others => '0');
        r_registers <= (others => (others => '0'));
      else
        a_o <= (others => '0') when unsigned(a_i) = 0 else r_registers(to_integer(unsigned(a_i)));
        b_o <= (others => '0') when unsigned(b_i) = 0 else r_registers(to_integer(unsigned(b_i)));
      end if;
    elsif falling_edge(clk_i) then
      if (rw_i = '1' and unsigned(b_i) /= 0) then
        r_registers(to_integer(unsigned(b_i))) <= value_i;
      end if;
    end if;

  end process clock;

end architecture behave;
