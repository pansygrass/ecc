

### pt_setup.tcl file              ###




### Start of PrimeTime Runtime Variables ###

##########################################################################################
# PrimeTime Variables PrimeTime RM script
# Script: pt_setup.tcl
# Version: D-2010.06 (July 6, 2010)
# Copyright (C) 2008-2010 Synopsys All rights reserved.
##########################################################################################


######################################
# Report and Results directories
######################################


# reports directory
#YUNSUP: this is set by make_generated_vars.tcl
#set REPORTS_DIR "reports"
file mkdir $REPORTS_DIR



######################################
# Library & Design Setup
######################################


### Mode : Generic

set search_path ". $ADDITIONAL_SEARCH_PATH $search_path"
set target_library $TARGET_LIBRARY_FILES
set link_path "* $target_library $ADDITIONAL_LINK_LIB_FILES"


# Provide list of  Verilog netlist file. It can be compressed ---example "A.v B.v C.v"
#YUNSUP: this is set by make_generated_vars.tcl
#set NETLIST_FILES               ""

# DESIGN_NAME will be checked for existence from common_setup.tcl
if {[string length $DESIGN_NAME] > 0} {
} else {
set DESIGN_NAME                   ""  ;#  The name of the top-level design
}








#######################################
# Non-DMSA Power Analysis Setup Section
#######################################

# switching activity (VCD/SAIF) file
#YUNSUP: this is set by make_generated_vars.tcl
#set ACTIVITY_FILE ""

# strip_path setting for the activity file
#YUNSUP: this is set by make_generated_vars.tcl
#set STRIP_PATH ""

## name map file
set NAME_MAP_FILE ""









######################################
# Back Annotation File Section
######################################

#PARASITIC Files --- example "top.sbpf A.sbpf"
#The path (instance name) and name of the parasitic file --- example "top.spef A.spef"
#Each PARASITIC_PATH entry corresponds to the related PARASITIC_FILE for the specific block"
#For a single toplevel PARASITIC file please use the toplevel design name in PARASITIC_PATHS variable."
#YUNSUP: this is set by make_generated_vars.tcl
#set PARASITIC_PATHS	 ""
#set PARASITIC_FILES	 ""



######################################
# Constraint Section Setup
######################################
# Provide one or a list of constraint files.  for example "top.sdc" or "clock.sdc io.sdc te.sdc"
#YUNSUP: this is set by make_generated_vars.tcl
#set CONSTRAINT_FILES	 ""














######################################
# End
######################################



### End of PrimeTime Runtime Variables ###
