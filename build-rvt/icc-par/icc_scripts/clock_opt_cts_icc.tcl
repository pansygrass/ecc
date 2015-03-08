##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################
source icc_setup.tcl

###########################################################
## clock_opt_cts_icc: Clock Tree Synthesis and Optimization
###########################################################


open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_CLOCK_OPT_CTS_CEL}"
copy_mw_cel -from $ICC_PLACE_OPT_CEL -to $ICC_CLOCK_OPT_CTS_CEL
open_mw_cel $ICC_CLOCK_OPT_CTS_CEL



## Optimization Common Session Options - set in all sessions
source common_optimization_settings_icc.tcl
source common_placement_settings_icc.tcl



## Source CTS Options
source common_cts_settings_icc.tcl


set_app_var cts_instance_name_prefix CTS



##############################
## RP : Relative Placement  ##
##############################
## Ensuring that the RP cells are not changed during clock_opt
#set_rp_group_options [all_rp_groups] -cts_option fixed_placement
#set_rp_group_options [all_rp_groups] -cts_option "size_only"


set_delay_calculation -clock_arnoldi


if {$ICC_CTS_CLOCK_GATE_SPLIT} {
 report_split_clock_gates_options
 set_optimize_pre_cts_power_options -split_clock_gates true
}


 if {$ICC_SANITY_CHECK} {check_physical_design -stage pre_clock_opt -no_display}
 check_clock_tree

if {$ICC_ENABLE_CHECKPOINT} {
echo "SCRIPT-Info : Please ensure there's enough disk space before enabling the set_checkpoint_strategy feature."
set_checkpoint_strategy -enable -overwrite
# The -overwrite option is used by default. Remove it if needed.
}

set clock_opt_cts_cmd "clock_opt -only_cts -no_clock_route"
if {$ICC_CTS_CLOCK_GATE_MERGE || $ICC_CTS_CLOCK_GATE_SPLIT || $ICC_LOW_POWER_PLACEMENT} {lappend clock_opt_cts_cmd -power}
if {$ICC_CTS_INTERCLOCK_BALANCING && [file exists [which $ICC_CTS_INTERCLOCK_BALANCING_OPTIONS_FILE]]} {lappend clock_opt_cts_cmd -inter_clock_balance}
if {$ICC_CTS_UPDATE_LATENCY} {lappend clock_opt_cts_cmd -update_clock_latency}
echo $clock_opt_cts_cmd
eval $clock_opt_cts_cmd

if {$ICC_ENABLE_CHECKPOINT} {set_checkpoint_strategy -disable}

if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }
############################################################################################################
# ADDING ADDITIONAL FEATURES TO THE CLOCK_OPT COMMAND
############################################################################################################

## When you want to do interclock delay balancing, you need to execute the following commands :
#  set_inter_clock_delay_options -balance_group "Clk1 Clk2"
#  clock_opt -inter_clock_balance


## When you want to update the IO latency before you start the post CTS optimization, add :
# set_latency_adjustment_options -from_clock  ....  -to_clock .... -latency ....
# clock_opt -update_clock_latency -no_clock_route


## checking whether the clock nets got the NDR
# report_net_routing_rules [get_nets -hier *]



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

source common_post_cts_timing_settings.tcl
  #ideal network
  remove_ideal_network [all_fanout -flat -clock_tree]

  #set fix hold
  set_fix_hold [all_clocks]

  #uncertainties
  if {$ICC_APPLY_RM_UNCERTAINTY_POSTCTS } {
   if {[file exists [which $ICC_UNCERTAINTY_POSTCTS_FILE]] } {
       echo "SCRIPT-Info: Sourcing the post-cts uncertainty file : $ICC_UNCERTAINTY_POSTCTS_FILE"
       source  $ICC_UNCERTAINTY_POSTCTS_FILE
   }

  }


 if {$ICC_REPORTING_EFFORT != "OFF" } {
     redirect -tee -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.clock_tree {report_clock_tree -summary}     ;# global skew report
     redirect -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.clock_timing {report_clock_timing -type skew} ;# local skew report
 }

if {$ICC_REPORTING_EFFORT == "MED" } {
 redirect -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.max.tim {report_timing -capacitance -transition_time -input_pins -nets -delay max}
 redirect -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.min.tim {report_timing -capacitance -transition_time -input_pins -nets -delay min}
}
if {$ICC_REPORTING_EFFORT == "MED" } {
   redirect -tee -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.qor {report_qor}
   redirect -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.con {report_constraints}
}


save_mw_cel -as $ICC_CLOCK_OPT_CTS_CEL

if {$ICC_REPORTING_EFFORT != "OFF" } {
   redirect -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.placement_utilization.rpt {report_placement_utilization -verbose}
   create_qor_snapshot -clock_tree -name $ICC_CLOCK_OPT_CTS_CEL
   redirect -file $REPORTS_DIR_CLOCK_OPT_CTS/$ICC_CLOCK_OPT_CTS_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}

exit


