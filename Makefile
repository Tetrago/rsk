SOURCE_PATH = src/*
TESTBENCH_PATH = test/*
TESTBENCH_UNITS = $(patsubst test/%.vhdl,%,$(wildcard $(TESTBENCH_PATH)))

WORKDIR = work
GHDL = ghdl
GHDL_FLAGS = --workdir=$(WORKDIR) --std=08
VIEWER = gtkwave

.PHONY: clean

all: clean $(TESTBENCH_UNITS)

%_tb: build
	@$(GHDL) -a $(GHDL_FLAGS) test/$@.vhdl
	@$(GHDL) -e $(GHDL_FLAGS) $@
	@$(GHDL) -r $(GHDL_FLAGS) $@ --assert-level=error

view: build
	@$(GHDL) -a $(GHDL_FLAGS) test/$(NAME)_tb.vhdl
	@$(GHDL) -e $(GHDL_FLAGS) $(NAME)_tb
	@$(GHDL) -r $(GHDL_FLAGS) $(NAME)_tb --wave=$(WORKDIR)/$(NAME).ghw --stop-time=10ms
	@$(VIEWER) $(WORKDIR)/$(NAME).ghw

build:
	@mkdir -p $(WORKDIR)
	@$(GHDL) -a $(GHDL_FLAGS) $(SOURCE_PATH)

clean:
	@rm -rf $(WORKDIR)
