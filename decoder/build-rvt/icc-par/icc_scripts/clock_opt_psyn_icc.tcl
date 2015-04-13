##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################

source icc_setup.tcl
###############################################
## clock_opt_psyn_icc: Post CTS optimization ##
###############################################



open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_CLOCK_OPT_PSYN_CEL}"
copy_mw_cel -from $ICC_CLOCK_OPT_CTS_CEL -to $ICC_CLOCK_OPT_PSYN_CEL
open_mw_cel $ICC_CLOCK_OPT_PSYN_CEL



## Optimization Common Session Options - set in all sessions
source common_optimization_settings_icc.tcl
source common_placement_settings_icc.tcl



## Source CTS Options
source common_cts_settings_icc.tcl

## Source Post CTS Options
source common_post_cts_timing_settings.tcl


set_app_var compile_instance_name_prefix icc_clock

if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }
if {$LEAKAGE_POWER} {
  # The following is not needed if already set in place_opt_icc step:
  # set_multi_vth_constraint -reset

  ############################################################
  # %LVT leakage optimization flow (edit before using it)
  ############################################################
  # For limiting the number of low Vth cells in the design, set a multithreshold
  # voltage constraint. This is a faster flow than the default leakage
  # optimization flow, and does not use the leakage power values in the library.

  # Edit the following to set the threshold voltage groups in the libraries.
  # Please use the same settings as used in place_opt_icc step.
  # set_attribute <my_hvt_lib> default_threshold_voltage_group HVT -type string
  # set_attribute <my_lvt_lib> default_threshold_voltage_group LVT -type string

  # If pre-existing, the <percent value> of set_multi_vth_constraint will be inherited
  # from previous ICC step where it was last set.
  # If needed, edit the following to set a differnt <percent value>
  # set_multi_vth_constraint -lvth_groups { LVT } -lvth_percentage <percent value>
}

extract_rc
if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }

if {$ICC_ENABLE_CHECKPOINT} {
echo "SCRIPT-Info : Please ensure there's enough disk space before enabling the set_checkpoint_strategy feature."
set_checkpoint_strategy -enable -overwrite
# The -overwrite option is used by default. Remove it if needed.
}
# YUNSUP: changed for fast p&r
set clock_opt_psyn_cmd "clock_opt -no_clock_route -only_psyn"
if {$DFT} {lappend clock_opt_psyn_cmd -optimize_dft}
if {$LEAKAGE_POWER || $DYNAMIC_POWER} {lappend clock_opt_psyn_cmd -power}
echo $clock_opt_psyn_cmd
eval $clock_opt_psyn_cmd

if {$ICC_ENABLE_CHECKPOINT} {set_checkpoint_strategy -disable}

route_zrt_group -all_clock_nets -reuse_existing_global_route true -stop_after_global_route true
if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }
############################################################################################################
# ADDITIONAL FEATURES FOR THE POST CTS OPTIMIZATION
############################################################################################################

## When the design has congestion issues post CTS, use :
# refine_placement -congestion_effort medium

## Additional optimization can be done using the psynopt command
# psynopt -effort "medium|high"


########################################
#         ANTENNA PREVENTION           #
########################################


if {$ICC_USE_DIODES && $ICC_PORT_PROTECTION_DIODE != ""} {
 ## Optionally insert a diode before routing to avoid antenna's on the ports of the block
 remove_attribute $ICC_PORT_PROTECTION_DIODE dont_use
 insert_port_protection_diodes -prefix diode -diode_cell $ICC_PORT_PROTECTION_DIODE -port [all_inputs]
 legalize_placement

}





########################################
#           CONNECT P/G                #
########################################


## Connect Power & Ground for non-MV and MV-mode

 if {[file exists [which $CUSTOM_CONNECT_PG_NETS_SCRIPT]]} {
   source $CUSTOM_CONNECT_PG_NETS_SCRIPT
 } else {
    derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT
    if {!$ICC_TIE_CELL_FLOW} {derive_pg_connection -power_net $MW_POWER_NET -ground_net $MW_GROUND_NET -tie}
   }
if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }





if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -tee -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.qor {report_qor}
 redirect -file      $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.con {report_constraints}
}


if {$ICC_REPORTING_EFFORT != "OFF" } {
     redirect -tee -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.clock_tree {report_clock_tree -summary}     ;# global skew report
     redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.clock_timing {report_clock_timing -type skew} ;# local skew report
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.max.tim {report_timing -capacitance -transition_time -input_pins -nets -delay max}
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.min.tim {report_timing -capacitance -transition_time -input_pins -nets -delay min}
}

save_mw_cel -as $ICC_CLOCK_OPT_PSYN_CEL

## Create Snapshot and Save
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.placement_utilization.rpt {report_placement_utilization -verbose}
 create_qor_snapshot -clock_tree -name $ICC_CLOCK_OPT_PSYN_CEL
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}
## Categorized Timing Report (CTR)
#  Use CTR in the interactive mode to view the results of create_qor_snapshot.
#	query_qor_snapshot -display
#  query_qor_snapshot condenses the timing report into a cross-referencing table for quick analysis.
#  It can be used to highlight violating paths and metric in the layout window and timing reports.
#  CTR also provides special options to focus on top-level and hierarchical timing issues.
#  When dealing with dirty designs, increasing the number violations per path to 20-30 when generating a snapshot can help
#  find more issues after each run (create_qor_snapshot -nworst 20).


exit
