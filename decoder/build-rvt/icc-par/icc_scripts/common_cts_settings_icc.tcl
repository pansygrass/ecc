##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################


echo "\tLoading :\t\t [info script]"

## CTS Common Session Options - set in place_opt and clock_opt sessions




## Clock Tree References
## Choose Balanced Buffers and Inverters for best results
## Avoid low strengths for initial CTS (bad CTS)
## Avoid high strengths for signal EM problems
## Each of the following take a space separated list of buffers/cels: ex: "buf1 inv1 inv2"

##Note references are cumulative
if {$ICC_CTS_REF_LIST != "" || $ICC_CTS_REF_SIZING_ONLY != "" || $ICC_CTS_REF_DEL_INS_ONLY != ""} {reset_clock_tree_references}

if {$ICC_CTS_REF_LIST != ""} {set_clock_tree_references -references $ICC_CTS_REF_LIST}
if {$ICC_CTS_REF_DEL_INS_ONLY != ""} {set_clock_tree_references -delay_insertion_only -references $ICC_CTS_REF_DEL_INS_ONLY}
if {$ICC_CTS_REF_SIZING_ONLY != ""} {set_clock_tree_references -sizing_only -references $ICC_CTS_REF_SIZING_ONLY}

## CLOCK NDR's
## Specify the rule prior to CTS so that CTS can predict its effects
## Avoid setting the rule on metal 1 - avoids pin access issues on
## buffers and gates in the tree

## ICC-RM uses by default a 2x spacing and width rule
redirect -var x {report_routing_rules $ICC_CTS_RULE_NAME}
if {$ICC_CTS_RULE_NAME == "iccrm_clock_double_spacing" && [regexp "Info: No nondrule" $x]} {
  ## use -multiplier_width 2 to add double width
  define_routing_rule iccrm_clock_double_spacing -default_reference_rule  -multiplier_spacing 2
  report_routing_rule iccrm_clock_double_spacing
  set_clock_tree_options -routing_rule iccrm_clock_double_spacing -use_default_routing_for_sinks 1
}

## Define double vias NDR. Zroute will insert the double via during clock nets routing
#  Example: To use 1x2 via34 via-array, and allow rotate and swap the via-array
#  	define_routing_rule $ICC_CTS_RULE_NAME -default_reference_rule \
#       -via_cuts {{via34 1x2 NR} {via34 2x1 R} {via34 2x1 NR} {via34 1x2 R}}
#  If there is no via defined in via_cuts, for that layer Zroute will use default via with single cut
#  Note: if classic router is used, R & NR syntax do not apply and will be ignored

## Define NDR for spacings and widths in general
# define_routing_rule $ICC_CTS_RULE_NAME -default_reference_rule \
#       -spacings "BEST_PRACTICE_clock_ndr_metal_layer_and_spacing" \
#       -widths "BEST_PRACTICE_clock_ndr_metal_layer_and_width" \
# report_routing_rule $ICC_CTS_RULE_NAME

## at 65 nm, better SI protection if you put NDR on sink, provided you
## don't set the NDR on pin access layers
## otherwise set -use_default_routing_for_sinks to 1 to avoid NDR on
## clock sink

##Typically route clocks on metal3 and above
if {$ICC_CTS_LAYER_LIST != ""} {set_clock_tree_options -layer_list $ICC_CTS_LAYER_LIST}

## You can use following commands to further specify CTS constraints and options:
#  set_clock_tree_options -max_tran 	value -clock_trees [list of clocks]
#  set_clock_tree_options -max_cap 	value -clock_trees [list of clocks]
#  set_clock_tree_options -target_skew 	value -clock_trees [list of clocks]
#  Note: it's not recommended to change -max_fanout unless necessary as doing so may degrade QoR easily.

## End of CTS Optimization Session Options #############

