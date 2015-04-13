#=======================================================================
# UCB VLSI FLOW: Makefile for icc-par
#-----------------------------------------------------------------------


default: all
basedir  = ../..
include ../Makefrag

#--------------------------------------------------------------------
# Sources
#--------------------------------------------------------------------

# Specify what the toplevel verilog module is

toplevel = decoder
testharness = decoder_tb
toplevelinst = decoder


#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

icc_exec                := icc_shell -64bit
build_suffix            := $(shell date +%Y-%m-%d_%H-%M)
build_iccdp_dir         := build-iccdp-$(build_suffix)
build_icc_dir           := build-icc-$(build_suffix)
cur_build_iccdp_dir     := current-iccdp
cur_build_icc_dir       := current-icc
reports_dir             := reports
results_dir             := results
log_dir                 := log
stdcells_dir            := $(UCB_VLSI_HOME)/stdcells/$(UCB_STDCELLS)
techfile_dir            := $(stdcells_dir)/techfile
db_cells_dir            := $(stdcells_dir)/db
mw_cells_dir            := $(stdcells_dir)/mw
tluplus_cells_dir       := $(stdcells_dir)/tluplus

dc_dir                  := ../dc-syn/current-dc/$(results_dir)
dc_ddc                  := $(dc_dir)/$(toplevel).mapped.ddc
dc_timestamp            := $(dc_dir)/../timestamp

iccdp_timestamp         := $(cur_build_iccdp_dir)/timestamp
init_design_icc         := $(cur_build_iccdp_dir)/init_design_icc

icc_timestamp           := $(cur_build_icc_dir)/timestamp
place_opt_icc           := $(cur_build_icc_dir)/place_opt_icc
clock_opt_cts_icc       := $(cur_build_icc_dir)/clock_opt_cts_icc
clock_opt_psyn_icc      := $(cur_build_icc_dir)/clock_opt_psyn_icc
clock_opt_route_icc     := $(cur_build_icc_dir)/clock_opt_route_icc
route_icc               := $(cur_build_icc_dir)/route_icc
route_opt_icc           := $(cur_build_icc_dir)/route_opt_icc
chip_finish_icc         := $(cur_build_icc_dir)/chip_finish_icc
outputs_icc             := $(cur_build_icc_dir)/outputs_icc
ic                      := $(cur_build_icc_dir)/ic

vars_tcl                := setup/common_setup.tcl setup/icc_setup.tcl icc_scripts/check_icc_rm_values.tcl
makegen_tcl             := make_generated_vars.tcl
floorplan_tcl           := floorplan/floorplan.tcl floorplan/saed_32nm.tpl

init_design_icc_tcl     := icc_scripts/init_design_icc.tcl
init_design_misc_tcl    := icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl

place_opt_icc_tcl       := icc_scripts/place_opt_icc.tcl
place_opt_misc_tcl      := icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl icc_scripts/common_cts_settings_icc.tcl
clock_opt_cts_icc_tcl   := icc_scripts/clock_opt_cts_icc.tcl
clock_opt_cts_misc_tcl  := icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl icc_scripts/common_cts_settings_icc.tcl icc_scripts/common_post_cts_timing_settings.tcl
clock_opt_psyn_icc_tcl  := icc_scripts/clock_opt_psyn_icc.tcl
clock_opt_psyn_misc_tcl := icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl icc_scripts/common_cts_settings_icc.tcl icc_scripts/common_post_cts_timing_settings.tcl
clock_opt_route_icc_tcl := icc_scripts/clock_opt_route_icc.tcl
clock_opt_route_misc_tcl:= icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl icc_scripts/common_cts_settings_icc.tcl icc_scripts/common_post_cts_timing_settings.tcl icc_scripts/common_route_si_settings_zrt_icc.tcl
route_icc_tcl           := icc_scripts/route_icc.tcl
route_misc_tcl          := icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl icc_scripts/common_post_cts_timing_settings.tcl icc_scripts/common_route_si_settings_zrt_icc.tcl
route_opt_icc_tcl       := icc_scripts/route_opt_icc.tcl
route_opt_misc_tcl      := icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl icc_scripts/common_post_cts_timing_settings.tcl icc_scripts/common_route_si_settings_zrt_icc.tcl
chip_finish_icc_tcl     := icc_scripts/chip_finish_icc.tcl
chip_finish_misc_tcl    := icc_scripts/common_optimization_settings_icc.tcl icc_scripts/common_placement_settings_icc.tcl icc_scripts/common_post_cts_timing_settings.tcl icc_scripts/common_route_si_settings_zrt_icc.tcl
outputs_icc_tcl         := icc_scripts/outputs_icc.tcl
outputs_misc_tcl        := icc_scripts/find_regs.tcl

