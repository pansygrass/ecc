# create clock
# ${CLOCK_PERIOD} is defined in build/Makefrag, so change it
# there to set the maximum period
create_clock clk -name ideal_clock1 -period ${CLOCK_PERIOD}

# Load cap in fF
set_load -pin_load 0.01 [all_outputs]

# set drive strength for inputs
set_driving_cell -lib_cell INVX1_RVT [all_inputs]

# Set timing contraints for the input and output I/O ports
set_input_delay -clock ideal_clock1  0 [all_inputs]
set_output_delay -clock [get_clocks ideal_clock1] 0 [all_outputs]

