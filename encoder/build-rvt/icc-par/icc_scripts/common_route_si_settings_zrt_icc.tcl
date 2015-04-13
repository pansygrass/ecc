##########################################################################################
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
##########################################################################################



echo "\tLoading :\t\t [info script]"



#########################################
#           TIMING OPTIONS              #
#########################################
## By default, Xtalk Delta Delay is enabled for all flows
set_si_options -delta_delay true  \
               -route_xtalk_prevention true \
               -route_xtalk_prevention_threshold 0.25

## For the QoR flow, we also enable min_delta_delay
 set_si_options -min_delta_delay true


#########################################
#    MAX_TRAN FIXING                    #
#########################################
## From 2006.06-SP4 onwards, route_opt will NOT fix nor report Delta Max
## Tran violations.  Hence all max_tran violations exclude the portion
## that is introduced by Xtalk.
## If you want to change this behavior, and fix max_transition violations
## including these caused by Xtalk, please use the switch -max_transition_mode
## in set_si_options. Keep in mind that you can expect a runtime hit of up
## to 2x in DRC fixing during route_opt.

# set_si_options -delta_delay true \
#                -route_xtalk_prevention true \
#                -route_xtalk_prevention_threshold 0.25 \
#                -max_transition_mode total_slew


#########################################
#      ADVANCED TIMING FEATURES         #
#########################################
## if static noise (aka glitches) needs to be reduced, please use the extra options below :
# set_si_options -delta_delay true \
#                -static_noise true \
#                -static_noise_threshold_above_low 0.35 \
#                -static_noise_threshold_below_high 0.35 \
#                -route_xtalk_prevention true \
#                -route_xtalk_prevention_threshold 0.25

set_delay_calculation -arnoldi
if {$ICC_FULL_ARNOLDI} {
    echo "SCRIPT-Info : Enabling Arnoldi for all nets of the design"
    set rc_rd_more_than_rnet_arnoldi_threshold 100000000
}

## if you want to enable Timing Windows during XDD calculation, please use :
#  set_si_options -timing_window true

## if you want to enable Timing Windows during XDD calculaion, please use :
#  set_si_options -timing_window true


########################################
#          ZROUTE OPTIONS              #
########################################
## Zroute Global route options
# set_route_zrt_global_options

## Zroute Track assign options
# set_route_zrt_track_options

## Zroute Detail route options
# set_route_zrt_detail_options

## Set Area Critical Range
## Typical value: 3-4 percent of critical clock period
if {$AREA_CRITICAL_RANGE_POST_RT != ""} {set_app_var physopt_area_critical_range $AREA_CRITICAL_RANGE_POST_RT}

## Set Power Critical Range
## Typical value: 3-4 percent of critical clock period
if {$POWER_CRITICAL_RANGE_POST_RT != ""} {set_app_var physopt_power_critical_range $POWER_CRITICAL_RANGE_POST_RT}


########################################
#       ROUTE_OPT ONLY OPTIONS         #
########################################
set_app_var routeopt_skip_report_qor true  ;##default is false - set to skip second report_qor in route_opt

## 2010.03 control for xtalk reduction - values shown are just examples and not recommendations
#  set_route_opt_zrt_crosstalk_options -effort_level medium                                ;# low|medium|high - default low

#  set_route_opt_zrt_crosstalk_options -setup true                                         ;# default true
#  set_route_opt_zrt_crosstalk_options -setup_total_delta_delay_threshold 100000           ;# default -1.0 (not set)
#  set_route_opt_zrt_crosstalk_options -setup_one_net_delta_delay_threshold 0.005          ;# default -1.0 (not set)
#  set_route_opt_zrt_crosstalk_options -setup_slack_threshold 0.0                          ;# default 0.0
#  set_route_opt_zrt_crosstalk_options -setup_max_net_count 100000                         ;# default -1 (not set)
#  set_route_opt_zrt_crosstalk_options -setup_min_net_count 10                             ;# default -1 (not set)

#  set_route_opt_zrt_crosstalk_options -hold true                                          ;# default false
#  set_route_opt_zrt_crosstalk_options -hold_one_net_delta_delay_threshold 0.005           ;# default -1.0 (not set)
#  set_route_opt_zrt_crosstalk_options -hold_slack_threshold 0.0                           ;# default 0.0
#  set_route_opt_zrt_crosstalk_options -hold_max_net_count 100000                          ;# default -1 (not set)
#  set_route_opt_zrt_crosstalk_options -hold_min_net_count 10                              ;# default -1 (not set)

#  set_route_opt_zrt_crosstalk_options -transition true                                    ;# default false
             ;# needs:  set_si_options -max_transition_mode total_slew
#  set_route_opt_zrt_crosstalk_options -transition_one_net_delta_delay_threshold  0.005    ;# default -1.0 (not set)
#  set_route_opt_zrt_crosstalk_options -transition_slack_threshold 0.0                     ;# default 0.0
#  set_route_opt_zrt_crosstalk_options -transition_max_net_count 100000                    ;# default -1 (not set)
#  set_route_opt_zrt_crosstalk_options -transition_min_net_count 10                        ;# default -1 (not set)

#  set_route_opt_zrt_crosstalk_options -static_noise true                                  ;# default false
             ;# needs:  set_si_options -static_noise true
#  set_route_opt_zrt_crosstalk_options -static_noise_max_net_count 100000                  ;# default -1 (not set)
#  set_route_opt_zrt_crosstalk_options -static_noise_min_net_count 10                      ;# default -1 (not set)


if {$ICC_DBL_VIA } {
  ## Customize as needed - if not, Zroute will select from those available
  ## define_zrt_redundant_vias is not persistent and should be run in every script you run insert_zrt_redundant_via
  #define_zrt_redundant_vias \
        #-from_via "<from_via_list>" \
        #-to_via "<to_via_list>" \
        #-to_via_x_size "<list_of_via_x_sizes>" \
        #-to_via_y_size "<list_of_via_y_sizes>" \
        #-to_via_weights "<list_of_via_weights>"
        ##example: -from_via "VIA45 VIA45 VIA12A" -to_via "VIA45f VIA45 VIA12f" -to_via_x_size "1 1 1" -to_via_y_size "2 2 2" -to_via_weights "10 6 4"

  ##Use external file to customize
  if {[file exists [which $ICC_CUSTOM_DBL_VIA_DEFINE_SCRIPT]]} {
    source $ICC_CUSTOM_DBL_VIA_DEFINE_SCRIPT
  }
  if {$ICC_DBL_VIA_FLOW_EFFORT != "LOW"} {
    set_route_zrt_detail_options -optimize_wire_via_effort_level high    ;#low is default
  }
  if {$ICC_DBL_VIA_FLOW_EFFORT == "HIGH"} {
    #set_route_zrt_common_options -eco_route_concurrent_redundant_via_mode reserve_space
    #set_route_zrt_common_options -eco_route_concurrent_redundant_via_effort_level low  ;#low is default: low|medium|high
  }
}


if {$ICC_FIX_ANTENNA } {

  ########################################
  #        ANTENNA JOGGING FIXING        #
  ########################################

  if {[file exists [which $ANTENNA_RULES_FILE]]} {
       set_route_zrt_detail_options -antenna true
       source $ANTENNA_RULES_FILE
   } else {
       echo "SCRIPT-Info : Antenna rules file does not exist"
       echo "SCRIPT-Info : Turning off antenna fixing"
       set_route_zrt_detail_options -antenna false
   }
} else {
       echo "SCRIPT-Info : Turning off antenna fixing"
       set_route_zrt_detail_options -antenna false
  }

