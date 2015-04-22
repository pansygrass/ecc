##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################


source icc_setup.tcl

##########################################################################################
## place_opt_icc: Placement and Placement Optimizations
##########################################################################################


open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_PLACE_OPT_CEL}"
copy_mw_cel -from $ICC_FLOORPLAN_CEL -to $ICC_PLACE_OPT_CEL
open_mw_cel $ICC_PLACE_OPT_CEL

## Optimization Common Session options - set in all sessions
source common_optimization_settings_icc.tcl
source common_placement_settings_icc.tcl

## Source CTS Options CTS can be run during place_opt
source common_cts_settings_icc.tcl



## Set Ideal Network so place_opt doesn't buffer clock nets
## Remove before clock_opt cts
## Uncertainty handling pre-cts

  set_ideal_network [all_fanout -flat -clock_tree ]

  if {$ICC_APPLY_RM_UNCERTAINTY_PRECTS } {
   if {[file exists [which $ICC_UNCERTAINTY_PRECTS_FILE]] } {
       echo "SCRIPT-Info: Sourcing the pre-cts uncertainty file : $ICC_UNCERTAINTY_PRECTS_FILE"
       source  $ICC_UNCERTAINTY_PRECTS_FILE
   }
  }



set_app_var compile_instance_name_prefix icc_place


#######################
## MAGNET PLACEMENT  ##
#######################
## Define e.g. a ram as a magnet and the command will pull the cells connected to this instance
## closer to the magnet, depending on the -logical_level amount you provide.
## When adding the -exclude_buffers option, you instruct the tool to pull buffers as well, but do not consider them in the
## logical levels calculation

#magnet_placement -exclude_buffers -logical_level 2 [get_cells "INST_RAM1 INST_RAM2"]

##############################
## RP : Relative Placement  ##
##############################
## Create RP constraints as shown below
#create_rp_group Lachd_Result_reg -design ORCA -columns 1 -rows 8 -utilization 1.000000
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_0_ -column 0 -row 0
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_1_ -column 0 -row 1
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_2_ -column 0 -row 2
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_3_ -column 0 -row 3
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_4_ -column 0 -row 4
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_5_ -column 0 -row 5
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_6_ -column 0 -row 6
#add_to_rp_group ORCA::Lachd_Result_reg -leaf I_ORCA_TOP/I_RISC_CORE/I_ALU/Lachd_Result_reg_7_ -column 0 -row 7

## Other commands that can be used for RP group creation are : extract_rp_group and order_rp_groups
#extract_rp_group -group_name Lachd_Result_reg -objects [get_cells -hier Lachd_Result_reg*] -col 1 -apply
#extract_rp_group -group_name Oprnd_A_reg -objects [get_cells -hier Oprnd_A_reg*] -col 1 -apply
#extract_rp_group -group_name Oprnd_B_reg -objects [get_cells -hier Oprnd_B_reg*] -col 1 -apply
#order_rp_group -group_name Oprnd_reg {ORCA::Oprnd_A_reg ORCA::Oprnd_B_reg} -apply


if {$DYNAMIC_POWER} {
  if {[file exists [which $ICC_IN_SAIF_FILE]]} {
    read_saif -input $ICC_IN_SAIF_FILE -instance_name $ICC_SAIF_INSTANCE_NAME
  }
}

if {$DFT && !$ICC_DP_DFT_FLOW} {
  ##Read Scan Chain Information from DEF
  if {[file exists [which $ICC_IN_SCAN_DEF_FILE]] } {
       read_def $ICC_IN_SCAN_DEF_FILE
     } else {
       echo "SCRIPT-Error: Scan Def file $ICC_IN_SCAN_DEF_FILE is not found, but DFT is enabled. Please investigate it"
       exit
  }
  check_scan_chain
  redirect -file $REPORTS_DIR_PLACE_OPT/scan_chain_pre_ordering.rpt {report_scan_chain}
}

if {$LEAKAGE_POWER} {
  set_multi_vth_constraint -reset

  ############################################################
  # %LVT leakage optimization flow (edit before using it)
  ############################################################
  # For limiting the number of low Vth cells in the design, set a multithreshold
  # voltage constraint. This is a faster flow than the default leakage
  # optimization flow, and does not use the leakage power values in the library.

  # Edit the following to set the threshold voltage groups in the libraries
  # set_attribute <my_hvt_lib> default_threshold_voltage_group HVT -type string
  # set_attribute <my_lvt_lib> default_threshold_voltage_group LVT -type string

  # Edit the following to set the multithreshold voltage constraint
  # set_multi_vth_constraint -lvth_groups { LVT } -lvth_percentage <percent value>
}

