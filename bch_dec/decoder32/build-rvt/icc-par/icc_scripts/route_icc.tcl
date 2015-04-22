##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################

source icc_setup.tcl

########################
## route_icc: Routing ##
########################




open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_ROUTE_CEL}"
copy_mw_cel -from $ICC_CLOCK_OPT_ROUTE_CEL -to $ICC_ROUTE_CEL
open_mw_cel $ICC_ROUTE_CEL


source common_optimization_settings_icc.tcl
source common_placement_settings_icc.tcl
source common_post_cts_timing_settings.tcl



########################################
#    LOAD THE ROUTE AND SI SETTINGS    #
########################################

source common_route_si_settings_zrt_icc.tcl

####Pre route_opt checks
##Check for Ideal Nets
set num_ideal [sizeof_collection [all_ideal_nets]]
if {$num_ideal >= 1} {echo "SCRIPT-Error-Info: $num_ideal Nets are ideal prior to route_opt. Please investigate."}

##Check for HFNs
set hfn_thres "41 101 501"
foreach thres $hfn_thres {
  set num_hfn [sizeof_collection [all_high_fanout -nets -threshold $thres]]
  echo "SCRIPT-Info: Number of nets with fanout > $thres = $num_hfn"
  if {$thres == 501 && $num_hfn >=1} {
    echo "SCRIPT-Error-Info: $num_hfn Nets with fanout > 500 exist prior to route_opt - Please check if marked ideal - possibly add buffer tree"
  }
}



if {$ICC_DBL_VIA } {

  ########################################
  #           REDUNDANT VIA              #
  ########################################


  ## When running Via insertion in MCMM mode, be aware that it works only from the current_scenario -
  ## You can use [get_dominant scenarios] to get a critical one loaded
  # set_active_scenarios [get_dominant_scenarios]

  ## Setting this option prior to routing, starts the via doubling, without the need for the standalone command
  set_route_zrt_common_options -post_detail_route_redundant_via_insertion medium
}

if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }

########################################
#       ROUTE_OPT CORE COMMAND         #
########################################

## some checks upfront
#check_routeability
report_preferred_routing_direction

## Route first the design
  report_tlu_plus_files


## Optimizing wirelenght and vias . Add the switch : -optimize_wire_via_effort_level to the set_route_zrt_detail_options command.
## Use default low for your runs except when you run double via insertion, use in that case medium effort to reduce the initail amount of vias.
#   set_route_zrt_detail_options -optimize_wire_via_effort_level medium

if {$ICC_DBL_VIA && $ICC_DBL_VIA_FLOW_EFFORT == "HIGH"} {
  set_route_zrt_common_options -concurrent_redundant_via_mode reserve_space
  set_route_zrt_common_options -concurrent_redundant_via_effort_level medium   ;#low is default: low|medium|high
}

  route_opt -initial_route_only
if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }

if {$ICC_DBL_VIA && $ICC_DBL_VIA_FLOW_EFFORT == "HIGH"} {
  set_route_zrt_common_options -concurrent_redundant_via_mode off
}
if {$ICC_CTS_UPDATE_LATENCY} {
   update_clock_latency
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
    redirect -tee -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.clock_tree {report_clock_tree -summary}     ;# global skew report
    redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.clock_timing {report_clock_timing -type skew} ;# local skew report
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -tee -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.qor {report_qor}
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.con {report_constraints}
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.max.tim {report_timing -capacitance -transition_time -input_pins -nets -delay max}
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.min.tim {report_timing -capacitance -transition_time -input_pins -nets -delay min}
}

## Uncomment if you want detailed routing violation report with or without antenna info
# if {$ICC_FIX_ANTENNA} {
#    verify_zrt_route -antenna true ;
# } else {
#    verify_zrt_route -antenna false ;
#   }


save_mw_cel -as $ICC_ROUTE_CEL

if {$ICC_REPORTING_EFFORT != "OFF" } {
 create_qor_snapshot -clock_tree -name $ICC_ROUTE_CEL
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}




if {$ICC_CREATE_GR_PNG} {
  # start GUI
  gui_start

  # turn off DR
  gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting showRoute -value false
  gui_execute_events

  # show congestion overlay
  gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting mmName -value AREAPARTITION
  gui_zoom -window [gui_get_current_window -view] -full
  gui_execute_events

  # save snapshots
  gui_write_window_image -window [gui_get_current_window -view -mru] -file ${REPORTS_DIR_ROUTE}/${ICC_ROUTE_CEL}.GR.png

  # stop GUI
  gui_stop
}

exit
