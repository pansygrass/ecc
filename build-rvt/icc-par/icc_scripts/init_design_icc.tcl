##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################
##########################################################################################
## init_design_icc.tcl : initial scripts that reads the design, applies constraints and
##                   generates a zero interconnect timing report
##########################################################################################

source icc_setup.tcl

########################################################################################
# Design Creation
########################################################################################

if { $ICC_INIT_DESIGN_INPUT == "MW" } {

########################################################################################
# MW CEL as the format between DCT and ICC
########################################################################################

 open_mw_cel $ICC_INPUT_CEL -library $MW_DESIGN_LIBRARY

  if {$DFT && $ICC_DP_DFT_FLOW && !$ICC_SKIP_IN_BLOCK_IMPLEMENTATION} {
    if {[file exists [which $ICC_IN_FULL_CHIP_SCANDEF_FILE]]} {
    	read_def $ICC_IN_FULL_CHIP_SCANDEF_FILE
    } else {
    	echo "SCRIPT-Error: $ICC_DP_DFT_FLOW is set to true but SCANDEF file $ICC_IN_FULL_CHIP_SCANDEF_FILE is not found. Please investigate it"	
    }
  }

}


if {$ICC_INIT_DESIGN_INPUT != "MW" } {
  if { ![file exists [which $MW_DESIGN_LIBRARY/lib]] } {
     if { [file exists [which $MW_REFERENCE_CONTROL_FILE]]} {
       create_mw_lib \
            -tech $TECH_FILE \
            -bus_naming_style {[%d]} \
            -reference_control_file $MW_REFERENCE_CONTROL_FILE \
            $MW_DESIGN_LIBRARY
     } else {
       create_mw_lib \
            -tech $TECH_FILE \
            -bus_naming_style {[%d]} \
            -mw_reference_library $MW_REFERENCE_LIB_DIRS \
            $MW_DESIGN_LIBRARY
       }
  }
}


if {$ICC_INIT_DESIGN_INPUT == "DDC" } {

########################################################################################
# DDC as the format between DCT and ICC
########################################################################################

  open_mw_lib $MW_DESIGN_LIBRARY
  suppress_message "UID-3"      ;# avoid local link library messages
  import_designs $ICC_IN_DDC_FILE -format ddc -top $DESIGN_NAME -cel $DESIGN_NAME
  unsuppress_message "UID-3"

  if {$DFT && $ICC_DP_DFT_FLOW && !$ICC_SKIP_IN_BLOCK_IMPLEMENTATION} {
    if {[file exists [which $ICC_IN_FULL_CHIP_SCANDEF_FILE]]} {
    	remove_scan_def
    	read_def $ICC_IN_FULL_CHIP_SCANDEF_FILE
    } else {
    	echo "SCRIPT-Error: $ICC_DP_DFT_FLOW is set to true but SCANDEF file $ICC_IN_FULL_CHIP_SCANDEF_FILE is not found. Please investigate it"	
    }
  }

}


if {$ICC_INIT_DESIGN_INPUT == "VERILOG" } {

########################################################################################
# Ascii as the format between DCT and ICC
########################################################################################

 open_mw_lib $MW_DESIGN_LIBRARY

 ## add -dirty_netlist in case there are mismatches between the VERILOG netlist and the FRAM view of the cells
 read_verilog -top $DESIGN_NAME $ICC_IN_VERILOG_NETLIST_FILE
 uniquify_fp_mw_cel
 current_design $DESIGN_NAME
      read_sdc $ICC_IN_SDC_FILE
  if {$DFT && $ICC_DP_DFT_FLOW && !$ICC_SKIP_IN_BLOCK_IMPLEMENTATION} {
    if {[file exists [which $ICC_IN_FULL_CHIP_SCANDEF_FILE]]} {
    	read_def $ICC_IN_FULL_CHIP_SCANDEF_FILE
    } else {
    	echo "SCRIPT-Error: $ICC_DP_DFT_FLOW is set to true but SCANDEF file $ICC_IN_FULL_CHIP_SCANDEF_FILE is not found. Please investigate it"	
    }
  }
}

