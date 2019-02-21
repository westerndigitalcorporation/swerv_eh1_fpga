// SPDX-License-Identifier: Apache-2.0
// Design Copyright 2019 Western Digital Corporation or its affiliates.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
//Date        : Mon Feb 18 19:43:31 2019
//Host        : arup running 64-bit Ubuntu 16.04.5 LTS
//Command     : generate_target clk_and_rst_wrapper.bd
//Design      : clk_and_rst_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clk_and_rst_wrapper
   (bus_struct_reset_0,
    clk_out1_0,
    interconnect_aresetn_0,
    mb_reset_0,
    peripheral_aresetn_0,
    peripheral_reset_0,
    reset,
    sys_clock);
  output [0:0]bus_struct_reset_0;
  output clk_out1_0;
  output [0:0]interconnect_aresetn_0;
  output mb_reset_0;
  output [0:0]peripheral_aresetn_0;
  output [0:0]peripheral_reset_0;
  input reset;
  input sys_clock;

  wire [0:0]bus_struct_reset_0;
  wire clk_out1_0;
  wire [0:0]interconnect_aresetn_0;
  wire mb_reset_0;
  wire [0:0]peripheral_aresetn_0;
  wire [0:0]peripheral_reset_0;
  wire reset;
  wire sys_clock;

  clk_and_rst clk_and_rst_i
       (.bus_struct_reset_0(bus_struct_reset_0),
        .clk_out1_0(clk_out1_0),
        .interconnect_aresetn_0(interconnect_aresetn_0),
        .mb_reset_0(mb_reset_0),
        .peripheral_aresetn_0(peripheral_aresetn_0),
        .peripheral_reset_0(peripheral_reset_0),
        .reset(reset),
        .sys_clock(sys_clock));
endmodule
