###################################################################################
# IC Compiler Reference Methodology
# Version: D-2010.03-SP2 (July 6, 2010)
# Copyright (C) 2007-2010 Synopsys, Inc. All rights reserved.
###################################################################################

Features
========

*  Provides self-documenting reference methodology scripts for place and route
   using IC Compiler.

*  Provides the baseline flow from netlist to GDS out.

*  Includes IC Compiler Design Planning Reference Methodology, which allows you to
   explore different floorplans.

*  Includes parallel flows for multivoltage and multicorner-multimode

*  Includes the IC Compiler Hierarchical Reference Methodology
   (available in version A-2007.12-SP1 and later)

*  Includes signoff_opt
   (optimization using the Synopsys sign-off extraction and timing analysis tool)

*  Includes DFT Compiler and Power Compiler reference methodologies

*  Designed to work with the Design Compiler Reference Methodology
   as the first step

*  Includes Formality reference methodology script to perform verification of the netlist going into
   IC Compiler versus the Verilog netlist created by IC Compiler

Description
===========

The IC Compiler Reference Methodology provides a set of reference scripts that you
can use as a recommended guideline for developing IC Compiler scripts.

You can run the scripts "out of the box" to get a fully optimized and routed
design right away. In addition to the baseline flow, which includes the
IC Compiler Design Planning Reference Methodology and sign-off-driven optimization,
the scripts also provide the following parallel flows:

*  Design-for-test scan chain reordering flow

*  Leakage and dynamic power optimization flow

*  Multivoltage flow, including multithreshold-CMOS, for both the IEEE 1801 (TM)
   based flow and the non-IEEE 1801 flow

   IEEE 1801 is also known as Unified Power Format (UPF).

*  Multicorner-multimode flow

*  All key chip-finishing flow steps

*  Physical hierarchical flow

*  Zroute flow


Contents
========

The IC Compiler Reference Methodology includes the following files:

ICC-RMsettings.txt

*  Reference methodology option settings that were selected when the scripts
   were generated

README.ICC-RM.txt

*  Information and instructions for setting up and running the IC Compiler
   Reference Methodology scripts

Release_Notes.ICC-RM.txt

*  Release notes for the IC Compiler Reference Methodology scripts listing the
   incremental changes in each new version of the scripts

Setup scripts are in rm_setup directory

*  common_setup.tcl

   Common design setup variables for all reference methodologies, including those
   for Design Compiler, PrimeTime, and TetraMAX

*  icc_setup.tcl

   IC Compiler-specific design setup variables used by all IC Compiler reference
   methodologies

Constraint and optimization scripts

*  rm_icc_scripts/init_design_icc.tcl

   Script that reads the logic design netlist and constraints, creates the
   floorplan or reads the floorplan via Design Exchange Format (DEF), and
   generates a zero-interconnect timing report

*  rm_icc_scripts/place_opt_icc.tcl

   Script that runs placement and placement-based optimization

*  rm_icc_scripts/clock_opt_cts_icc.tcl

   Script that runs clock tree synthesis and optimization

*  rm_icc_scripts/clock_opt_psyn_icc.tcl

   Script that runs post-clock tree synthesis optimization

*  rm_icc_scripts/clock_opt_route_icc.tcl

   Script that routes the clocks with the specified nondefault routing rules

*  rm_icc_scripts/route_icc.tcl

   Script that runs routing with crosstalk delta delay enabled by default

*  rm_icc_scripts/route_opt_icc.tcl

   Script that runs postroute optimization with crosstalk delta delay enabled by default

*  rm_icc_scripts/chipfinish_icc.tcl:

   Script that runs several chip finishing steps, such as timing-driven metal fill,
   detail route wire spreading to reduce the critical area, and antenna fixing

*  rm_icc_scripts/signoff_opt_icc.tcl

   Script that runs sign-off-driven optimization by using StarRC and PrimeTime
   to create a design that is ready for sign off

*  rm_icc_scripts/outputs_icc.tcl

   Script that creates several output files: Verilog, Design Exchange Format (DEF),
   Standard Parasitic Exchange Format (SPEF), GDS, and others

*  rm_icc_scripts/eco_icc.tcl

   Script that runs eco flow by using eco_netlist and route_eco

*  rm_icc_scripts/focal_opt_icc.tcl

   Script that runs postroute optimization to fix setup, hold, or logical
   design rule constraint (DRC) violations on the design by using focal_opt

*  rm_icc_scripts/fm.tcl

   Script that runs Formality after the outputs_icc step is completed.
   Simply enter the following command:
   % fm_shell -f rm_icc_scripts/fm.tcl | tee log_zrt/fm.log (or log/fm.log)	

The flat and hierarchical floorplanning scripts are in the rm_icc_dp_scripts
directory.

The Zroute scripts are in the rm_icc_zrt_scripts directory.


Usage
=====

For the standard reference methodology flow, use the following commands.

*  To run the reference methodology scripts, enter the following command:

   % make -f rm_setup/Makefile_zrt ic

*  To run the ECO flow, enter the following command:

   % make -f rm_setup/Makefile_zrt eco

*  To run the focal_opt flow, enter the following command:

   % make -f rm_setup/Makefile_zrt focal_opt

Note:
   This usage is based on Zroute. If you prefer to run the classic router, replace
   Makefile_zrt with Makfile in the invocation commands.

For the Lynx-compatible reference methodology flow, use the following commands:

  *  To run the reference methodology scripts, enter the following command:

     % cd rm_icc/tmp
     % make -f ../../scripts_block/rm_setup/Makefile_zrt ic

  *  To run the ECO flow, enter the following command:

     % cd rm_icc/tmp
     % make -f ../../scripts_block/rm_setup/Makefile_zrt eco

  *  To run the focal_opt flow, enter the following command:

     % cd rm_icc/tmp
     % make -f ../../scripts_block/rm_setup/Makefile_zrt focal_opt

Note:
   This usage is based on Zroute. If you prefer to run the classic router, replace
   Makefile_zrt with Makefile in the invocation commands.