if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }

  if {$DFT && $ICC_DP_DFT_FLOW && !$ICC_SKIP_IN_BLOCK_IMPLEMENTATION} {
    redirect -file $REPORTS_DIR_INIT_DESIGN/$DESIGN_NAME.full_chip_check_scan_chain.rpt {check_scan_chain}
  }

  if {$ICC_CTS_INTERCLOCK_BALANCING && [file exists [which $ICC_CTS_INTERCLOCK_BALANCING_OPTIONS_FILE]]} {
   source $ICC_CTS_INTERCLOCK_BALANCING_OPTIONS_FILE
  }

  if {$ICC_INIT_DESIGN_INPUT == "VERILOG" } {
        set ports_clock_root {}
        foreach_in_collection a_clock [get_clocks -quiet] {
          set src_ports [filter_collection [get_attribute $a_clock sources] @object_class==port]
          set ports_clock_root  [add_to_collection $ports_clock_root $src_ports]
        }

        group_path -name REGOUT -to [all_outputs]
        group_path -name REGIN -from [remove_from_collection [all_inputs] $ports_clock_root]
        group_path -name FEEDTHROUGH -from [remove_from_collection [all_inputs] $ports_clock_root] -to [all_outputs]
  }

 remove_propagated_clock [all_fanout -clock]
 remove_propagated_clock *

 # Timing derate
 ## if you add below your own set_timing_derate commands on lib cells, you'll need to apply the following for every step in the flow
 if {$ICC_APPLY_RM_DERATING} {
  ##derate values may vary by corner
  set_timing_derate -early $ICC_EARLY_DERATING_FACTOR -cell_delay
  set_timing_derate -late  $ICC_LATE_DERATING_FACTOR  -cell_delay
  set_timing_derate -early $ICC_EARLY_DERATING_FACTOR -net_delay
  set_timing_derate -late  $ICC_LATE_DERATING_FACTOR  -net_delay
 }

## By default, the tool will set a critical range of 50% of the WNS, per pathgroup.
## If you want to change this behavior, please use the command below
## Also set_max_transition can be defined here, as well as clock gating checks
   if {$ICC_CRITICAL_RANGE != ""} {echo $ICC_CRITICAL_RANGE ; set_critical_range $ICC_CRITICAL_RANGE [current_design]}
   if {$ICC_MAX_TRANSITION != ""} {echo $ICC_MAX_TRANSITION ; set_max_transition $ICC_MAX_TRANSITION [current_design]}
   if {$ICC_MAX_FANOUT     != ""} {echo $ICC_MAX_FANOUT ; set_max_fanout     $ICC_MAX_FANOUT     [current_design]}
   # set_clock_gating_check -setup 0 [current_design]
   # set_clock_gating_check -hold 0 [current_design]
   ## Note on using set_clock_gating_check for different clock gating styles:
   #  1.If your design has ICG cells only,
   #    you do not need set_clock_gating_check as the tool will honor library defined checks.
   #  2.If your design has discrete clock gates only but does not have clock gating checks defined on them,
   #    you can specify set_clock_gating_check on those instances preferably or on the design level.
   #  3.If your design has both discrete and ICG,
   #    preferably set_clock_gating_check should be set on discrete elements only and not on the design level.
   #  * If there is set_clock_gating_check on the design level,
   #    you should also do "set timing_scgc_override_library_setup_hold false" to avoid overriding of library check values.

  if {$TLUPLUS_MIN_FILE == ""} {set TLUPLUS_MIN_FILE $TLUPLUS_MAX_FILE}
  if {$TLUPLUS_MAX_EMULATION_FILE == ""} {
    set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -min_tluplus $TLUPLUS_MIN_FILE -tech2itf_map $MAP_FILE
  } else {
    if {$TLUPLUS_MIN_EMULATION_FILE == ""} {set TLUPLUS_MIN_EMULATION_FILE $TLUPLUS_MAX_EMULATION_FILE}
    set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -min_tluplus $TLUPLUS_MIN_FILE \
            -max_emulation_tluplus $TLUPLUS_MAX_EMULATION_FILE -min_emulation_tluplus $TLUPLUS_MIN_EMULATION_FILE -tech2itf_map $MAP_FILE
  }
  report_tlu_plus_files

  if {$ICC_CTS_UPDATE_LATENCY && [file exists [which $ICC_CTS_LATENCY_OPTIONS_FILE]]} {
   source $ICC_CTS_LATENCY_OPTIONS_FILE
  }


#############################################################################################################################
# Floorplan Creation: DEF  OR  FLOORPLAN FILE  OR  TDF+initialize_floorplan
#############################################################################################################################
## Below steps apply if floorplan input is not a DEF file
##Connect P/G, to create Power and Ground Ports for Non-MV designs
##Assuming P/G Ports are included in DEF file, need PG ports created for non-DEF flows
if {$ICC_FLOORPLAN_INPUT != "DEF" } {
      ## If you have additional scripts to create pads, for example, create_cell, load it here
      #       source $YOUR_SCRIPT

      ## Connect PG first before loading floorplan file or initialize_floorplan
        if {[file exists [which $CUSTOM_CONNECT_PG_NETS_SCRIPT]]} {
        source $CUSTOM_CONNECT_PG_NETS_SCRIPT
      } else {
	derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT -create_port top
      }
}

