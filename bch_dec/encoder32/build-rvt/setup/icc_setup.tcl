##########################################################################################
# Variables for ICC-RM, ICC DP-RM, and ICC Hierarchical-RM
# Script: icc_setup.tcl
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################

# sourcing the common variables
source make_generated_vars.tcl
source common_setup.tcl

###############################
## General ICC variables
###############################
set ICC_INPUT_CEL                 "${DESIGN_NAME}_DCT" ;# CEL created in DCT
set PNET_METAL_LIST               ""           ;# List of metals in the design to be used for (partial) pnet options
set PNET_METAL_LIST_COMPLETE	  ""	       ;# List of metals in the design to be used for (complete) pnet options
set ICC_IN_DONT_USE_FILE          "$LIBRARY_DONT_USE_FILE" ;# file of master don't use commands
set ICC_FIX_HOLD_PREFER_CELLS     ""           ;# Syntax: library/cell_name - Example: slow/DLY1X1 slow/DLY1X4
set ICC_MAX_AREA                  ""           ;# max_area value used during area optimization
set AREA_CRITICAL_RANGE_PRE_CTS   ""           ;# area critical range use during area opto during place_opt
set AREA_CRITICAL_RANGE_POST_CTS  ""           ;# area critical range use during area opto during post CTS opt
set AREA_CRITICAL_RANGE_POST_RT   ""           ;# area critical range use during area opto during route_opt
set POWER_CRITICAL_RANGE_PRE_CTS  ""           ;# power critical range use during area opto during place_opt
set POWER_CRITICAL_RANGE_POST_CTS ""           ;# power critical range use during area opto during post CTS opt
set POWER_CRITICAL_RANGE_POST_RT  ""           ;# power critical range use during area opto during route_opt
set ICC_NUM_CPUS                  1            ;# number of cpus for distributed processing;
					       ;# specify a number greater than 1 to enable it for classic router based route_opt and insert_redundant_via commands
set ICC_NUM_CORES                 1            ;# number of cores on the local host for multicore support;
					       ;# specify a number greater than 1 to enable it for the core commands
# YUNSUP: changed for fast p&r
set ICC_REPORTING_EFFORT          ${REPORTING_EFFORT}        ;# OFF|MED|LOW when set to OFF,no reporting is done; when set to LOW, report_timing/report_qor are skipped in clock_opt_cts
# YUNSUP: changed for fast p&r
set ICC_SANITY_CHECK              FALSE         ;# TRUE|FALSE, set TRUE to perform check_physical_design
set ICC_ENABLE_CHECKPOINT	  FALSE	       ;# TRUE|FALSE, set TRUE to perform checkpoint strategy for optimization commands
					       ;# Please ensure there's enough disk space before enabling this feature. Refer to set_checkpoint_strategy man page for details.

set ICC_TIE_CELL_FLOW             FALSE        ;# TRUE|FALSE, set TRUE if you want TIE-CELLS to be used during opto instead of TIE-nets
set ICC_LOW_POWER_PLACEMENT	  FALSE	       ;# TRUE|FALSE, when set to TRUE, set_power_options -low_power_placement will be set to true
set LEAKAGE_POWER                 TRUE         ;# TRUE|FALSE; set to TRUE to enable leakage optimization flow
set DYNAMIC_POWER                 FALSE	       ;# TRUE|FALSE; set to TRUE to enable dynamic power optimization flow
set DFT                           FALSE	       ;# TRUE|FALSE; set to TRUE to enable scan reordering flow
# YUNSUP: changed for fast p&r
set ICC_DBL_VIA                   FALSE        ;# TRUE|FALSE; set to TRUE to enable detail route wire spreading
set ICC_FIX_ANTENNA               FALSE        ;# TRUE|FALSE: set to TRUE to enable antenna fixing
set ADD_FILLER_CELL               TRUE         ;# TRUE|FALSE; set to TRUE to enable std cells filler insertion
# YUNSUP: changed for fast p&r
set ICC_REDUCE_CRITICAL_AREA      FALSE        ;# TRUE|FALSE; set to TRUE to enable detail route wire spreading
set ICC_CREATE_MODEL              FALSE        ;# TRUE|FALSE; used for ILM/FRAM creation for the blocks in HRM
# YUNSUP: read from ddc
set ICC_INIT_DESIGN_INPUT         "DDC"         ;# VERILOG|DDC|MW; specify starting point
# YUNSUP: make our own floorplan
set ICC_FLOORPLAN_INPUT           "USER_FILE"        ;# DEF|FP_FILE|CREATE|USER_FILE|SKIP
set ADD_METAL_FILL                "ICC"        ;# NONE|ICC|HERCULES|ICV; will start metal fill
                                               ;# ICC : will start timing driven metal fill using ICC's command
                                               ;# HERCULES : will start signoff metal fill using Hercules
                                               ;# ICV : will start signoff metal fill using ICV

