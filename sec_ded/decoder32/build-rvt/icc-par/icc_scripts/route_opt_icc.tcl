##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################

source icc_setup.tcl

############################################
## route_opt_icc: Post Route optimization ##
############################################




open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_ROUTE_OPT_CEL}"
copy_mw_cel -from $ICC_ROUTE_CEL -to $ICC_ROUTE_OPT_CEL
open_mw_cel $ICC_ROUTE_OPT_CEL



source common_optimization_settings_icc.tcl
source common_placement_settings_icc.tcl
source common_post_cts_timing_settings.tcl

## Load the route and si settings
source common_route_si_settings_zrt_icc.tcl



##############################
## RP : Relative Placement  ##
##############################
## Ensuring that the RP cells are not changed during clock_opt
#set_rp_group_options [all_rp_groups] -route_opt_option fixed_placement
#set_rp_group_options [all_rp_groups] -route_opt_option "size_only"


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

## start the post route optimization
set_app_var compile_instance_name_prefix icc_route_opt

if {$ICC_ENABLE_CHECKPOINT} {
echo "SCRIPT-Info : Please ensure there's enough disk space before enabling the set_checkpoint_strategy feature."
set_checkpoint_strategy -enable -overwrite
# The -overwrite option is used by default. Remove it if needed.
}

# YUNSUP: changed for fast p&r
set route_opt_cmd "route_opt -skip_initial_route -effort $ROUTE_OPT_EFFORT"

## route_opt -power performs both power aware optimization (PAO) and power recovery (PR).
#  If only PAO is desired and not PR, then please do the following:
#  1. set_route_opt_strategy power_aware_optimization true
#  2. comment out the line below (-power is not needed)
if {$LEAKAGE_POWER} {lappend route_opt_cmd -power}

echo $route_opt_cmd
eval $route_opt_cmd

if {$ICC_ENABLE_CHECKPOINT} {set_checkpoint_strategy -disable}

########################################
#   ADDITIONAL ROUTE_OPT FEATURES      #
########################################

## Additional Max_transition fixing :
#  By default, route_opt will prioritize WNS and TNS over DRC ( e.g. max_tran fixing). If you want to
#  change this behavior, and give top priority to the DRC fixing, you need to set the variable below.
#  Keep in mind : this variable, only works with the -only_design_rule swich in route_opt itself.
#  violations.
#  set_app_var routeopt_drc_over_timing true
#  route_opt -effort high -incremental -only_design_rule

## Improving QoR after the default route_opt run :
#   route_opt -inc

## Limiting route_opt to specific optimization steps :
#   route_opt -size_only : do not insert buffers or move cells : limits the disturbance to the design
#   route_opt -only_xtalk_reduction : run only the Xtalk reduction engine
#   route_opt -only_hold_time : run only the Hold fixing engine
#   route_opt -(only_)wire_size : runs the wire size engine, that fixis timing violations by applying
#                                 NDR's created by define_routing_rule

## Running size_only but still allowing buffers to be inserted for hold fixing :
#  set_app_var routeopt_allow_min_buffer_with_size_only true

if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }
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
 redirect -tee -file $REPORTS_DIR_ROUTE_OPT/$ICC_ROUTE_OPT_CEL.qor {report_qor}
 redirect -file $REPORTS_DIR_ROUTE_OPT/$ICC_ROUTE_OPT_CEL.con {report_constraints}
}

if {$ICC_REPORTING_EFFORT != "OFF" } {
     redirect -tee -file $REPORTS_DIR_ROUTE_OPT/$ICC_ROUTE_OPT_CEL.clock_tree {report_clock_tree -summary}     ;# global skew report
     redirect -file $REPORTS_DIR_ROUTE_OPT/$ICC_ROUTE_OPT_CEL.clock_timing {report_clock_timing -type skew} ;# local skew report
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_ROUTE_OPT/$ICC_ROUTE_OPT_CEL.max.tim {report_timing -crosstalk_delta -capacitance -transition_time -input_pins -nets -delay max}
 redirect -file $REPORTS_DIR_ROUTE_OPT/$ICC_ROUTE_OPT_CEL.min.tim {report_timing -crosstalk_delta -capacitance -transition_time -input_pins -nets -delay min}
}

## Uncomment if you want detailed routing violation report with or without antenna info
# if {$ICC_FIX_ANTENNA} {
#    verify_zrt_route -antenna true ;
# } else {
#    verify_zrt_route -antenna false ;
#   }


save_mw_cel -as $ICC_ROUTE_OPT_CEL
if {$ICC_REPORTING_EFFORT != "OFF" } {
 create_qor_snapshot -clock_tree -name $ICC_ROUTE_OPT_CEL
 redirect -file $REPORTS_DIR_ROUTE_OPT/$ICC_ROUTE_OPT_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}
if {[file exists [which $ICC_SIGNOFF_OPT_CHECK_CORRELATION_POSTROUTE_SCRIPT]]} {
  source $ICC_SIGNOFF_OPT_CHECK_CORRELATION_POSTROUTE_SCRIPT
}
exit
