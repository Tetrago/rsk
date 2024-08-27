library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.math_real.all;

package register_file_pkg is

  component register_file is
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
  end component register_file;

end package register_file_pkg;