# YUNSUP: changed for fast p&r
set PLACE_OPT_EFFORT 		 ${PNR_EFFORT}      ;# low|medium|high; choose effort level for place_opt command
# YUNSUP: changed for fast p&r
set ROUTE_OPT_EFFORT 		 ${PNR_EFFORT}      ;# low|medium|high; choose effort level for route_opt command
set PLACE_OPT_CONGESTION         TRUE          ;# TRUE|FALSE; set TRUE to enable congestion removal during place_opt

###############################
## Cellname variables
###############################
#YUNSUP: this is set by make_generated_vars.tcl
#set ICC_FLOORPLAN_CEL            "init_design_icc"
set ICC_PLACE_OPT_CEL            "place_opt_icc"
set ICC_CLOCK_OPT_CTS_CEL        "clock_opt_cts_icc"
set ICC_CLOCK_OPT_PSYN_CEL       "clock_opt_psyn_icc"
set ICC_CLOCK_OPT_ROUTE_CEL      "clock_opt_route_icc"
set ICC_ROUTE_CEL                "route_icc"
set ICC_ROUTE_OPT_CEL            "route_opt_icc"
set ICC_CHIP_FINISH_CEL          "chip_finish_icc"
set ICC_SIGNOFF_CEL              "signoff_icc"
set ICC_SIGNOFF_OPT_CEL          "signoff_opt_icc"
set ICC_METAL_FILL_CEL           "metal_fill_icc"

set ICC_ECO_STARTING_CEL	 $ICC_METAL_FILL_CEL         ;# CEL to run ECO on (contains original pre-tape-out database)
set ICC_ECO_CEL             	 "eco_icc"                   ;# CEL after running the ECO (contains new eco netlist)
set ICC_FOCAL_OPT_STARTING_CEL	 $ICC_CHIP_FINISH_CEL        ;# CEL to run focal_opt on
set ICC_FOCAL_OPT_CEL       	 "focal_opt_icc"             ;# CEL after running focal_opt

set ICC_DP_CREATE_PLANGROUPS_CEL "create_plangroups_dp"
set ICC_DP_ROUTEABILITY_ON_PLANGROUPS_CEL "routeability_on_plangroups_dp"
set ICC_DP_PIN_ASSIGNMENT_BUDGETING_CEL	 "pin_assignment_budgeting_dp"
set ICC_DP_COMMIT_CEL		 "commit_dp"


###############################
## Timing variables
###############################
set ICC_APPLY_RM_DERATING               TRUE 	;# TRUE|FALSE; when set to FALSE, the derating is assumed to be in the SDC
set ICC_LATE_DERATING_FACTOR	        1.01 	;# Late derating factor, used for both data and clock
set ICC_EARLY_DERATING_FACTOR	        0.99 	;# Early derating factor, used for both data and clock

set ICC_APPLY_RM_UNCERTAINTY_PRECTS     FALSE	;# TRUE|FALSE; when set to TRUE, user uncertainty will be replaced by $ICC_UNCERTAINTY_PRECTS
set ICC_APPLY_RM_UNCERTAINTY_POSTCTS    FALSE	;# TRUE|FALSE; when set to TRUE, user uncertainty will be replaced by $ICC_UNCERTAINTY_POSTCTS
set ICC_UNCERTAINTY_PRECTS_FILE         ""   	;# pre-cts uncertainty file used during place_opt
set ICC_UNCERTAINTY_POSTCTS_FILE        ""   	;# post-cts uncertainty file used during post cts opto and route_opt
set ICC_MAX_TRANSITION                  ""   	;# max_transition value set on the design
set ICC_CRITICAL_RANGE                  ""   	;# critical_range set on the design ; default = 50% of each clock period
set ICC_MAX_FANOUT                      ""   	;# max_fanout value set on the design
set ICC_FULL_ARNOLDI                    FALSE	;# TRUE|FALSE; when set to TRUE, will enable full arnoldi, i.e. no net filtering


