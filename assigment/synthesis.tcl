# Set library paths
set_db init_lib_search_path /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/timing
set_db script_search_path /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/lef
set_db init_hdl_search_path /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/qrc/qx

# Load libraries
set_db library fast_vdd1v2_basicCells.lib
set_db lef_library gsclib045_tech.lef
read_qrc gpdk045.tch

# Read design HDL
read_hdl /home/k/kpapadak/picorv32.v

# Enable clock gating
set_db lp_insert_clock_gating true
syn_map
report_clock_gating

# Optimize in terms of power first
set_db design_power_effort none

# Elaborate the design
elaborate

# Check design
check_design -all

# Set constraints
# not now

# Finally, synthesize the design
syn_generic
syn_map

# Optional optimization
syn_opt

## Reports
# Area
report_area
# Gates
report_gates
# Timing including worst path
report_timing
# Power consumption
report_power

# Write out synthesized design
write_hdl > design.v

# Write out constraints
write_script > constraints.g 
write_sdc > constraints.sdc