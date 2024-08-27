library ieee;
  use ieee.std_logic_1164.all;

library work;
  use work.register_file_pkg.all;

entity register_file_tb is
end entity register_file_tb;

architecture behave of register_file_tb is

  signal r_rst, r_clk : std_logic;
  signal r_a,   r_b   : std_logic_vector(1 downto 0);
  signal w_a,   w_b   : std_logic_vector(3 downto 0);
  signal r_value      : std_logic_vector(3 downto 0);
  signal r_rw         : std_logic;

begin

  register_file_0 : component register_file
    generic map (
      width_g => 4, count_g => 4
    )
    port map (
      rst_i   => r_rst,
      clk_i   => r_clk,
      a_i     => r_a,
      b_i     => r_b,
      a_o     => w_a,
      b_o     => w_b,
      value_i => r_value,
      rw_i    => r_rw
    );

  tb : process is

    procedure submit is
    begin

      wait for 1 ns;
      r_clk <= '1';
      wait for 20 ns;
      r_clk <= '0';
      wait for 20 ns;

    end procedure submit;

  begin

    r_clk   <= '0';
    r_rst   <= '1';
    r_a     <= "00";
    r_b     <= "00";
    r_value <= "0000";
    r_rw    <= '0';
    submit;
    r_rst   <= '0';

    assert w_a = "0000"
      report "bad reset"
      severity error;
    assert w_b = "0000"
      report "bad reset"
      severity error;

    r_value <= "1010";
    r_rw    <= '1';
    submit;
    r_rw    <= '0';
    submit;

    assert w_a = "0000"
      report "bad zero constant"
      severity error;

    r_a     <= "01";
    r_b     <= "01";
    r_value <= "1010";
    r_rw    <= '1';
    submit;
    r_b     <= "00";
    r_value <= "0000";
    r_rw    <= '0';
    submit;

    assert w_a = "1010"
      report "bad write"
      severity error;
    assert w_b = "0000"
      report "bad value"
      severity error;

    assert false
      report "end of test"
      severity note;
    wait;

  end process tb;

end architecture behave;
