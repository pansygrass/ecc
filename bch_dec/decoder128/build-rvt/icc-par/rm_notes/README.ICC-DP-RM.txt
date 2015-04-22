####################################################################################
# IC Compiler Design Planning Reference Methodology
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys All rights reserved.
####################################################################################

Introduction
============

The IC Compiler Design Planning Reference Methodology is primarily focused on flows:

*  Feasibility analysis

   It runs through the entire flow: design creation, floorplan creation, virtual
   flat placement, power network synthesis and analysis, in-place optimization, prototype and global routing, and reporting and writing out the floorplan.

*  Floorplan exploration

   It can automatically run through the same flow multiple times, each time with
   different combinations of settings. Results are presented in an HTML table.

The IC Compiler Design Planning Reference Methodology consists of a set of
ready-to-use scripts.

*  It has a flat, straightforward structure that includes setup files, make files,
   and scripts.

*  The scripts contain detailed comments for command sequence and usage.

*  It makes the best use of the design planning features within the context of the
   flow.

The IC Compiler Design Planning Reference Methodology generates the following output:

*  Floorplanned CEL view (and floorplan files) to continue detailed implementation
   in the IC Compiler Reference Methodology

*  Results summarized in an HTML file, if explore mode is used


Contents
========
The IC Compiler Design Planning Reference Methodology includes the following files:

ICC-RMsettings.txt

*  Reference methodology option settings that were selected when the scripts
   were generated

README.ICC-DP-RM.txt

*  Information and instructions for setting up and running the IC Compiler Design
   Planning Reference Methodology scripts

Release_Notes.ICC-DP-RM.txt

*  Release notes for the IC Compiler Design Planning Reference Methodology scripts
   listing the incremental changes in each new version of the scripts

Makefiles are in rm_setup directory

*  Makefile for both the IC Compiler Design Planning Reference Methodology and the
   IC Compiler Reference Methodology

Setup scripts are in rm_setup directory

*  common_setup.tcl

   Common design setup variables for all reference methodologies, including those
   for Design Compiler, PrimeTime, and TetraMAX

*  icc_setup.tcl

   IC Compiler-specific design setup variables used by all IC Compiler reference
   methodologies

rm_icc_scripts/init_design_icc.tcl

*  Script that reads the logic design netlist and constraints, and either creates
   the floorplan or reads the floorplan from a Design Exchange Format (DEF) file or
   a floorplan file

rm_icc_dp_scripts/flat_dp.tcl

*  Script that runs the flat design planning flow to show the routeability, timing,
   and voltage (IR) drop of the design

   The two modes, baseline and explore, are controlled by the ICC_DP_EXPLORE_MODE
   variable in icc_setup.tcl:

   o  Baseline mode runs through the flow and generates one result.

      Basically, this is like a template or set of self-documented scripts.

   o  Explore mode performs multiple runs, generates multiple results, and at the
      end generates an HTML file that aggregates the results in a table.

      Explore mode is configurable through macro_placement_exploration_dp.tcl.

   Baseline mode sources rm_icc_dp_scripts/baseline.tcl. Explore mode sources
   rm_icc_dp_scripts/macro_placement_exploration_dp.tcl.

rm_icc_dp_scripts/macro_placement_exploration_dp.tcl

*  Explore mode instructions that describe the combinations for each run

   You can configure explore mode in this file, for example, by adding or removing
   runs or by changing the settings for a particular run. A procedure is called in
   the file to execute the instructions for each run. This procedure is defined in
   proc_explore.tcl.

Supportive Scripts:

*  rm_icc_dp_scripts/proc_explore.tcl

   Script containing a procedure that is required to perform explore mode.

*  rm_icc_dp_scripts/gen_explore_table.pl and gen_explore_table

   Scripts that parse the log file and the reports from explore mode runs and
   generate an HTML table.

*  rm_setup/icc_scripts/common_optimization_settings_icc.tcl

   Common optimization settings


Usage
=====

To run standard IC Compiler Design Planning Reference Methodology scripts
in baseline mode,

1. Set ICC_DP_EXPLORE_MODE to false in rm_setup/icc_setup.tcl,

2. Enter

   make -f rm_setup/Makefile dp

3. Check the log/* and reports/* files.

To run standard IC Compiler Design Planning Reference Methodology scripts
in exploration mode,

1. Enter

   make -f rm_setup/Makefile dp

2. Open ${DESIGN_NAME}_explore.html from your browser, using the design name you
   specified in rm_setup/common_setup.tcl.

To run Lynx-compatible IC Compiler Design Planning Reference Methodology scripts
in baseline mode,

  1. Set ICC_DP_EXPLORE_MODE to false in rm_setup/icc_setup.tcl,

  2. Enter

     % cd rm_icc/tmp
     % make -f ../../scripts_block/rm_setup/Makefile dp

  3. Check the logs/* and rpts/* files.

To run Lynx-compatible IC Compiler Design Planning Reference Methodology scripts
in exploration mode,

  1. Enter

     % cd rm_icc/tmp
     % make -f ../../scripts_block/rm_setup/Makefile dp

  2. Open ${DESIGN_NAME}_explore.html from your browser, using the design name you
     specified in ../../scripts_block/rm_setup/common_setup.tcl.

