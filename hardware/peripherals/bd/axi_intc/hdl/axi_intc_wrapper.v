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
//Date        : Mon Feb 18 19:43:16 2019
//Host        : arup running 64-bit Ubuntu 16.04.5 LTS
//Command     : generate_target axi_intc_wrapper.bd
//Design      : axi_intc_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module axi_intc_wrapper
   (ACLK_0,
    ARESETN_0,
    S00_ACLK_0,
    S00_ARESETN_0,
    S00_AXI_0_araddr,
    S00_AXI_0_arburst,
    S00_AXI_0_arcache,
    S00_AXI_0_arid,
    S00_AXI_0_arlen,
    S00_AXI_0_arlock,
    S00_AXI_0_arprot,
    S00_AXI_0_arqos,
    S00_AXI_0_arready,
    S00_AXI_0_arregion,
    S00_AXI_0_arsize,
    S00_AXI_0_arvalid,
    S00_AXI_0_awaddr,
    S00_AXI_0_awburst,
    S00_AXI_0_awcache,
    S00_AXI_0_awid,
    S00_AXI_0_awlen,
    S00_AXI_0_awlock,
    S00_AXI_0_awprot,
    S00_AXI_0_awqos,
    S00_AXI_0_awready,
    S00_AXI_0_awregion,
    S00_AXI_0_awsize,
    S00_AXI_0_awvalid,
    S00_AXI_0_bid,
    S00_AXI_0_bready,
    S00_AXI_0_bresp,
    S00_AXI_0_bvalid,
    S00_AXI_0_rdata,
    S00_AXI_0_rid,
    S00_AXI_0_rlast,
    S00_AXI_0_rready,
    S00_AXI_0_rresp,
    S00_AXI_0_rvalid,
    S00_AXI_0_wdata,
    S00_AXI_0_wlast,
    S00_AXI_0_wready,
    S00_AXI_0_wstrb,
    S00_AXI_0_wvalid,
    S01_AXI_0_araddr,
    S01_AXI_0_arburst,
    S01_AXI_0_arcache,
    S01_AXI_0_arid,
    S01_AXI_0_arlen,
    S01_AXI_0_arlock,
    S01_AXI_0_arprot,
    S01_AXI_0_arqos,
    S01_AXI_0_arready,
    S01_AXI_0_arregion,
    S01_AXI_0_arsize,
    S01_AXI_0_arvalid,
    S01_AXI_0_awaddr,
    S01_AXI_0_awburst,
    S01_AXI_0_awcache,
    S01_AXI_0_awid,
    S01_AXI_0_awlen,
    S01_AXI_0_awlock,
    S01_AXI_0_awprot,
    S01_AXI_0_awqos,
    S01_AXI_0_awready,
    S01_AXI_0_awregion,
    S01_AXI_0_awsize,
    S01_AXI_0_awvalid,
    S01_AXI_0_bid,
    S01_AXI_0_bready,
    S01_AXI_0_bresp,
    S01_AXI_0_bvalid,
    S01_AXI_0_rdata,
    S01_AXI_0_rid,
    S01_AXI_0_rlast,
    S01_AXI_0_rready,
    S01_AXI_0_rresp,
    S01_AXI_0_rvalid,
    S01_AXI_0_wdata,
    S01_AXI_0_wlast,
    S01_AXI_0_wready,
    S01_AXI_0_wstrb,
    S01_AXI_0_wvalid,
    S02_AXI_0_araddr,
    S02_AXI_0_arburst,
    S02_AXI_0_arcache,
    S02_AXI_0_arid,
    S02_AXI_0_arlen,
    S02_AXI_0_arlock,
    S02_AXI_0_arprot,
    S02_AXI_0_arqos,
    S02_AXI_0_arready,
    S02_AXI_0_arregion,
    S02_AXI_0_arsize,
    S02_AXI_0_arvalid,
    S02_AXI_0_awaddr,
    S02_AXI_0_awburst,
    S02_AXI_0_awcache,
    S02_AXI_0_awid,
    S02_AXI_0_awlen,
    S02_AXI_0_awlock,
    S02_AXI_0_awprot,
    S02_AXI_0_awqos,
    S02_AXI_0_awready,
    S02_AXI_0_awregion,
    S02_AXI_0_awsize,
    S02_AXI_0_awvalid,
    S02_AXI_0_bid,
    S02_AXI_0_bready,
    S02_AXI_0_bresp,
    S02_AXI_0_bvalid,
    S02_AXI_0_rdata,
    S02_AXI_0_rid,
    S02_AXI_0_rlast,
    S02_AXI_0_rready,
    S02_AXI_0_rresp,
    S02_AXI_0_rvalid,
    S02_AXI_0_wdata,
    S02_AXI_0_wlast,
    S02_AXI_0_wready,
    S02_AXI_0_wstrb,
    S02_AXI_0_wvalid,
    UART_0_rxd,
    UART_0_txd);
  input ACLK_0;
  input ARESETN_0;
  input S00_ACLK_0;
  input S00_ARESETN_0;
  input [31:0]S00_AXI_0_araddr;
  input [1:0]S00_AXI_0_arburst;
  input [3:0]S00_AXI_0_arcache;
  input [2:0]S00_AXI_0_arid;
  input [7:0]S00_AXI_0_arlen;
  input [0:0]S00_AXI_0_arlock;
  input [2:0]S00_AXI_0_arprot;
  input [3:0]S00_AXI_0_arqos;
  output S00_AXI_0_arready;
  input [3:0]S00_AXI_0_arregion;
  input [2:0]S00_AXI_0_arsize;
  input S00_AXI_0_arvalid;
  input [31:0]S00_AXI_0_awaddr;
  input [1:0]S00_AXI_0_awburst;
  input [3:0]S00_AXI_0_awcache;
  input [2:0]S00_AXI_0_awid;
  input [7:0]S00_AXI_0_awlen;
  input [0:0]S00_AXI_0_awlock;
  input [2:0]S00_AXI_0_awprot;
  input [3:0]S00_AXI_0_awqos;
  output S00_AXI_0_awready;
  input [3:0]S00_AXI_0_awregion;
  input [2:0]S00_AXI_0_awsize;
  input S00_AXI_0_awvalid;
  output [2:0]S00_AXI_0_bid;
  input S00_AXI_0_bready;
  output [1:0]S00_AXI_0_bresp;
  output S00_AXI_0_bvalid;
  output [63:0]S00_AXI_0_rdata;
  output [2:0]S00_AXI_0_rid;
  output S00_AXI_0_rlast;
  input S00_AXI_0_rready;
  output [1:0]S00_AXI_0_rresp;
  output S00_AXI_0_rvalid;
  input [63:0]S00_AXI_0_wdata;
  input S00_AXI_0_wlast;
  output S00_AXI_0_wready;
  input [7:0]S00_AXI_0_wstrb;
  input S00_AXI_0_wvalid;
  input [31:0]S01_AXI_0_araddr;
  input [1:0]S01_AXI_0_arburst;
  input [3:0]S01_AXI_0_arcache;
  input [2:0]S01_AXI_0_arid;
  input [7:0]S01_AXI_0_arlen;
  input [0:0]S01_AXI_0_arlock;
  input [2:0]S01_AXI_0_arprot;
  input [3:0]S01_AXI_0_arqos;
  output S01_AXI_0_arready;
  input [3:0]S01_AXI_0_arregion;
  input [2:0]S01_AXI_0_arsize;
  input S01_AXI_0_arvalid;
  input [31:0]S01_AXI_0_awaddr;
  input [1:0]S01_AXI_0_awburst;
  input [3:0]S01_AXI_0_awcache;
  input [2:0]S01_AXI_0_awid;
  input [7:0]S01_AXI_0_awlen;
  input [0:0]S01_AXI_0_awlock;
  input [2:0]S01_AXI_0_awprot;
  input [3:0]S01_AXI_0_awqos;
  output S01_AXI_0_awready;
  input [3:0]S01_AXI_0_awregion;
  input [2:0]S01_AXI_0_awsize;
  input S01_AXI_0_awvalid;
  output [2:0]S01_AXI_0_bid;
  input S01_AXI_0_bready;
  output [1:0]S01_AXI_0_bresp;
  output S01_AXI_0_bvalid;
  output [63:0]S01_AXI_0_rdata;
  output [2:0]S01_AXI_0_rid;
  output S01_AXI_0_rlast;
  input S01_AXI_0_rready;
  output [1:0]S01_AXI_0_rresp;
  output S01_AXI_0_rvalid;
  input [63:0]S01_AXI_0_wdata;
  input S01_AXI_0_wlast;
  output S01_AXI_0_wready;
  input [7:0]S01_AXI_0_wstrb;
  input S01_AXI_0_wvalid;
  input [31:0]S02_AXI_0_araddr;
  input [1:0]S02_AXI_0_arburst;
  input [3:0]S02_AXI_0_arcache;
  input [0:0]S02_AXI_0_arid;
  input [7:0]S02_AXI_0_arlen;
  input [0:0]S02_AXI_0_arlock;
  input [2:0]S02_AXI_0_arprot;
  input [3:0]S02_AXI_0_arqos;
  output S02_AXI_0_arready;
  input [3:0]S02_AXI_0_arregion;
  input [2:0]S02_AXI_0_arsize;
  input S02_AXI_0_arvalid;
  input [31:0]S02_AXI_0_awaddr;
  input [1:0]S02_AXI_0_awburst;
  input [3:0]S02_AXI_0_awcache;
  input [0:0]S02_AXI_0_awid;
  input [7:0]S02_AXI_0_awlen;
  input [0:0]S02_AXI_0_awlock;
  input [2:0]S02_AXI_0_awprot;
  input [3:0]S02_AXI_0_awqos;
  output S02_AXI_0_awready;
  input [3:0]S02_AXI_0_awregion;
  input [2:0]S02_AXI_0_awsize;
  input S02_AXI_0_awvalid;
  output [0:0]S02_AXI_0_bid;
  input S02_AXI_0_bready;
  output [1:0]S02_AXI_0_bresp;
  output S02_AXI_0_bvalid;
  output [63:0]S02_AXI_0_rdata;
  output [0:0]S02_AXI_0_rid;
  output S02_AXI_0_rlast;
  input S02_AXI_0_rready;
  output [1:0]S02_AXI_0_rresp;
  output S02_AXI_0_rvalid;
  input [63:0]S02_AXI_0_wdata;
  input S02_AXI_0_wlast;
  output S02_AXI_0_wready;
  input [7:0]S02_AXI_0_wstrb;
  input S02_AXI_0_wvalid;
  input UART_0_rxd;
  output UART_0_txd;

  wire ACLK_0;
  wire ARESETN_0;
  wire S00_ACLK_0;
  wire S00_ARESETN_0;
  wire [31:0]S00_AXI_0_araddr;
  wire [1:0]S00_AXI_0_arburst;
  wire [3:0]S00_AXI_0_arcache;
  wire [2:0]S00_AXI_0_arid;
  wire [7:0]S00_AXI_0_arlen;
  wire [0:0]S00_AXI_0_arlock;
  wire [2:0]S00_AXI_0_arprot;
  wire [3:0]S00_AXI_0_arqos;
  wire S00_AXI_0_arready;
  wire [3:0]S00_AXI_0_arregion;
  wire [2:0]S00_AXI_0_arsize;
  wire S00_AXI_0_arvalid;
  wire [31:0]S00_AXI_0_awaddr;
  wire [1:0]S00_AXI_0_awburst;
  wire [3:0]S00_AXI_0_awcache;
  wire [2:0]S00_AXI_0_awid;
  wire [7:0]S00_AXI_0_awlen;
  wire [0:0]S00_AXI_0_awlock;
  wire [2:0]S00_AXI_0_awprot;
  wire [3:0]S00_AXI_0_awqos;
  wire S00_AXI_0_awready;
  wire [3:0]S00_AXI_0_awregion;
  wire [2:0]S00_AXI_0_awsize;
  wire S00_AXI_0_awvalid;
  wire [2:0]S00_AXI_0_bid;
  wire S00_AXI_0_bready;
  wire [1:0]S00_AXI_0_bresp;
  wire S00_AXI_0_bvalid;
  wire [63:0]S00_AXI_0_rdata;
  wire [2:0]S00_AXI_0_rid;
  wire S00_AXI_0_rlast;
  wire S00_AXI_0_rready;
  wire [1:0]S00_AXI_0_rresp;
  wire S00_AXI_0_rvalid;
  wire [63:0]S00_AXI_0_wdata;
  wire S00_AXI_0_wlast;
  wire S00_AXI_0_wready;
  wire [7:0]S00_AXI_0_wstrb;
  wire S00_AXI_0_wvalid;
  wire [31:0]S01_AXI_0_araddr;
  wire [1:0]S01_AXI_0_arburst;
  wire [3:0]S01_AXI_0_arcache;
  wire [2:0]S01_AXI_0_arid;
  wire [7:0]S01_AXI_0_arlen;
  wire [0:0]S01_AXI_0_arlock;
  wire [2:0]S01_AXI_0_arprot;
  wire [3:0]S01_AXI_0_arqos;
  wire S01_AXI_0_arready;
  wire [3:0]S01_AXI_0_arregion;
  wire [2:0]S01_AXI_0_arsize;
  wire S01_AXI_0_arvalid;
  wire [31:0]S01_AXI_0_awaddr;
  wire [1:0]S01_AXI_0_awburst;
  wire [3:0]S01_AXI_0_awcache;
  wire [2:0]S01_AXI_0_awid;
  wire [7:0]S01_AXI_0_awlen;
  wire [0:0]S01_AXI_0_awlock;
  wire [2:0]S01_AXI_0_awprot;
  wire [3:0]S01_AXI_0_awqos;
  wire S01_AXI_0_awready;
  wire [3:0]S01_AXI_0_awregion;
  wire [2:0]S01_AXI_0_awsize;
  wire S01_AXI_0_awvalid;
  wire [2:0]S01_AXI_0_bid;
  wire S01_AXI_0_bready;
  wire [1:0]S01_AXI_0_bresp;
  wire S01_AXI_0_bvalid;
  wire [63:0]S01_AXI_0_rdata;
  wire [2:0]S01_AXI_0_rid;
  wire S01_AXI_0_rlast;
  wire S01_AXI_0_rready;
  wire [1:0]S01_AXI_0_rresp;
  wire S01_AXI_0_rvalid;
  wire [63:0]S01_AXI_0_wdata;
  wire S01_AXI_0_wlast;
  wire S01_AXI_0_wready;
  wire [7:0]S01_AXI_0_wstrb;
  wire S01_AXI_0_wvalid;
  wire [31:0]S02_AXI_0_araddr;
  wire [1:0]S02_AXI_0_arburst;
  wire [3:0]S02_AXI_0_arcache;
  wire [0:0]S02_AXI_0_arid;
  wire [7:0]S02_AXI_0_arlen;
  wire [0:0]S02_AXI_0_arlock;
  wire [2:0]S02_AXI_0_arprot;
  wire [3:0]S02_AXI_0_arqos;
  wire S02_AXI_0_arready;
  wire [3:0]S02_AXI_0_arregion;
  wire [2:0]S02_AXI_0_arsize;
  wire S02_AXI_0_arvalid;
  wire [31:0]S02_AXI_0_awaddr;
  wire [1:0]S02_AXI_0_awburst;
  wire [3:0]S02_AXI_0_awcache;
  wire [0:0]S02_AXI_0_awid;
  wire [7:0]S02_AXI_0_awlen;
  wire [0:0]S02_AXI_0_awlock;
  wire [2:0]S02_AXI_0_awprot;
  wire [3:0]S02_AXI_0_awqos;
  wire S02_AXI_0_awready;
  wire [3:0]S02_AXI_0_awregion;
  wire [2:0]S02_AXI_0_awsize;
  wire S02_AXI_0_awvalid;
  wire [0:0]S02_AXI_0_bid;
  wire S02_AXI_0_bready;
  wire [1:0]S02_AXI_0_bresp;
  wire S02_AXI_0_bvalid;
  wire [63:0]S02_AXI_0_rdata;
  wire [0:0]S02_AXI_0_rid;
  wire S02_AXI_0_rlast;
  wire S02_AXI_0_rready;
  wire [1:0]S02_AXI_0_rresp;
  wire S02_AXI_0_rvalid;
  wire [63:0]S02_AXI_0_wdata;
  wire S02_AXI_0_wlast;
  wire S02_AXI_0_wready;
  wire [7:0]S02_AXI_0_wstrb;
  wire S02_AXI_0_wvalid;
  wire UART_0_rxd;
  wire UART_0_txd;

  axi_intc axi_intc_i
       (.ACLK_0(ACLK_0),
        .ARESETN_0(ARESETN_0),
        .S00_ACLK_0(S00_ACLK_0),
        .S00_ARESETN_0(S00_ARESETN_0),
        .S00_AXI_0_araddr(S00_AXI_0_araddr),
        .S00_AXI_0_arburst(S00_AXI_0_arburst),
        .S00_AXI_0_arcache(S00_AXI_0_arcache),
        .S00_AXI_0_arid(S00_AXI_0_arid),
        .S00_AXI_0_arlen(S00_AXI_0_arlen),
        .S00_AXI_0_arlock(S00_AXI_0_arlock),
        .S00_AXI_0_arprot(S00_AXI_0_arprot),
        .S00_AXI_0_arqos(S00_AXI_0_arqos),
        .S00_AXI_0_arready(S00_AXI_0_arready),
        .S00_AXI_0_arregion(S00_AXI_0_arregion),
        .S00_AXI_0_arsize(S00_AXI_0_arsize),
        .S00_AXI_0_arvalid(S00_AXI_0_arvalid),
        .S00_AXI_0_awaddr(S00_AXI_0_awaddr),
        .S00_AXI_0_awburst(S00_AXI_0_awburst),
        .S00_AXI_0_awcache(S00_AXI_0_awcache),
        .S00_AXI_0_awid(S00_AXI_0_awid),
        .S00_AXI_0_awlen(S00_AXI_0_awlen),
        .S00_AXI_0_awlock(S00_AXI_0_awlock),
        .S00_AXI_0_awprot(S00_AXI_0_awprot),
        .S00_AXI_0_awqos(S00_AXI_0_awqos),
        .S00_AXI_0_awready(S00_AXI_0_awready),
        .S00_AXI_0_awregion(S00_AXI_0_awregion),
        .S00_AXI_0_awsize(S00_AXI_0_awsize),
        .S00_AXI_0_awvalid(S00_AXI_0_awvalid),
        .S00_AXI_0_bid(S00_AXI_0_bid),
        .S00_AXI_0_bready(S00_AXI_0_bready),
        .S00_AXI_0_bresp(S00_AXI_0_bresp),
        .S00_AXI_0_bvalid(S00_AXI_0_bvalid),
        .S00_AXI_0_rdata(S00_AXI_0_rdata),
        .S00_AXI_0_rid(S00_AXI_0_rid),
        .S00_AXI_0_rlast(S00_AXI_0_rlast),
        .S00_AXI_0_rready(S00_AXI_0_rready),
        .S00_AXI_0_rresp(S00_AXI_0_rresp),
        .S00_AXI_0_rvalid(S00_AXI_0_rvalid),
        .S00_AXI_0_wdata(S00_AXI_0_wdata),
        .S00_AXI_0_wlast(S00_AXI_0_wlast),
        .S00_AXI_0_wready(S00_AXI_0_wready),
        .S00_AXI_0_wstrb(S00_AXI_0_wstrb),
        .S00_AXI_0_wvalid(S00_AXI_0_wvalid),
        .S01_AXI_0_araddr(S01_AXI_0_araddr),
        .S01_AXI_0_arburst(S01_AXI_0_arburst),
        .S01_AXI_0_arcache(S01_AXI_0_arcache),
        .S01_AXI_0_arid(S01_AXI_0_arid),
        .S01_AXI_0_arlen(S01_AXI_0_arlen),
        .S01_AXI_0_arlock(S01_AXI_0_arlock),
        .S01_AXI_0_arprot(S01_AXI_0_arprot),
        .S01_AXI_0_arqos(S01_AXI_0_arqos),
        .S01_AXI_0_arready(S01_AXI_0_arready),
        .S01_AXI_0_arregion(S01_AXI_0_arregion),
        .S01_AXI_0_arsize(S01_AXI_0_arsize),
        .S01_AXI_0_arvalid(S01_AXI_0_arvalid),
        .S01_AXI_0_awaddr(S01_AXI_0_awaddr),
        .S01_AXI_0_awburst(S01_AXI_0_awburst),
        .S01_AXI_0_awcache(S01_AXI_0_awcache),
        .S01_AXI_0_awid(S01_AXI_0_awid),
        .S01_AXI_0_awlen(S01_AXI_0_awlen),
        .S01_AXI_0_awlock(S01_AXI_0_awlock),
        .S01_AXI_0_awprot(S01_AXI_0_awprot),
        .S01_AXI_0_awqos(S01_AXI_0_awqos),
        .S01_AXI_0_awready(S01_AXI_0_awready),
        .S01_AXI_0_awregion(S01_AXI_0_awregion),
        .S01_AXI_0_awsize(S01_AXI_0_awsize),
        .S01_AXI_0_awvalid(S01_AXI_0_awvalid),
        .S01_AXI_0_bid(S01_AXI_0_bid),
        .S01_AXI_0_bready(S01_AXI_0_bready),
        .S01_AXI_0_bresp(S01_AXI_0_bresp),
        .S01_AXI_0_bvalid(S01_AXI_0_bvalid),
        .S01_AXI_0_rdata(S01_AXI_0_rdata),
        .S01_AXI_0_rid(S01_AXI_0_rid),
        .S01_AXI_0_rlast(S01_AXI_0_rlast),
        .S01_AXI_0_rready(S01_AXI_0_rready),
        .S01_AXI_0_rresp(S01_AXI_0_rresp),
        .S01_AXI_0_rvalid(S01_AXI_0_rvalid),
        .S01_AXI_0_wdata(S01_AXI_0_wdata),
        .S01_AXI_0_wlast(S01_AXI_0_wlast),
        .S01_AXI_0_wready(S01_AXI_0_wready),
        .S01_AXI_0_wstrb(S01_AXI_0_wstrb),
        .S01_AXI_0_wvalid(S01_AXI_0_wvalid),
        .S02_AXI_0_araddr(S02_AXI_0_araddr),
        .S02_AXI_0_arburst(S02_AXI_0_arburst),
        .S02_AXI_0_arcache(S02_AXI_0_arcache),
        .S02_AXI_0_arid(S02_AXI_0_arid),
        .S02_AXI_0_arlen(S02_AXI_0_arlen),
        .S02_AXI_0_arlock(S02_AXI_0_arlock),
        .S02_AXI_0_arprot(S02_AXI_0_arprot),
        .S02_AXI_0_arqos(S02_AXI_0_arqos),
        .S02_AXI_0_arready(S02_AXI_0_arready),
        .S02_AXI_0_arregion(S02_AXI_0_arregion),
        .S02_AXI_0_arsize(S02_AXI_0_arsize),
        .S02_AXI_0_arvalid(S02_AXI_0_arvalid),
        .S02_AXI_0_awaddr(S02_AXI_0_awaddr),
        .S02_AXI_0_awburst(S02_AXI_0_awburst),
        .S02_AXI_0_awcache(S02_AXI_0_awcache),
        .S02_AXI_0_awid(S02_AXI_0_awid),
        .S02_AXI_0_awlen(S02_AXI_0_awlen),
        .S02_AXI_0_awlock(S02_AXI_0_awlock),
        .S02_AXI_0_awprot(S02_AXI_0_awprot),
        .S02_AXI_0_awqos(S02_AXI_0_awqos),
        .S02_AXI_0_awready(S02_AXI_0_awready),
        .S02_AXI_0_awregion(S02_AXI_0_awregion),
        .S02_AXI_0_awsize(S02_AXI_0_awsize),
        .S02_AXI_0_awvalid(S02_AXI_0_awvalid),
        .S02_AXI_0_bid(S02_AXI_0_bid),
        .S02_AXI_0_bready(S02_AXI_0_bready),
        .S02_AXI_0_bresp(S02_AXI_0_bresp),
        .S02_AXI_0_bvalid(S02_AXI_0_bvalid),
        .S02_AXI_0_rdata(S02_AXI_0_rdata),
        .S02_AXI_0_rid(S02_AXI_0_rid),
        .S02_AXI_0_rlast(S02_AXI_0_rlast),
        .S02_AXI_0_rready(S02_AXI_0_rready),
        .S02_AXI_0_rresp(S02_AXI_0_rresp),
        .S02_AXI_0_rvalid(S02_AXI_0_rvalid),
        .S02_AXI_0_wdata(S02_AXI_0_wdata),
        .S02_AXI_0_wlast(S02_AXI_0_wlast),
        .S02_AXI_0_wready(S02_AXI_0_wready),
        .S02_AXI_0_wstrb(S02_AXI_0_wstrb),
        .S02_AXI_0_wvalid(S02_AXI_0_wvalid),
        .UART_0_rxd(UART_0_rxd),
        .UART_0_txd(UART_0_txd));
endmodule