vars = \
	set DESIGN_NAME                 "$(toplevel)";\n \
        set STRIP_PATH                  "$(testharness)/$(toplevelinst)";\n \
	set ADDITIONAL_SEARCH_PATH      "$(db_cells_dir) $(mw_cells_dir) ../$(dc_dir) ";\n \
	set TARGET_LIBRARY_FILES        "$(target_library_files) $(db_sram_libs)";\n \
	set MW_REFERENCE_LIB_DIRS       "$(addprefix $(mw_cells_dir)/, $(mw_ref_libs)) $(mw_sram_libs)";\n \
        set MIN_LIBRARY_FILES           "$(min_library)";\n \
	set TECH_FILE                   "$(techfile_dir)/techfile.tf";\n \
	set MAP_FILE                    "$(techfile_dir)/tech2itf.map";\n \
	set TLUPLUS_MAX_FILE            "$(tluplus_cells_dir)/max.tluplus";\n \
	set TLUPLUS_MIN_FILE            "$(tluplus_cells_dir)/min.tluplus";\n \
	set REPORTS_DIR                 "$(reports_dir)";\n \
	set RESULTS_DIR                 "$(results_dir)";\n \
	set FILLER_CELL                 "$(filler_cells)";\n \
	set REPORTING_EFFORT            "OFF";\n \
	set PNR_EFFORT                  "low";\n \

iccdp_vars = \
	set ICC_FLOORPLAN_CEL            "init_design_icc";\n \

icc_vars = \
	set ICC_FLOORPLAN_CEL            "init_design_icc";\n \

$(iccdp_timestamp): $(dc_timestamp) $(vars_tcl) $(floorplan_tcl) $(init_design_icc_tcl) $(init_design_misc_tcl)
	mkdir $(build_iccdp_dir)
	rm -f $(cur_build_iccdp_dir)
	ln -s $(build_iccdp_dir) $(cur_build_iccdp_dir)
	cp ../Makefrag $(cur_build_iccdp_dir)
	cp $(dc_timestamp) $(cur_build_iccdp_dir)/timestamp-dc
	date > $(iccdp_timestamp)

$(init_design_icc): $(iccdp_timestamp)
	cp $(init_design_icc_tcl) $(init_design_misc_tcl) $(vars_tcl) $(floorplan_tcl) $(cur_build_iccdp_dir)
	echo -e '$(vars)' > $(cur_build_iccdp_dir)/$(makegen_tcl)
	echo -e '$(iccdp_vars)' >> $(cur_build_iccdp_dir)/$(makegen_tcl)
	cd $(cur_build_iccdp_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(init_design_icc_tcl)) | tee -i $(log_dir)/$(notdir $(init_design_icc)).log; \
	date > $(notdir $(init_design_icc))

$(flat_dp): $(iccdp_timestamp) $(init_design_icc)
	cp $(flat_dp_tcl) $(flat_dp_misc_tcl) $(vars_tcl) $(cur_build_iccdp_dir)
	echo -e '$(vars)' > $(cur_build_iccdp_dir)/$(makegen_tcl)
	echo -e '$(iccdp_vars)' >> $(cur_build_iccdp_dir)/$(makegen_tcl)
	cd $(cur_build_iccdp_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(flat_dp_tcl)) | tee -i $(log_dir)/$(notdir $(flat_dp)).log; \
	date > $(notdir $(flat_dp))

$(icc_timestamp): $(dc_timestamp) $(iccdp_timestamp) $(vars_tcl) $(place_opt_icc_tcl) $(place_opt_misc_tcl) $(clock_opt_cts_icc_tcl) $(clock_opt_cts_misc_tcl) $(clock_opt_psyn_icc_tcl) $(clock_opt_psyn_misc_tcl) $(clock_opt_route_icc_tcl) $(clock_opt_route_misc_tcl) $(route_icc_tcl) $(route_misc_tcl) $(route_opt_icc_tcl) $(route_opt_misc_tcl) $(chip_finish_icc_tcl) $(chip_finish_misc_tcl) $(outputs_icc_tcl) $(outputs_misc_tcl)
	mkdir $(build_icc_dir)
	rm -f $(cur_build_icc_dir)
	ln -s $(build_icc_dir) $(cur_build_icc_dir)
	cp setup/start_icc_gui $(cur_build_icc_dir)/start_gui
	sed -i -e 's/_DESIGN_NAME_/$(toplevel)/' $(cur_build_icc_dir)/start_gui
	cp $(dc_timestamp) $(cur_build_icc_dir)/timestamp-dc
	cp $(iccdp_timestamp) $(cur_build_icc_dir)/timestamp-iccdp
	cp ../Makefrag $(cur_build_icc_dir)
	cp -R $(cur_build_iccdp_dir)/$(toplevel)_LIB $(cur_build_icc_dir)
	date > $(icc_timestamp)

