## Clock signal (12 MHz onboard oscillator)
# Clock signal 12 MHz
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { sysclk }]; #IO_L12P_T1_MRCC_14 Sch=gclk
create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {sysclk}];

## BTN0 (user button)
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { btn }]


set_property PACKAGE_PIN B18 [get_ports { rst }]
set_property IOSTANDARD LVCMOS33 [get_ports { rst }]

# segment data
# data[0] = g, data[6] = a
set_property PACKAGE_PIN L3 [get_ports { data[0] }]
set_property PACKAGE_PIN A16 [get_ports { data[1] }]
set_property PACKAGE_PIN K3 [get_ports { data[2] }]
set_property PACKAGE_PIN C15 [get_ports { data[3] }]
set_property PACKAGE_PIN M3 [get_ports { data[4] }]
set_property PACKAGE_PIN H1 [get_ports { data[5] }]
set_property PACKAGE_PIN A15 [get_ports { data[6] }]
set_property IOSTANDARD LVCMOS33 [get_ports { data[*] }]

# select pins (digit select)
set_property PACKAGE_PIN B15 [get_ports { select[0] }]
set_property PACKAGE_PIN A14 [get_ports { select[1] }]
set_property PACKAGE_PIN J3  [get_ports { select[2] }]
set_property IOSTANDARD LVCMOS33 [get_ports { select[*] }]
