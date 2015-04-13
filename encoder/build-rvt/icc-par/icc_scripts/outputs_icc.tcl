##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################

source icc_setup.tcl

#######################################
####Outputs Script
#######################################

##Open Design
# YUNSUP: since we skipped the metal fill part
open_mw_cel $ICC_CHIP_FINISH_CEL -lib $MW_DESIGN_LIBRARY

  ########################
  #     SIGNOFF DRC      #
  ########################

if {[file exists [which $SIGNOFF_DRC_RUNSET]] } {

  if {$SIGNOFF_DRC_ENGINE == "HERCULES"} {
    set_physical_signoff_options -exec_cmd hercules -drc_runset $SIGNOFF_DRC_RUNSET
  } elseif { $SIGNOFF_DRC_ENGINE == "ICV"} {
    set_physical_signoff_options -exec_cmd icv -drc_runset $SIGNOFF_DRC_RUNSET
    }

  if {$SIGNOFF_MAPFILE != ""} {set_physical_signoff_options -mapfile $SIGNOFF_MAPFILE}
  report_physical_signoff_options
  signoff_drc

}

##Change Names
change_names -rules verilog -hierarchy
save_mw_cel -as change_names_icc
close_mw_cel
open_mw_cel change_names_icc


##Verilog
write_verilog -diode_ports -no_physical_only_cells $RESULTS_DIR/$DESIGN_NAME.output.v

## For comparison with a Design Compiler netlist,the option -diode_ports is removed
#write_verilog -no_physical_only_cells $RESULTS_DIR/$DESIGN_NAME.output.dc.v

## For LVS use,the option -no_physical_only_cells is removed
#write_verilog -diode_ports -pg $RESULTS_DIR/$DESIGN_NAME.output.pg.lvs.v

## For Prime Time use,to include DCAP cells for leakage power analysis,add the option -force_output_references
#  write_verilog -diode_ports -no_physical_only_cells -force_output_references [list of your DCAP cells] \
#  $RESULTS_DIR/$DESIGN_NAME.output.pt.v

#YUNSUP: write sdf
write_sdf $RESULTS_DIR/$DESIGN_NAME.output.sdf

##SDC
set_app_var write_sdc_output_lumped_net_capacitance false
set_app_var write_sdc_output_net_resistance false

write_sdc $RESULTS_DIR/$DESIGN_NAME.output.sdc

extract_rc -coupling_cap
#write_parasitics  -format SPEF -output $RESULTS_DIR/$DESIGN_NAME.output.spef
write_parasitics  -format SBPF -output $RESULTS_DIR/$DESIGN_NAME.output.sbpf

##DEF
#write_def -output  $RESULTS_DIR/$DESIGN_NAME.output.def

source find_regs.tcl
find_regs ${STRIP_PATH}

###GDSII
##Set options - usually also include a mapping file (-map_layer)
##  set_write_stream_options \
#	-child_depth 99 \
#       -output_filling fill \
#       -output_outdated_fill \
#       -output_pin geometry \
#       -keep_data_type
#   write_stream -lib_name $MW_DESIGN_LIBRARY -format gds $RESULTS_DIR/$DESIGN_NAME.gds

## Since C-2009.06, in case of MCMM, all scenarios are made active during ILM creation.
## No need to do this anymore separately

if {$ICC_CREATE_MODEL } {
  save_mw_cel -as $DESIGN_NAME
  close_mw_cel
  open_mw_cel $DESIGN_NAME
  create_ilm -include_xtalk
  ## Validating ILM using write_interface_timing and compare_interface_timing:
  #  	write_interface_timing cel.rpt
  #  	close_mw_cel
  #  	open_mw_cel $DESIGN_NAME.ILM
  #  	write_interface_timing ilm.rpt
  #  	compare_interface_timing cel.rpt ilm.rpt -output compare_interface_timing.rpt
  #  	close_mw_cel
  #  	open_mw_cel $DESIGN_NAME

  create_macro_fram
  if {$ICC_FIX_ANTENNA} {
  ##create Antenna Info
    extract_zrt_hier_antenna_property -cell_name $DESIGN_NAME
  }
  close_mw_cel
}

exit