## You can have DEF, floorplan file, or TDF as floorplan input
if {$ICC_FLOORPLAN_INPUT == "DEF" } {
  if { [file exists [which $ICC_IN_DEF_FILE]]} {

        if { [file exists [which $ICC_IN_PHYSICAL_ONLY_CELLS_CREATION_FILE]]} {source $ICC_IN_PHYSICAL_ONLY_CELLS_CREATION_FILE}
        if { [file exists [which $ICC_IN_PHYSICAL_ONLY_CELLS_CONNECTION_FILE]]} {source $ICC_IN_PHYSICAL_ONLY_CELLS_CONNECTION_FILE}

	read_def -verbose -no_incremental $ICC_IN_DEF_FILE
        if { [check_error -verbose] != 0} { echo "SCRIPT-Error, flagging ..." }
  }
}

if {$ICC_FLOORPLAN_INPUT == "FP_FILE" } {
  if { [file exists [which $ICC_IN_PHYSICAL_ONLY_CELLS_CREATION_FILE]]} {source $ICC_IN_PHYSICAL_ONLY_CELLS_CREATION_FILE}
  if { [file exists [which $ICC_IN_PHYSICAL_ONLY_CELLS_CONNECTION_FILE]]} {source $ICC_IN_PHYSICAL_ONLY_CELLS_CONNECTION_FILE}

  if { [file exists [which $ICC_IN_FLOORPLAN_FILE]]} {
	read_floorplan $ICC_IN_FLOORPLAN_FILE
  }

}

if {$ICC_FLOORPLAN_INPUT == "CREATE"} {
  if { [file exists [which $ICC_IN_PHYSICAL_ONLY_CELLS_CREATION_FILE]]} {source $ICC_IN_PHYSICAL_ONLY_CELLS_CREATION_FILE}
  if { [file exists [which $ICC_IN_PHYSICAL_ONLY_CELLS_CONNECTION_FILE]]} {source $ICC_IN_PHYSICAL_ONLY_CELLS_CONNECTION_FILE}

  if {[file exists [which $ICC_IN_TDF_FILE]]} {
  	read_pin_pad_physical_constraints $ICC_IN_TDF_FILE
  }

  initialize_floorplan \
  	-control_type aspect_ratio \
  	-core_aspect_ratio 1 \
  	-core_utilization 0.7 \
  	-row_core_ratio 1 \
  	-left_io2core 30 \
  	-bottom_io2core 30 \
  	-right_io2core 30 \
  	-top_io2core 30 \
  	-start_first_row
}

if {$ICC_FLOORPLAN_INPUT == "USER_FILE"} {
   if {[file exists [which $ICC_IN_FLOORPLAN_USER_FILE]]} { source -echo $ICC_IN_FLOORPLAN_USER_FILE}
}
if {$ICC_FLOORPLAN_INPUT == "SKIP"} {
}

## If you want to add additional floorplan details such as macro location, corner cells, io filler cells, or pad rings,
## you can add them here :
if {[file exists [which $ICC_PHYSICAL_CONSTRAINTS_FILE]] } {
  source $ICC_PHYSICAL_CONSTRAINTS_FILE
}

source common_optimization_settings_icc.tcl
source common_placement_settings_icc.tcl

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

save_mw_cel -as $ICC_FLOORPLAN_CEL

########################################################################################
# Saving the cell + snapshot creation
########################################################################################

if {$ICC_REPORTING_EFFORT != "OFF" } {
 create_qor_snapshot -name $ICC_FLOORPLAN_CEL
 redirect -file $REPORTS_DIR_INIT_DESIGN/$ICC_FLOORPLAN_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}

if {$ICC_REPORTING_EFFORT != "OFF" } {
########################################################################################
# Additional reporting: zero interconnect timing report and design summaries
########################################################################################
redirect -tee -file $REPORTS_DIR_INIT_DESIGN/$ICC_FLOORPLAN_CEL.sum {report_design_physical -all -verbose}

set_zero_interconnect_delay_mode true
redirect -tee -file $REPORTS_DIR_INIT_DESIGN/$ICC_FLOORPLAN_CEL.zic.qor {report_qor}
set_zero_interconnect_delay_mode false

########################################################################################
# Checks : Library + technology checks
########################################################################################
set_check_library_options -all
redirect -file $REPORTS_DIR_INIT_DESIGN/check_library.sum {check_library}
}

exit