###############################
## Floorplan Input variables          		
###############################
set ICC_IN_DEF_FILE		  	""	;# Complete floorplan file in DEF format
set ICC_IN_FLOORPLAN_FILE	  	""	;# Complete floorplan file generated by write_floorplan
set ICC_IN_FLOORPLAN_USER_FILE	  	"floorplan.tcl"	;# Complete floorplan file generated by user ;this file will simply be sourced
set ICC_IN_TDF_FILE 		  	""	;# TDF file which contains pad or pin information
set ICC_IN_PHYSICAL_ONLY_CELLS_CREATION_FILE "" ;# a file to include physical only cell creation commands to be sourced
                                                ;# e.g. create_cell {vdd1left vdd1right vdd1top vdd1bottom} pvdi
set ICC_IN_PHYSICAL_ONLY_CELLS_CONNECTION_FILE "" ;# a file to include physical only cell connection commands to be sourced
                                                  ;# e.g. derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT -cells {vdd1left vdd1right vdd1top vdd1bottom}

set ICC_PHYSICAL_CONSTRAINTS_FILE 	""	;# Can you used to add extra floorplan info  -sourced after floorplan creation
set CUSTOM_CONNECT_PG_NETS_SCRIPT 	""      ;# If not defined as "", source this file


###############################
## MV Input variables
###############################
set AO_INSTANCES                        {}     	;# list of instances that require AO synthesis (e.g. {TOP/INST2, TOP/INST3}
set ICC_DP_AUTO_CREATE_VA               FALSE  	;# TRUE|FALSE; if TRUE, automatically creates voltage area based on user specified utilization
set CUSTOM_POWER_SWITCH_SCRIPT          ""     	;# script to define the headers_footers and connect the sleep pin
set CUSTOM_CREATE_VA_SCRIPT             ""     	;# script to define the voltage area creation commands for your design
set CUSTOM_SECONDARY_POWER_ROUTE_SCRIPT ""     	;# script to define the pre_route_standard_cells command for the AO/RR cells.
set RR_CELLS                            ""     	;# e.g. "RSD" if each Retention Register contains RSD in its name
set CUSTOM_LOAD_ASCII_UPF_SCRIPT_LIST   ""     	;# for upf flow with ascii inputs, provide a list of scripts for each power domain and top
set ICC_UPF_PM_CELL_EXISTING		FALSE	;# TRUE|FALSE; specify if design contains pre-existing power_management cells
set ICC_UPF_PM_CELL_INSERTION		FALSE	;# TRUE|FALSE; if TRUE, runs insert_mv_cells

###############################
## MCMM Input variables
###############################
set ICC_MCMM_SCENARIOS_FILE             ""     	;# file containing all scenario definitions - example in icc_scripts/mcmm.scenarios.example
set ICC_MCMM_PLACE_OPT_SCENARIOS        ""     	;# list of scenarios to be made active during place_opt; optional; by default all scenarios will be made active
set ICC_MCMM_CLOCK_OPT_PSYN_SCENARIOS   ""     	;# list of scenarios to be made active during post CTS opto (pre-route); optional; by default all scenarios will be made active
set ICC_MCMM_CLOCK_OPT_ROUTE_SCENARIOS  ""     	;# list of scenarios to be made active during clock routing; optional; by default all scenarios will be made active
set ICC_MCMM_ROUTE_SCENARIOS            ""     	;# list of scenarios to be made active during signal routing; optional; by default all scenarios will be made active
set ICC_MCMM_ROUTE_OPT_SCENARIOS        ""     	;# list of scenarios to be made active during route_opt; optional; by default all scenarios will be made active
set ICC_MCMM_CHIP_FINISH_SCENARIOS      ""     	;# list of scenarios to be made active during route_opt post chipfinish; optional; by default all scenarios will be made active
set ICC_MCMM_METAL_FILL_SCENARIOS       ""     	;# list of scenarios to be made active during metal filling; optional; by default all scenarios will be made active

set ICC_MCMM_PLACE_OPT_HIGH_CAP         FALSE  	;# TRUE|FALSE : if TRUE, enables High Capacity MCMM mode for place_opt (Adaptive MCMM)
set ICC_MCMM_CLOCK_OPT_HIGH_CAP         FALSE  	;# TRUE|FALSE : if TRUE, enables High Capacity MCMM mode for post cts opto ( pre-route) (Adaptive MCMM)

###############################
## ECO FLOW VARIABLES
###############################
set ICC_ECO_FLOW                        "NONE" 	;# NONE|UNCONSTRAINED|FREEZE_SILICON
                                               	;# UNCONSTRAINED : NO spare cell insertion ; cells can be added (pre tapeout)
                                               	;# FREEZE_SILICON : spare cell insertion/freeze silicon ECO

