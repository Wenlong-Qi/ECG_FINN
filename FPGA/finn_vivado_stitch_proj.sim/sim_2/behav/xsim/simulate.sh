#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Tue May 11 01:06:13 CEST 2021
# SW Build 2902540 on Wed May 27 19:54:35 MDT 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim testbench_behav -key {Behavioral:sim_2:Functional:testbench} -tclbatch testbench.tcl -protoinst "protoinst_files/finn_design.protoinst" -log simulate.log"
xsim testbench_behav -key {Behavioral:sim_2:Functional:testbench} -tclbatch testbench.tcl -protoinst "protoinst_files/finn_design.protoinst" -log simulate.log

