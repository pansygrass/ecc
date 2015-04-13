#=======================================================================
# UCB VLSI FLOW: Makefile for vcs-sim-gl-syn
#-----------------------------------------------------------------------
# Yunsup Lee (yunsup@cs.berkeley.edu)
#
# This makefile will build a rtl simulator and run various tests to
# verify proper functionality.
#

include ../Makefrag

default : all

basedir  = ../..

#--------------------------------------------------------------------
# Sources
#--------------------------------------------------------------------

# Library components

vclibdir = $(UCB_VLSI_HOME)/install/vclib
vclibsrcs = \
	$(vclibdir)/vcQueues.v \
	$(vclibdir)/vcStateElements.v \
	$(vclibdir)/vcTest.v \
	$(vclibdir)/vcTestSource.v \
	$(vclibdir)/vcTestSink.v \

# Specify what the toplevel verilog module is

toplevel = decoder

# Verilog sources

srcdir = $(basedir)/src
vsrcs = \
	$(srcdir)/decoder_tb.v \
	../dc-syn/current-dc/results/$(toplevel).mapped.v \

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

verilog_cells_dir = $(UCB_VLSI_HOME)/stdcells/$(UCB_STDCELLS)/verilog

VCS      = vcs -full64
VCS_OPTS = -notice -PP -line +lint=all,noVCDE,noTFIPC,noIWU,noOUDPE +v2k -timescale=1ns/1ps \
	-P ../dc-syn/current-dc/access.tab -debug \

#--------------------------------------------------------------------
# Build the simulator
#--------------------------------------------------------------------

vcs_sim = simv
$(vcs_sim) : Makefile $(vsrcs) $(vclibsrcs)
	$(VCS) $(VCS_OPTS) +incdir+$(srcdir) -o $(vcs_sim) \
	       +define+CLOCK_PERIOD=$(vcs_clock_period) +define+functional=1 \
	       +incdir+$(vclibdir) $(addprefix -v ,$(vclibsrcs)) \
               -v $(verilog_cells_dir)/cells_rvt.v \
               -v $(verilog_cells_dir)/cells_hvt.v \
               -v $(verilog_cells_dir)/cells_lvt.v \
							 $(vsrcs)

#--------------------------------------------------------------------
# Run
#--------------------------------------------------------------------

vpd = vcdplus.vpd
$(vpd): $(vcs_sim)
	./simv -ucli -do run.tcl +verbose=1
	date > timestamp

run: $(vpd)

#--------------------------------------------------------------------
# Default make target
#--------------------------------------------------------------------

.PHONY: run

all : $(vcs_sim)

#--------------------------------------------------------------------
# Clean up
#--------------------------------------------------------------------

junk += simv* csrc *.vpd *.key DVE* .vcs* sdf* timestamp

clean :
	rm -rf $(junk) *~ \#* *.log *.cmd *.daidir
