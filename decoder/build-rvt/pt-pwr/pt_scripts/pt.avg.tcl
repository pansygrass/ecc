#################################################################################
# PrimeTime Reference Methodology Script
# Script: pt.tcl
# Version: D-2010.06 (July 6, 2010)
# Copyright (C) 2008-2010 Synopsys All rights reserved.
################################################################################

##################################################################
#    Source common and pt_setup.tcl File                         #
##################################################################

source make_generated_vars.tcl
source common_setup.tcl
source pt_setup.tcl

set REPORTS_SUFFIX $PT_METHOD.$PT_PARASITIC


##################################################################
#    Search Path, Library and Operating Condition Section        #
##################################################################

# Under normal circumstances, when executing a script with source, Tcl
# errors (syntax and semantic) cause the execution of the script to terminate.
# Uncomment the following line to set sh_continue_on_error to true to allow
# processing to continue when errors occur.
#set sh_continue_on_error true

set power_enable_analysis true
set power_analysis_mode averaged

set report_default_significant_digits 4 ;
set sh_source_uses_search_path true ;
set search_path ". $search_path" ;


##################################################################
#    Netlist Reading Section                                     #
##################################################################

set link_path "* $link_path"

read_verilog $NETLIST_FILES
current_design $DESIGN_NAME
link


##################################################################
#    Power Switching Activity Annotation Section                 #
##################################################################
read_saif $ACTIVITY_FILE -strip_path $STRIP_PATH
report_switching_activity -list_not_annotated > $REPORTS_DIR/$PT_EXEC.switching.$REPORTS_SUFFIX.report


##################################################################
#    Back Annotation Section                                     #
##################################################################

if {[info exists PARASITIC_PATHS] && [info exists PARASITIC_FILES]} {
  foreach para_path $PARASITIC_PATHS para_file $PARASITIC_FILES {
    if {[string compare $para_path $DESIGN_NAME] == 0} {
      read_parasitics -increment -format sbpf $para_file
    } else {
      read_parasitics -path $para_path -increment -format sbpf $para_file
    }
  }
  report_annotated_parasitics -check > $REPORTS_DIR/$PT_EXEC.rap.$REPORTS_SUFFIX.report
}


##################################################################
#    Reading Constraints Section                                 #
##################################################################

if {[info exists CONSTRAINT_FILES]} {
  foreach constraint_file $CONSTRAINT_FILES {
    if {[file extension $constraint_file] eq ".sdc"} {
      read_sdc -echo $constraint_file
    } else {
      source -echo $constraint_file
    }
  }
}

##################################################################
#    Clock Tree Synthesis Section                                #
##################################################################

#set_propagated_clock [all_clocks]


##################################################################
#    Update_timing and check_timing Section                      #
##################################################################

update_timing -full

# Ensure design is properly constrained
check_timing -verbose > $REPORTS_DIR/$PT_EXEC.ct.$REPORTS_SUFFIX.report


##################################################################
#    Report_timing Section                                       #
##################################################################

report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net -sign 4 > $REPORTS_DIR/$PT_EXEC.timing.$REPORTS_SUFFIX.report
report_clock -skew -attribute > $REPORTS_DIR/$PT_EXEC.clock.$REPORTS_SUFFIX.report
report_analysis_coverage > $REPORTS_DIR/$PT_EXEC.converage.$REPORTS_SUFFIX.report


##################################################################
#    Power Analysis Section                                      #
##################################################################

## run power analysis
check_power > $REPORTS_DIR/$PT_EXEC.checkpower.$REPORTS_SUFFIX.report
update_power

## report_power
report_power -nosplit -verbose -hierarchy > $REPORTS_DIR/$PT_EXEC.power.$REPORTS_SUFFIX.report


exit