set ICC_SPARE_CELL_FILE                 ""     	;# TCL script to insert the spare cells, e.g. :
                                               	;# insert_spare_cells -lib_cell {INV8 DFF1} -cell_name spares -num_instances 300

set ICC_ECO_NETLIST                     ""     	;# new verilog netlist containing the ECO changes




###############################
## GATE MERGE/SPLIT
###############################
set ICC_CTS_CLOCK_GATE_MERGE           FALSE                         ;# set to TRUE to enable clock gate merging for power reduction
set ICC_CTS_CLOCK_GATE_SPLIT           FALSE                         ;# set to TRUE to enable clock gate splitting for reducing enable pin violations


###############################
## EMULATION TLU+ FILES
###############################
set TLUPLUS_MAX_EMULATION_FILE         ""  ;#  Max TLUplus file
set TLUPLUS_MIN_EMULATION_FILE         ""  ;#  Min TLUplus file


###############################
## PNG creation
###############################
set ICC_CREATE_GR_PNG                  FALSE  ;# set to TRUE to create the Global route congestion map PNG after initial route


###############################
## SIGNOFF_OPT Input variables
###############################
set PT_DIR ""                          ;# path to PT bin directory
set PT_SDC_FILE ""                     ;# optional file in case PT has different SDC that what is available in the ICC database
set STARRC_DIR ""                      ;# path to StarRC bin directory
set STARRC_MAX_NXTGRD ""               ;# MAX NXTGRD file
set STARRC_MIN_NXTGRD ""               ;# MIN NXTGRD file
set STARRC_MAP_FILE "$MAP_FILE"        ;# NXTGRD mapping file, defaults to TLUPlus mapping file, but could be different

set ICC_SIGNOFF_OPT_CHECK_CORRELATION_PREROUTE_SCRIPT "" ;# a file to be sourced to run check_signoff_correlation at end of place_opt_icc step;
							 ;# example - icc_scripts/signoff_opt_check_correlation_preroute_icc.example.tcl
set ICC_SIGNOFF_OPT_CHECK_CORRELATION_POSTROUTE_SCRIPT "" ;# a file to be sourced to run at check_signoff_correlation end of route_opt_icc step;
							  ;# example - icc_scripts/signoff_opt_check_correlation_postroute_icc.example.tcl

###############################
## SIGNOFF Physical variables
###############################
## Hercules - ensure env variable HERCULES_HOME_DIR is set and that hercules is included in path in shell ICC executed from
## ICV Metal Fill - ensure env variable PRIMEYIELD_HOME_DIR is set and that icv is included in path in shell ICC executed from
## ICV DRC - ensure env variable ICV_HOME_DIR is set and that icv is included in path in shell ICC executed from

set SIGNOFF_FILL_RUNSET ""             ;# ICV|Hercules runset for signoff_metal_fill
set SIGNOFF_DRC_RUNSET  ""             ;# ICV|Hercules runset for signoff_drc
set SIGNOFF_MAPFILE     ""             ;# Mapping file for ICV|Hercules signoff_metal_fill|signoff_drc
set SIGNOFF_DRC_ENGINE	"HERCULES"     ;# ICV|HERCULES

set SIGNOFF_METAL_FILL_TIMING_DRIVEN FALSE  ;# TRUE|FALSE : set this to TRUE to enable timing driven for ICV metal fill 	
set TIMING_PRESERVE_SLACK_SETUP	"0.1"  ;# float : setup slack threshold for wire_spreading/widening/timing driven ICV metal fill; default 0.1
set TIMING_PRESERVE_SLACK_HOLD "0"     ;# float : hold slack threshold for wire_spreading/widening; default 0

###############################
## Clock Tree variables
###############################

set ICC_CTS_RULE_NAME		"iccrm_clock_double_spacing" ;# specify clock routing rule
						;# default will be 2x NDR applied to all layers
set ICC_CTS_LAYER_LIST		""		;# clock tree layers, usually M3 and above
						;# e.g. set ICC_CTS_LAYER_LIST "M3 M4 M5"
set ICC_CTS_REF_LIST		""		;# cells ;# used for CTS
						;#   space deliminated list: cell1 cell2
set ICC_CTS_REF_DEL_INS_ONLY	""		;# cells for CTS delay insertion :
						;#   space deliminated list: cell1 cell2
set ICC_CTS_REF_SIZING_ONLY	""		;# cells for CTS that are for sizing only

set ICC_CTS_INTERCLOCK_BALANCING	FALSE	;# set this to TRUE to perform ICDB
set ICC_CTS_INTERCLOCK_BALANCING_OPTIONS_FILE	""	;# set here the interclock_delay options

