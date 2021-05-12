#!/bin/bash 
cd /tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFIFO_1_5tvyhlbj/project_StreamingFIFO_1/sol1/impl/verilog
vivado -mode batch -source package_ip.tcl
cd /workspace/finn
