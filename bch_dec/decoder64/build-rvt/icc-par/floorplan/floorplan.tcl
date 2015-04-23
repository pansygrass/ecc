#floorplan

derive_pg_connection -power_net VDD -power_pin VDD -create_port top
derive_pg_connection -ground_net VSS -ground_pin VSS -create_port top

set_preferred_routing_direction   -layers {M1 M3 M5 M7 M9} -direction vertical
set_preferred_routing_direction   -layers {M2 M4 M6 M8 MRDL} -direction horizontal

create_floorplan \
        -core_utilization 0.6 \
        -flip_first_row \
        -start_first_row \
  	-left_io2core 1 \
  	-bottom_io2core 1 \
  	-right_io2core 1 \
  	-top_io2core 1 \
    -row_core_ratio 1

# there's something funky about the synopsys 32nm educational library
# which results in create_floorplan leaving gaps between the standard cell rows it creates
# removing and regenerating the standard cell rows seems to get around the propblem
cut_row -all
add_row \
  -within [get_attr [get_core_area] bbox] \
  -direction horizontal \
  -flip_first_row \
  -tile_name unit \
  -bottom_offset 0.2

# create initial placement
create_fp_placement

# create power distribution network
# Comment for simple small designs
#synthesize_fp_rings \
#  -nets {VDD VSS} \
#  -core \
#  -layers {M5 M4} \
#  -width {1.25 1.25} \
#  -space {0.5 0.5} \
#  -offset {1 1}

set_power_plan_strategy core \
  -nets {VDD VSS} \
  -core \
  -template saed_32nm.tpl:m45_mesh(0.5,1.0) \
  -extension {stop: outermost_ring}

#set macros [collection_to_list -no_braces -name_only [get_cells -hierarchical -filter "mask_layout_type==macro"]]
#set_power_plan_strategy macros \
  -nets {VDD VSS} \
  -macros $macros \

compile_power_plan

# add filler cells so all cell sites are populated
# synopsys recommends you do this before routing standard cell power rails
insert_stdcell_filler   \
        -cell_without_metal "SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT SHFILL1_RVT" \
        -connect_to_power {VDD} \
        -connect_to_ground {VSS}

# zimmer, need to set these drc options
set_preroute_drc_strategy \
  -min_layer M2 \
  -max_layer M5

# preroute standard cell rails
preroute_standard_cells -connect horizontal \
  -nets {VDD VSS} \
  -port_filter_mode off \
  -route_pins_on_layer M1 \
  -cell_master_filter_mode off \
  -cell_instance_filter_mode off \
  -voltage_area_filter_mode off


# verify connectivity of power/ground nets
verify_pg_nets
# get rid of filler cells
remove_stdcell_filler -stdcell

# verify connectivity of power/ground nets
verify_pg_nets