set ICC_CTS_UPDATE_LATENCY	FALSE		;# set this to TRUE to perform clock latency update post CTS
set ICC_CTS_LATENCY_OPTIONS_FILE	""	;# define here the latency adjustment options options

set ICC_POST_CLOCK_ROUTE_CTO	FALSE  	       	;# set to TRUE if you want to run Post route CTO after clock routing

###############################
## Chipfinishing variables
###############################
set ICC_METAL_FILL_SPACE           2                   ;# space amount used during ICC's insert_metal_fill command
set ICC_METAL_FILL_TIMING_DRIVEN  TRUE                 ;# enables timing driven metal fill for ICC's insert_metal_fill

## end cap cels
set ICC_H_CAP_CEL                  ""           ;# defines the horizontal CAP CELL libcell
set ICC_V_CAP_CEL                  ""           ;# defines the vertical CAP CELL libcell (for the Well Proximity Effect)

## antenna fixing
set ANTENNA_RULES_FILE           ""             ;# defines the antenna rules
set ICC_USE_DIODES               FALSE          ;# TRUE|FALSE : control variable to allow diodes to be inserted both by the
                                                ;# insert_port_protection_diodes command as well as the router
set ICC_ROUTING_DIODES           ""             ;# space separated list of diode names
set ICC_PORT_PROTECTION_DIODE    ""             ;# diode name for insert_port_protection_diodes
						;# Format = library_name/diode_name

## filler cell insertion
set FILLER_CELL_METAL            ""             ;# space separated list of filler cells
# in make_generated_vars.tcl
#set FILLER_CELL                  ""             ;# ADD_FILLER_CELL - space separated

## double via insertion
set ICC_DBL_VIA_FLOW_EFFORT      LOW            ;# LOW|MED|HIGH  - MED enables concurrent soft-rule dbl via insertion
                                                ;# HIGH runs another dbl via, timing driven, after chipfinishing
set ICC_CUSTOM_DBL_VIA_DEFINE_SCRIPT ""         ;# script to define the dbl via definitions

## focal opt
set ICC_FOCAL_OPT_HOLD_VIOLS     ""             ;# filename containing the hold violations
set ICC_FOCAL_OPT_SETUP_VIOLS    ""             ;# filename containing the setup violations
set ICC_FOCAL_OPT_DRC_NET_VIOLS  ""             ;# filename containing the DRC net violations
set ICC_FOCAL_OPT_DRC_PIN_VIOLS  ""             ;# filename containing the DRC pin violations
set ICC_FOCAL_OPT_XTALK_VIOLS    ""             ;# filename containing the crosstalk violations



######################################################################################################################
#####################   ICC DESIGN PLANNING SPECIFIC (variables for ICC DP-RM and ICC Hierarchical-RM)  ##############
######################################################################################################################

#######################################################################
## Common variables (applied to both ICC DP RM and ICC Hierarchical RM)
#######################################################################

set ICC_DP_VERBOSE_REPORTING		FALSE		;# TRUE|FALSE; generate additional reports before placement
set ICC_DP_SET_HFNS_AS_IDEAL_THRESHOLD	""		;# integer; specify a threshold to set nets with fanout larger than it as ideal nets
set ICC_DP_SET_MIXED_AS_IDEAL		TRUE		;# TRUE|FALSE; set mixed clock/signal paths as ideal nets

set ICC_DP_FIX_MACRO_LIST		""		;# ""|skip|"a_list_of_macros"; unfix all macos OR skip fix OR fix specified macros before placement
set CUSTOM_ICC_DP_PLACE_CONSTRAINT_SCRIPT ""            ;# Put your set_keepout_margin and fp_set_macro_placement_constraint in this file
set ICC_DP_PLACEMENT_VA_NET_WEIGHT 	1		;# valid values are from 0 to 9; applied for MV designs and used by set_fp_placement_strategy -voltage_area_interface_net_weight
set CUSTOM_ICC_DP_PREROUTE_STD_CELL_SCRIPT ""		;# File to perform customized preroute_standard_cell commands
set ICC_DP_USE_ZROUTE                   TRUE            ;# TRUE|FALSE; use zroute for ICC DP RM and pin assignment of ICC Hierarchical RM

