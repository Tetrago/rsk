library ieee;
  use ieee.std_logic_1164.all;

package alu_pkg is

  type alu_op is (
    alu_add,
    alu_and,
    alu_or,
    alu_rol,
    alu_ror,
    alu_asr,
    alu_lsl,
    alu_lsr
  );

  component alu is
    generic (
      width_g : natural := 32
    );
    port (
      x_i      : in    std_logic_vector(width_g - 1 downto 0);
      y_i      : in    std_logic_vector(width_g - 1 downto 0);
      c_i      : in    std_logic;
      op_i     : in    alu_op;
      result_o : out   std_logic_vector(width_g - 1 downto 0);
      c_o      : out   std_logic
    );
  end component alu;

end package alu_pkg;
