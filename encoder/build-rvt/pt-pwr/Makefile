#=======================================================================
# UCB VLSI FLOW: Makefile for pt-pwr
#-----------------------------------------------------------------------
# Yunsup Lee (yunsup@cs.berkeley.edu)
#
# This makefile will use Synopsys PrimeTime to check timing and analyze
# power of your gate-level verilog netlist.
#

default: all
basedir  = ../..
refdir = $(basedir)/../ref
include ../Makefrag

#--------------------------------------------------------------------
# Sources
#--------------------------------------------------------------------

# Specify what the toplevel verilog module is

toplevel = medianFilter
testharness = medianFilterTestHarness_rtl
toplevelinst = median_filter

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

pt_exec         := pt_shell -64bit
build_suffix    := $(shell date +%Y-%m-%d_%H-%M)
build_pt_dir    := build-pt-$(build_suffix)
cur_build_pt_dir:= current-pt
reports_dir     := reports
results_dir     := results
log_dir         := log
db_cells_dir    := $(UCB_VLSI_HOME)/stdcells/$(UCB_STDCELLS)/db

vcs_dir         := ../vcs-sim-gl-par
vcs_timestamp   := $(vcs_dir)/timestamp
icc_dir         := ../icc-par/current-icc/$(results_dir)
icc_v           := $(icc_dir)/$(toplevel).output.v
icc_sdc         := $(icc_dir)/$(toplevel).output.sdc
icc_min_sbpf    := $(icc_dir)/$(toplevel).output.sbpf.min
icc_max_sbpf    := $(icc_dir)/$(toplevel).output.sbpf.max
icc_timestamp   := $(icc_dir)/../timestamp

pt_timestamp    := $(cur_build_pt_dir)/timestamp

vars_tcl        := setup/common_setup.tcl setup/pt_setup.tcl
makegen_tcl     := make_generated_vars.tcl

pt_avg_tcl      := pt_scripts/pt.avg.tcl
pt_time_tcl     := pt_scripts/pt.time.tcl

vcs_vpd = vcdplus
pt_avg_min_rpt = $(addprefix $(cur_build_pt_dir)/$(reports_dir)/, $(addsuffix .power.avg.min.report, $(vcs_vpd)))
pt_avg_max_rpt = $(addprefix $(cur_build_pt_dir)/$(reports_dir)/, $(addsuffix .power.avg.max.report, $(vcs_vpd)))
pt_time_min_rpt = $(addprefix $(cur_build_pt_dir)/$(reports_dir)/, $(addsuffix .power.time.min.report, $(vcs_vpd)))
pt_time_max_rpt = $(addprefix $(cur_build_pt_dir)/$(reports_dir)/, $(addsuffix .power.time.max.report, $(vcs_vpd)))

vars = \
	set DESIGN_NAME                 "$(toplevel)";\n \
	set ADDITIONAL_SEARCH_PATH      "$(db_cells_dir) $(mw_cells_dir) ../$(icc_dir) ../$(refdir)";\n \
	set TARGET_LIBRARY_FILES        "$(target_library_files) $(db_sram_libs)";\n \
	set MW_REFERENCE_LIB_DIRS       "$(addprefix $(mw_cells_dir)/, $(mw_ref_libs)) $(mw_sram_libs)";\n \
        set MIN_LIBRARY_FILES           "$(min_library)";\n \
	set REPORTS_DIR                 "$(reports_dir)";\n \
	set NETLIST_FILES               "$(notdir $(icc_v))";\n \
	set CONSTRAINT_FILES           "../$(icc_sdc)";\n \

vars_avg = \
	set STRIP_PATH                  "$(testharness)/$(toplevelinst)";\n \
	set PT_METHOD                   "avg";\n \

vars_time = \
	set STRIP_PATH                  "$(testharness)/$(toplevelinst)";\n \
	set PT_METHOD                   "time";\n \

vars_min = \
	set PARASITIC_PATHS             "$(toplevel)";\n \
	set PARASITIC_FILES             "../$(icc_min_sbpf)";\n \
	set PT_PARASITIC                "min";\n \

vars_max = \
	set PARASITIC_PATHS             "$(toplevel)";\n \
	set PARASITIC_FILES             "../$(icc_max_sbpf)";\n \
	set PT_PARASITIC                "max";\n \