## PNS and PNA control variables
set CUSTOM_ICC_DP_PNS_CONSTRAINT_SCRIPT ""              ;# File to add PNS constraints which is loaded before running PNS
set PNS_POWER_NETS         		"${MW_POWER_NET} ${MW_GROUND_NET}" ;# Target nets for PNS; syntax is "your_power_net your_ground_net"
set PNS_POWER_BUDGET       		10          	;# Unit in milliWatts; default is 1000
set PNS_VOLTAGE_SUPPLY     		1.05           	;# Unit in Volts; default is 1.5
#YUNSUP: add virtual rail layer
set PNS_VIRTUAL_RAIL_LAYER 		"M1"              ;# Specify the metal layer you want to use as virtual rail
set PNS_OUTPUT_DIR         		"./pna_output"  ;# Output directory for PNS and PNA output files

###################################################
## ICC Hierarchical RM specific variables
###################################################

set ICC_SKIP_IN_BLOCK_IMPLEMENTATION    FALSE           ;# TRUE|FALSE; set TRUE to disable "Creating the physical MV objects" and "MTCMOS CELL INSTANTIATION"
							;# sections in init_design_icc.tcl if you have already done so on full chip level
set MW_ILM_LIBS                         ""              ;# add ILMs for block level FRAMs not used by DCT
set BUDGETING_SDC_OUTPUT_DIR            "./sdc"         ;# budgeting SDC output directory; default is "./sdc"

set ICC_DP_PLAN_GROUPS		"$HIERARCHICAL_CELLS"	;# full module names from which plan groups will be created
                                                        ;#   space deliminated list: "top/A top/B top/C"
							;# default to $HIERARCHICAL_CELLS from common_setup.tcl if using DCT
set ICC_DP_PLANGROUP_FILE               ""              ;# floorplan file containing plan group creation and location which should be the output of write_floorplan

set ICC_DP_CTP				FALSE		;# TRUE|FALSE; set TRUE to enable clock tree planning; please uncomment the section in hierarchical_dp.tcl first
set ICC_DP_CTP_ANCHOR_CEL               ""              ;# anchor cell for clock tree planning (anchor cell is required if you uncomment clock tree planning in scripts);
							;#   cell master of one mid-sized buffer
set ICC_DP_ALLOW_FEEDTHROUGH	        FALSE		;# TRUE|FALSE; allow feedthrough creation during pin assignment

set CUSTOM_ICC_DP_PNS_SCRIPT 		""              ;# customized PNS script; replacing PNS section in scripts
set CUSTOM_ICC_DP_PNA_SCRIPT 		""              ;# customized PNA script; replacing PNA section in scripts

## DFT-aware hierarchical design planning variables
set ICC_DP_DFT_FLOW			FALSE		;# TRUE|FALSE; enable DFT-aware hierarchical design planning flow; requires ICC_IN_FULL_CHIP_SCANDEF_FILE
set ICC_IN_FULL_CHIP_SCANDEF_FILE "$DESIGN_NAME.mapped.expanded.scandef"		
							;# ASCII full-chip SCANDEF file for DFT-aware hierarchical design planning flow (ICC_DP_DFT_FLOW)
							;# it is used for hierarchical design planning phase; not needed for block level implementations



###################################################
## ICC DP RM (Flat) specific variables
###################################################

## explore mode: flow control variables
#YUNSUP: don't explore floorplans
set ICC_DP_EXPLORE_MODE			FALSE	;# TRUE|FALSE; turn on exploration mode
set ICC_DP_EXPLORE_STYLE		default		;# valid options are: default | placement_only | no_pns_pna | no_ipo
							;# default: place -> pns/pna -> ipo -> final groute,snapshot,QOR,timing,and outputs
							;# placement_only: skips pns/pna and ipo from default | no_pns_pna: skips pna/pns from default
                                                        ;# | no_ipo: skips ipo from default
set ICC_DP_EXPLORE_SAVE_CEL_EACH_STEP 	FALSE		;# TRUE|FALSE; save 3 additional CEL after placement, ipo, and pns in explore mode (requires more disk space)
set ICC_DP_EXPLORE_REPORTING_EACH_STEP	FALSE		;# TRUE|FALSE; generate QoR snapshot and timing report after each step (longer run time)
set ICC_DP_EXPLORE_USE_GLOBAL_ROUTE 	FALSE		;# TRUE|FALSE; use route_global OR route_fp_proto (default); if ICC_DP_USE_ZROUTE is true, route_zrt_global will be used
set ICC_DP_EXPLORE_SAVE_CEL_AFTER_GROUTE TRUE		;# TRUE|FALSE; save 2 additional CEL after global route: one after placement and one at the end
set ICC_DP_EXPLORE_CUSTOM_PG_SCRIPT	""		;# string; script to be loaded to create customized PG straps after placement in explore mode;
							;# valid only if ICC_DP_EXPLORE_STYLE is placement_only or no_pns_pna

