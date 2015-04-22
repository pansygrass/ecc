##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################


echo "\tLoading :\t\t [info script]"

# Placement Common Session Options - set in all sessions

## Set Min/Max Routing Layers
if { $MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}
if { $MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}



## Set PNET Options to control cel placement around P/G straps
if {$PNET_METAL_LIST != "" || $PNET_METAL_LIST_COMPLETE != "" } {
	remove_pnet_options

	if {$PNET_METAL_LIST_COMPLETE != "" } {
		set_pnet_options -complete $PNET_METAL_LIST_COMPLETE -see_object {all_types}
	}

	if {$PNET_METAL_LIST != "" } {
		set_pnet_options -partial $PNET_METAL_LIST -see_object {all_types}
	}
	
	report_pnet_options
}



## Improved congestion analysis by using Global Route info
# echo "SCRIPT-Info : Enabling Global Gouter during placement"
# set_app_var placer_enable_enhanced_router true



## it is recommended to use the default of the tool
## in case it needs to change ( e.g. for low utlization designs), use the command below :
 # set_congestion_options -max_util 0.85

