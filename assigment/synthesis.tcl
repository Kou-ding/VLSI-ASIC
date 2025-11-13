# Rise the max number of messages to print in order to see all warnings
set_db message_max_print_count 999

# Set library paths (/timing), (/lef), (/qrc/qx)
set_db init_lib_search_path /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045
set_db script_search_path /home/k/kpapadak/Documents
set_db init_hdl_search_path /home/k/kpapadak/Documents

# Load libraries {}:for multiple arguments
set_db library timing/fast_vdd1v2_basicCells.lib
set_db lef_library {lef/gsclib045_tech.lef lef/gsclib045_macro.lef}
read_qrc qrc/qx/gpdk045.tch

# Read design HDL
read_hdl picorv32.v

# # Enable clock gating
# set_db lp_insert_clock_gating true
# syn_map
# report_clock_gating

# # Optimize in terms of power first (low, high, none)
# set_db design_power_effort none

# Elaborate the design (top level module: picorv32_wb)
elaborate picorv32_wb

# Check design
check_design -all

# Avoid Innovus scan for non existent detection chains
set_db / .use_scan_seqs_for_non_dft false

# Define I2O, I2R, R2O and R2R paths
define_cost_group -name i2o -design picorv32_wb
define_cost_group -name i2r -design picorv32_wb
define_cost_group -name r2o -design picorv32_wb
define_cost_group -name r2r -design picorv32_wb
path_group -from all_inputs -to all_outputs -group i2o -name i2o_paths
path_group -from all_inputs -to all_register -group i2r -name i2r_paths
path_group -from all_register -to all_outputs -group r2o -name r2o_paths
path_group -from all_register -to all_register -group r2r -name r2r_paths

# Set constraints from sdc file
read_sdc constraints.sdc

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
write_hdl > output_design.v

# Write out constraints
write_script > output_constraints.g 
write_sdc > output_constraints.sdc

# Export design for Innovus
write_design -basename output_picorv32 -gzip_files -tcf -innovus -hierarchical picorv32_wb