## explore mode: additional PNS control variables
set PNS_TARGET_VOLTAGE_DROP     	250	        ;# Unit in milliVolts. Tool default is 10% of PNS_POWER_BUDGET
set PNS_BLOCK_MODE         		FALSE           ;# TRUE|FALSE; specify if the design is block or top level; It turns on correspondant options in PNS and PNA
set PNS_PAD_MASTERS        		""		;# Only for top level design with power pads. Specify cell masters for power pads, e.g. "pv0i.FRAM pv0a.FRAM"
set PNS_PAD_INSTANCE_FILE  		""              ;# Only for top level design with power pads. Specify the file with a list of power pad instances
set PNS_PAD_MASTER_FILE    		""		;# Only for top level design with power pads. Specify the file with a list of power pad masters
## Please provide only one of PNS_PAD_MASTERS, OR PNS_PAD_INSTANCE_FILE, OR PNS_PAD_MASTER_FILE


##########################################################################################
#####################      NO NEED TO CHANGE IF DC-RM IS USED BEFORE          ##############
##########################################################################################

set ICC_IN_VERILOG_NETLIST_FILE "$DESIGN_NAME.mapped.v" ;#1 to n verilog input files, spaced by blanks
set ICC_IN_SDC_FILE             "$DESIGN_NAME.mapped.sdc"
set ICC_IN_DDC_FILE             "$DESIGN_NAME.mapped.ddc"
set ICC_IN_UPF_FILE             "$DESIGN_NAME.mapped.upf"
set ICC_IN_SCAN_DEF_FILE        "$DESIGN_NAME.mapped.scandef"
set MW_DESIGN_LIBRARY           "${DESIGN_NAME}_LIB"    ;# milkyway design library

##########################################################################################
#########################     USAGE OF ABOVE VARIABLES      ##############################
#########################   DO NOT CHANGE BELOW THIS LINE   ##############################
##########################################################################################

set ICC_IN_SAIF_FILE            "$DESIGN_NAME.saif"     ;# SAIF file for dynamic power opto
set ICC_SAIF_INSTANCE_NAME      $DESIGN_NAME            ;# the instance in the SAIF file containing the switching activity

set REPORTS_DIR                 "reports"               ;# Directory to write reports.
set RESULTS_DIR                 "results"               ;# Directory to write output data files

set REPORTS_DIR_INIT_DESIGN                     $REPORTS_DIR
set REPORTS_DIR_PLACE_OPT                       $REPORTS_DIR
set REPORTS_DIR_CLOCK_OPT_CTS                   $REPORTS_DIR
set REPORTS_DIR_CLOCK_OPT_PSYN                  $REPORTS_DIR
set REPORTS_DIR_CLOCK_OPT_ROUTE                 $REPORTS_DIR
set REPORTS_DIR_ROUTE                           $REPORTS_DIR
set REPORTS_DIR_ROUTE_OPT                       $REPORTS_DIR
set REPORTS_DIR_CHIP_FINISH                     $REPORTS_DIR
set REPORTS_DIR_ECO                        	$REPORTS_DIR
set REPORTS_DIR_FOCAL_OPT                       $REPORTS_DIR
set REPORTS_DIR_SIGNOFF_OPT                     $REPORTS_DIR
set REPORTS_DIR_METAL_FILL                      $REPORTS_DIR
set REPORTS_DIR_DP            			$REPORTS_DIR
set REPORTS_DIR_DP_CREATE_PLANGROUPS		$REPORTS_DIR
set REPORTS_DIR_DP_ROUTEABILITY_ON_PLANGROUPS   $REPORTS_DIR
set REPORTS_DIR_DP_PIN_ASSIGNMENT_BUDGETING     $REPORTS_DIR
set REPORTS_DIR_DP_COMMIT                       $REPORTS_DIR
set REPORTS_DIR_DP_PREPARE_BLOCK                $REPORTS_DIR
set REPORTS_DIR_FORMALITY			$REPORTS_DIR