$(place_opt_icc): $(icc_timestamp)
	cp $(place_opt_icc_tcl) $(place_opt_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(place_opt_icc_tcl)) | tee -i $(log_dir)/$(notdir $(place_opt_icc)).log; \
	date > $(notdir $(place_opt_icc))

$(clock_opt_cts_icc): $(icc_timestamp) $(place_opt_icc)
	cp $(clock_opt_cts_icc_tcl) $(clock_opt_cts_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(clock_opt_cts_icc_tcl)) | tee -i $(log_dir)/$(notdir $(clock_opt_cts_icc)).log; \
	date > $(notdir $(clock_opt_cts_icc))

$(clock_opt_psyn_icc): $(icc_timestamp) $(clock_opt_cts_icc)
	cp $(clock_opt_psyn_icc_tcl) $(clock_opt_psyn_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(clock_opt_psyn_icc_tcl)) | tee -i $(log_dir)/$(notdir $(clock_opt_psyn_icc)).log; \
	date > $(notdir $(clock_opt_psyn_icc))

$(clock_opt_route_icc): $(icc_timestamp) $(clock_opt_psyn_icc)
	cp $(clock_opt_route_icc_tcl) $(clock_opt_route_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(clock_opt_route_icc_tcl)) | tee -i $(log_dir)/$(notdir $(clock_opt_route_icc)).log; \
	date > $(notdir $(clock_opt_route_icc))

$(route_icc): $(icc_timestamp) $(clock_opt_route_icc)
	cp $(route_icc_tcl) $(route_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(route_icc_tcl)) | tee -i $(log_dir)/$(notdir $(route_icc)).log; \
	date > $(notdir $(route_icc))

$(route_opt_icc): $(icc_timestamp) $(route_icc)
	cp $(route_opt_icc_tcl) $(route_opt_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(route_opt_icc_tcl)) | tee -i $(log_dir)/$(notdir $(route_opt_icc)).log; \
	date > $(notdir $(route_opt_icc))

$(chip_finish_icc): $(icc_timestamp) $(route_opt_icc)
	cp $(chip_finish_icc_tcl) $(chip_finish_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(chip_finish_icc_tcl)) | tee -i $(log_dir)/$(notdir $(chip_finish_icc)).log; \
	date > $(notdir $(chip_finish_icc))

$(outputs_icc): $(icc_timestamp) $(chip_finish_icc)
	cp $(outputs_icc_tcl) $(outputs_misc_tcl) $(vars_tcl) $(cur_build_icc_dir)
	echo -e '$(vars)' > $(cur_build_icc_dir)/$(makegen_tcl)
	echo -e '$(icc_vars)' >> $(cur_build_icc_dir)/$(makegen_tcl)
	cd $(cur_build_icc_dir); \
	mkdir -p $(reports_dir) $(results_dir) $(log_dir); \
	$(icc_exec) -f $(notdir $(outputs_icc_tcl)) | tee -i $(log_dir)/$(notdir $(outputs_icc)).log; \
	sdfcorrect.py results/$(toplevel).output.sdf results/$(toplevel).output.corrected.sdf \
	date > $(notdir $(outputs_icc))

$(ic): $(icc_timestamp) $(outputs_icc)
	cd $(cur_build_icc_dir); \
	date > $(notdir $(ic))

init_design_icc: $(init_design_icc)

place_opt_icc: $(place_opt_icc)
clock_opt_cts_icc: $(clock_opt_cts_icc)
clock_opt_psyn_icc: $(clock_opt_psyn_icc)
clock_opt_route_icc: $(clock_opt_route_icc)
route_icc: $(route_icc)
route_opt_icc: $(route_opt_icc)
chip_finish_icc: $(chip_finish_icc)
outputs_icc: $(outputs_icc)
ic: $(ic)

#--------------------------------------------------------------------
# Default make target
#--------------------------------------------------------------------

.PHONY: init_design_icc place_opt_icc clock_opt_cts_icc clock_opt_psyn_icc clock_opt_route_icc route_icc route_opt_icc chip_finish_icc outputs_icc ic

all: init_design_icc ic

#--------------------------------------------------------------------
# Clean up
#--------------------------------------------------------------------

junk +=

clean:
	rm -rf build* current* $(junk) *~ \#*