$(pt_timestamp): $(vcs_timestamp) $(icc_timestamp) $(vars_tcl) $(constraints_tcl) $(pt_avg_tcl) $(pt_time_tcl)
	mkdir $(build_pt_dir)
	rm -f $(cur_build_pt_dir)
	ln -s $(build_pt_dir) $(cur_build_pt_dir)
	cp $(vcs_timestamp) $(cur_build_pt_dir)/timestamp-vcs
	cp $(icc_timestamp) $(cur_build_pt_dir)/timestamp-icc
	date > $(pt_timestamp)

$(pt_avg_min_rpt): $(cur_build_pt_dir)/$(reports_dir)/%.power.avg.min.report: $(vcs_dir)/%.saif $(pt_timestamp)
	cp $(pt_avg_tcl) $(constraints_tcl) $(vars_tcl) $(cur_build_pt_dir)
	echo -e '$(vars)' > $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_avg)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_min)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set ACTIVITY_FILE "../$<";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set PT_EXEC "$(notdir $(patsubst %.saif, %, $<))";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	cd $(cur_build_pt_dir); \
	mkdir -p $(log_dir); \
	$(pt_exec) -f $(notdir $(pt_avg_tcl)) | tee $(log_dir)/$(notdir $(patsubst %.saif, %, $<)).pt.avg.min.log; \
	cd ..

$(pt_avg_max_rpt): $(cur_build_pt_dir)/$(reports_dir)/%.power.avg.max.report: $(vcs_dir)/%.saif $(pt_timestamp)
	cp $(pt_avg_tcl) $(constraints_tcl) $(vars_tcl) $(cur_build_pt_dir)
	echo -e '$(vars)' > $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_avg)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_max)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set ACTIVITY_FILE "../$<";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set PT_EXEC "$(notdir $(patsubst %.saif, %, $<))";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	cd $(cur_build_pt_dir); \
	mkdir -p $(log_dir); \
	$(pt_exec) -f $(notdir $(pt_avg_tcl)) | tee $(log_dir)/$(notdir $(patsubst %.saif, %, $<)).pt.avg.max.log; \
	cd ..

$(pt_time_min_rpt): $(cur_build_pt_dir)/$(reports_dir)/%.power.time.min.report: $(vcs_dir)/%.vcd $(pt_timestamp)
	cp $(pt_time_tcl) $(constraints_tcl) $(vars_tcl) $(cur_build_pt_dir)
	echo -e '$(vars)' > $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_time)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_min)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set ACTIVITY_FILE "../$<";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set PT_EXEC "$(notdir $(patsubst %.vcd, %, $<))";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	cd $(cur_build_pt_dir); \
	mkdir -p $(log_dir); \
	$(pt_exec) -f $(notdir $(pt_time_tcl)) | tee $(log_dir)/$(notdir $(patsubst %.vcd, %, $<)).pt.time.min.log; \
	cd ..

$(pt_time_max_rpt): $(cur_build_pt_dir)/$(reports_dir)/%.power.time.max.report: $(vcs_dir)/%.vcd $(pt_timestamp)
	cp $(pt_time_tcl) $(constraints_tcl) $(vars_tcl) $(cur_build_pt_dir)
	echo -e '$(vars)' > $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_time)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e '$(vars_max)' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set ACTIVITY_FILE "../$<";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	echo -e 'set PT_EXEC "$(notdir $(patsubst %.vcd, %, $<))";\n' >> $(cur_build_pt_dir)/$(makegen_tcl)
	cd $(cur_build_pt_dir); \
	mkdir -p $(log_dir); \
	$(pt_exec) -f $(notdir $(pt_time_tcl)) | tee $(log_dir)/$(notdir $(patsubst %.vcd, %, $<)).pt.time.max.log; \
	cd ..

pt: $(pt_avg_max_rpt)

#--------------------------------------------------------------------
# Default make target
#--------------------------------------------------------------------

.PHONY: pt

all: pt

#--------------------------------------------------------------------
# Clean up
#--------------------------------------------------------------------

junk +=

clean:
	rm -rf build* current* $(junk) *~ \#*
