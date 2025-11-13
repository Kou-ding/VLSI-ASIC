# Clock definition 50% duty cycle, 4ns period, latency 200ps, uncertainty 20ps
create_clock -name clk -period 4.0 [get_ports clk]
set_clock_latency -source 0.2
set_clock_uncertainty 0.02

# Rising edge and falling edge time 1% of clock period
set_clock_transition {-rise 0.04 -fall 0.04} clk

# Output load for setup analysis 0.3pF and hold analysis 0.04pF
set_load
set_load

# Input delay setup 0.5ns hold 0.25ns
set_input_delay
set_input_delay 

# Use BUFX2 for setup analysis and BUFX8 for hold analysis
set_driving_cell -lib_cell BUFX2
set_driving_cell -lib_cell BUFX8 