if { ! [file exists $REPORTS_DIR_INIT_DESIGN] } { file mkdir $REPORTS_DIR_INIT_DESIGN }
if { ! [file exists $REPORTS_DIR_PLACE_OPT] } { file mkdir $REPORTS_DIR_PLACE_OPT }
if { ! [file exists $REPORTS_DIR_CLOCK_OPT_CTS] } { file mkdir $REPORTS_DIR_CLOCK_OPT_CTS }
if { ! [file exists $REPORTS_DIR_CLOCK_OPT_PSYN] } { file mkdir $REPORTS_DIR_CLOCK_OPT_PSYN }
if { ! [file exists $REPORTS_DIR_CLOCK_OPT_ROUTE] } { file mkdir $REPORTS_DIR_CLOCK_OPT_ROUTE }
if { ! [file exists $REPORTS_DIR_ROUTE] } { file mkdir $REPORTS_DIR_ROUTE }
if { ! [file exists $REPORTS_DIR_ROUTE_OPT] } { file mkdir $REPORTS_DIR_ROUTE_OPT }
if { ! [file exists $REPORTS_DIR_CHIP_FINISH] } { file mkdir $REPORTS_DIR_CHIP_FINISH }
if { ! [file exists $REPORTS_DIR_ECO] } { file mkdir $REPORTS_DIR_ECO }
if { ! [file exists $REPORTS_DIR_FOCAL_OPT] } { file mkdir $REPORTS_DIR_FOCAL_OPT }
if { ! [file exists $REPORTS_DIR_SIGNOFF_OPT] } { file mkdir $REPORTS_DIR_SIGNOFF_OPT }
if { ! [file exists $REPORTS_DIR_METAL_FILL] } { file mkdir $REPORTS_DIR_METAL_FILL }
if { ! [file exists $REPORTS_DIR_DP] } { file mkdir $REPORTS_DIR_DP }
if { ! [file exists $REPORTS_DIR_DP_CREATE_PLANGROUPS] } { file mkdir $REPORTS_DIR_DP_CREATE_PLANGROUPS }
if { ! [file exists $REPORTS_DIR_DP_ROUTEABILITY_ON_PLANGROUPS] } { file mkdir $REPORTS_DIR_DP_ROUTEABILITY_ON_PLANGROUPS }
if { ! [file exists $REPORTS_DIR_DP_PIN_ASSIGNMENT_BUDGETING] } { file mkdir $REPORTS_DIR_DP_PIN_ASSIGNMENT_BUDGETING }
if { ! [file exists $REPORTS_DIR_DP_COMMIT] } { file mkdir $REPORTS_DIR_DP_COMMIT }
if { ! [file exists $REPORTS_DIR_DP_PREPARE_BLOCK] } { file mkdir $REPORTS_DIR_DP_PREPARE_BLOCK }
if { ! [file exists $REPORTS_DIR_FORMALITY] } { file mkdir $REPORTS_DIR_FORMALITY }

## Logical libraries
  set_app_var search_path	". ./icc_scripts $ADDITIONAL_SEARCH_PATH $search_path"
  set_app_var target_library	"$TARGET_LIBRARY_FILES"
  set_app_var link_library	"* $TARGET_LIBRARY_FILES $ADDITIONAL_LINK_LIB_FILES"

if { ! [file exists $RESULTS_DIR] } {
  file mkdir $RESULTS_DIR
}
if { ! [file exists $REPORTS_DIR] } {
  file mkdir $REPORTS_DIR
}

if {$synopsys_program_name == "icc_shell"} {

## Min max library relationships
## Not common for MCMM setup, but can be used also for MCMM
if {$MIN_LIBRARY_FILES != "" } {
  foreach {max_library min_library} $MIN_LIBRARY_FILES {
    set_min_library $max_library -min_version $min_library
  }
}

## Reference libraries
if { ![file exists [which $MW_REFERENCE_CONTROL_FILE]]} {
 if {[file exists $MW_DESIGN_LIBRARY/lib]} {
   set_mw_lib_reference $MW_DESIGN_LIBRARY -mw_reference_library "$MW_REFERENCE_LIB_DIRS $MW_ILM_LIBS"
 }
}

## PD4 is not always used
if {![info exists PD4]} {set PD4 ""}

## Avoiding too many messages
set_message_info -id PSYN-040 -limit 10 ;# Dont_touch for fixed cells
set_message_info -id PSYN-087 -limit 10 ;# Port inherits its location from pad pin
set_message_info -id LINT-8   -limit 10 ;# input port is unloaded

set_app_var check_error_list "$check_error_list LINK-5 PSYN-375"

## RIMAS - disable (benign and annoying) messages
# technology file related warnings (benign)
suppress_message TFCHK-012
suppress_message TFCHK-049
suppress_message TFCHK-050
suppress_message TFCHK-080
suppress_message TFCHK-089

suppress_message RCEX-011

suppress_message ZRT-054
suppress_message ZRT-021

source check_icc_rm_values.tcl

}

#################################################################################