################################################################################
## Save the environment snapshot for the Consistency Checker utility.
#
#  This utility checks for inconsistent settings between Design Compiler and
#  IC Compiler which can contribute to correlation mismatches.
#  Download this utility from SolvNet. See the following SolvNet article for
#  complete details: https://solvnet.synopsys.com/retrieve/026366.html
#  Uncomment the following lines to snapshot the environment.
#	write_environment -consistency -output $RESULTS_DIR/${ICC_PLACE_OPT_CEL}.write_environment
################################################################################

if {$ICC_SANITY_CHECK} {check_physical_design -stage pre_place_opt -no_display}

if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }

if {$ICC_ENABLE_CHECKPOINT} {
echo "SCRIPT-Info : Please ensure there's enough disk space before enabling the set_checkpoint_strategy feature."
set_checkpoint_strategy -enable -overwrite
# The -overwrite option is used by default. Remove it if needed.
}

# YUNSUP: changed for fast p&r
set place_opt_cmd "place_opt -effort $PLACE_OPT_EFFORT"

if {$PLACE_OPT_CONGESTION} {lappend place_opt_cmd -congestion}
if {$DFT} {lappend place_opt_cmd -optimize_dft}
if {$LEAKAGE_POWER || $DYNAMIC_POWER || $ICC_LOW_POWER_PLACEMENT} {lappend place_opt_cmd -power}
echo $place_opt_cmd
eval $place_opt_cmd

if {$ICC_ENABLE_CHECKPOINT} {set_checkpoint_strategy -disable}

if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }
############################################################################################################
# ADDING ADDITIONAL FEATURES TO THE DEFAULT PLACE_OPT COMMAND
############################################################################################################
##
## When you want to add area recovery, execute :
#
#   place_opt -area_recovery -effort low
#

## When the design has congestion issues, you have following choices :
#
#   place_opt -congestion -area_recovery -effort low ; # for medium effort congestion removal
#   place_opt -effort high -congestion -area_recovery ; # for high eff cong removal


## What commands do you need when you want to optimize SCAN ?
#   read_def $ICC_IN_SCAN_DEF_FILE
#   check_scan_chain > $REPORTS_DIR_PLACE_OPT/scan_chain_pre_ordering.rpt
#   report_scan_chain >>  $REPORTS_DIR_PLACE_OPT/scan_chain_pre_ordering.rpt
#   place_opt -effort low -optimize_dft


## What commands do you need when you want to reduce leakage power ?
#   set_power_options -leakage true
#   place_opt -effort low -area_recovery -power


## What commands do you need when you want to reduce dynamic power ?
#   set_power_options -dynamic true -low_power_placement true
#   read_saif -input $ICC_IN_SAIF_FILE
#   place_opt -effort low -area_recovery -power
#          Note : option -low_power_placement enables the register clumping algorithm in
#                 place_opt, whereas the option -dynamic enables the
#                 Gate Level Power Optimization (GLPO)


## When you want to do scan opto, leakage opto, dynamic opto, and you have congestion issues,
## use all options together :
#   read_def $ICC_IN_SCAN_DEF_FILE
#   set_power_options -leakage true -dynamic true -low_power_placement true
#   place_opt -effort low -congestion -area_recovery -optimize_dft -power


##############################
## RP : Relative Placement  ##
##############################
## Checking any RP violations.
## It is recommended to open up the GUI and bring up the RP hierarchical browser and
## RP visual mode to see if RP groups were created correctly
#check_rp_groups -all



if {$ICC_ECO_FLOW == "FREEZE_SILICON"} {

 echo "SCRIPT-Info: Starting the Freeze Silicon eco flow, inserting the spare cells"

 ## spare cell file typically contains commands like :
 ## insert_spare_cells -num_cells {ANDa 10 ANDb 20 ANDc 23} -cell_name spares

 if {[file exists [which $ICC_SPARE_CELL_FILE]]} {
   source $ICC_SPARE_CELL_FILE
 }

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
if {$ICC_TIE_CELL_FLOW} {
  echo "SCRIPT-Info : List of TIE-CELL instances in your design :"
  all_tieoff_cells
} else { report_tie_nets
  }

  if {$ICC_REPORTING_EFFORT != "OFF" } {
   redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.max.tim {report_timing -capacitance -transition_time -input_pins -nets -delay max}
   redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.min.tim {report_timing -capacitance -transition_time -input_pins -nets -delay min}
  }

save_mw_cel -as $ICC_PLACE_OPT_CEL


## Create Snapshot and Save
  if {$ICC_REPORTING_EFFORT != "OFF" } {
    redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.placement_utilization.rpt {report_placement_utilization -verbose}
    create_qor_snapshot -name $ICC_PLACE_OPT_CEL
    redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
    redirect -tee -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.qor {report_qor}
    redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.con {report_constraints}
  }

if {[file exists [which $ICC_SIGNOFF_OPT_CHECK_CORRELATION_PREROUTE_SCRIPT]]} {
  source $ICC_SIGNOFF_OPT_CHECK_CORRELATION_PREROUTE_SCRIPT
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

