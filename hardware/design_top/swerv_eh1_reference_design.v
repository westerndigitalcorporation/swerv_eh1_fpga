// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
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

module swerv_eh1_reference_design(
		input 				sys_clock,      //sys clock
 		input 				reset,         //active low
 		output 				led_0,
 		output 				led_1,
 		output 				led_2,
		// UART pins
		output				uart_txd,
		input 				uart_rxd,
        //JTAG pins
    	input 				jtag_tck, // JTAG clk
   		input 			    jtag_tms, // JTAG TMS  
   		input 			    jtag_tdi, // JTAG tdi
   		input 			    jtag_trst_n, // JTAG Reset
   		output 		     	jtag_tdo, // JTAG TDO
		input				jtag_nrst

);


    
	//instantiate swerv_wrapper
	wire [31:0] rv_reset_vec_w = `RV_RESET_VEC;
	wire [31:1] rst_vec  = rv_reset_vec_w[31:1];//31'h0;
	wire 		nmi_int;
	wire [31:0] rv_nmi_vec_w = `RV_NMI_VEC;
	wire [31:1] nmi_vec = rv_nmi_vec_w[31:1];//31'h0;

   	wire [63:0] trace_rv_i_insn_ip;
   	wire [63:0] trace_rv_i_address_ip;
   	wire [2:0]  trace_rv_i_valid_ip;
   	wire [2:0]  trace_rv_i_exception_ip;
   	wire [4:0]  trace_rv_i_ecause_ip;
   	wire [2:0]  trace_rv_i_interrupt_ip;
   	wire [31:0] trace_rv_i_tval_ip;

   	// Bus signals

   	//-------------------------- LSU AXI signals--------------------------
   	// AXI Write Channels
   	wire                            lsu_axi_awvalid;
   	wire                            lsu_axi_awready;
   	wire [`RV_LSU_BUS_TAG-1:0]      lsu_axi_awid;
   	wire [31:0]                     lsu_axi_awaddr;
   	wire [3:0]                      lsu_axi_awregion;
   	wire [7:0]                      lsu_axi_awlen;
   	wire [2:0]                      lsu_axi_awsize;
   	wire [1:0]                      lsu_axi_awburst;
   	wire                            lsu_axi_awlock;
   	wire [3:0]                      lsu_axi_awcache;
   	wire [2:0]                      lsu_axi_awprot;
   	wire [3:0]                      lsu_axi_awqos;
                                           
   	wire                            lsu_axi_wvalid;                                       
   	wire                            lsu_axi_wready;
   	wire [63:0]                     lsu_axi_wdata;
   	wire [7:0]                      lsu_axi_wstrb;
   	wire                            lsu_axi_wlast;
                                           
   	wire                            lsu_axi_bvalid;
   	wire                            lsu_axi_bready;
   	wire [1:0]                      lsu_axi_bresp;
   	wire [`RV_LSU_BUS_TAG-1:0]      lsu_axi_bid;
                                           
   	// AXI Read Channels                    
   	wire                            lsu_axi_arvalid;
   	wire                            lsu_axi_arready;
   	wire [`RV_LSU_BUS_TAG-1:0]      lsu_axi_arid;
   	wire [31:0]                     lsu_axi_araddr;
   	wire [3:0]                      lsu_axi_arregion;
   	wire [7:0]                      lsu_axi_arlen;
   	wire [2:0]                      lsu_axi_arsize;
   	wire [1:0]                      lsu_axi_arburst;
   	wire                            lsu_axi_arlock;
   	wire [3:0]                      lsu_axi_arcache;
   	wire [2:0]                      lsu_axi_arprot;
   	wire [3:0]                      lsu_axi_arqos;
                                           
   	wire                            lsu_axi_rvalid;
   	wire                            lsu_axi_rready;
   	wire [`RV_LSU_BUS_TAG-1:0]      lsu_axi_rid;
   	wire [63:0]                     lsu_axi_rdata;
   	wire [1:0]                      lsu_axi_rresp;
   	wire                            lsu_axi_rlast;
   
   	//-------------------------- IFU AXI signals--------------------------
   	// AXI Write Channels
   	wire                            ifu_axi_awvalid;
   	wire                            ifu_axi_awready;
   	wire [`RV_IFU_BUS_TAG-1:0]      ifu_axi_awid;
   	wire [31:0]                     ifu_axi_awaddr;
   	wire [3:0]                      ifu_axi_awregion;
   	wire [7:0]                      ifu_axi_awlen;
   	wire [2:0]                      ifu_axi_awsize;
   	wire [1:0]                      ifu_axi_awburst;
   	wire                            ifu_axi_awlock;
   	wire [3:0]                      ifu_axi_awcache;
   	wire [2:0]                      ifu_axi_awprot;
   	wire [3:0]                      ifu_axi_awqos;
                                           
   	wire                            ifu_axi_wvalid;                                       
   	wire                            ifu_axi_wready;
   	wire [63:0]                     ifu_axi_wdata;
   	wire [7:0]                      ifu_axi_wstrb;
   	wire                            ifu_axi_wlast;
                                           
   	wire                            ifu_axi_bvalid;
   	wire                            ifu_axi_bready;
   	wire [1:0]                      ifu_axi_bresp;
   	wire [`RV_IFU_BUS_TAG-1:0]      ifu_axi_bid;
                                           
   	// AXI Read Channels                    
   	wire                            ifu_axi_arvalid;
   	wire                            ifu_axi_arready;
   	wire [`RV_IFU_BUS_TAG-1:0]      ifu_axi_arid;
   	wire [31:0]                     ifu_axi_araddr;
   	wire [3:0]                      ifu_axi_arregion;
   	wire [7:0]                      ifu_axi_arlen;
   	wire [2:0]                      ifu_axi_arsize;
   	wire [1:0]                      ifu_axi_arburst;
   	wire                            ifu_axi_arlock;
   	wire [3:0]                      ifu_axi_arcache;
   	wire [2:0]                      ifu_axi_arprot;
   	wire [3:0]                      ifu_axi_arqos;
                                           
   	wire                            ifu_axi_rvalid;
   	wire                            ifu_axi_rready;
   	wire [`RV_IFU_BUS_TAG-1:0]      ifu_axi_rid;
   	wire [63:0]                     ifu_axi_rdata;
   	wire [1:0]                      ifu_axi_rresp;
   	wire                            ifu_axi_rlast;

   	//-------------------------- SB AXI signals--------------------------
   	// AXI Write Channels
   	wire                            sb_axi_awvalid;
   	wire                            sb_axi_awready;
   	wire [`RV_SB_BUS_TAG-1:0]       sb_axi_awid;
   	wire [31:0]                     sb_axi_awaddr;
   	wire [3:0]                      sb_axi_awregion;
   	wire [7:0]                      sb_axi_awlen;
   	wire [2:0]                      sb_axi_awsize;
   	wire [1:0]                      sb_axi_awburst;
   	wire                            sb_axi_awlock;
   	wire [3:0]                      sb_axi_awcache;
   	wire [2:0]                      sb_axi_awprot;
   	wire [3:0]                      sb_axi_awqos;
                                           
   	wire                            sb_axi_wvalid;                                       
   	wire                            sb_axi_wready;
   	wire [63:0]                     sb_axi_wdata;
   	wire [7:0]                      sb_axi_wstrb;
   	wire                            sb_axi_wlast;
                                           
   	wire                            sb_axi_bvalid;
   	wire                            sb_axi_bready;
   	wire [1:0]                      sb_axi_bresp;
   	wire [`RV_SB_BUS_TAG-1:0]       sb_axi_bid;
   	                                        
   	// AXI Read Channels                    
   	wire                            sb_axi_arvalid;
   	wire                            sb_axi_arready;
   	wire [`RV_SB_BUS_TAG-1:0]       sb_axi_arid;
   	wire [31:0]                     sb_axi_araddr;
   	wire [3:0]                      sb_axi_arregion;
   	wire [7:0]                      sb_axi_arlen;
   	wire [2:0]                      sb_axi_arsize;
   	wire [1:0]                      sb_axi_arburst;
   	wire                            sb_axi_arlock;
   	wire [3:0]                      sb_axi_arcache;
   	wire [2:0]                      sb_axi_arprot;
   	wire [3:0]                      sb_axi_arqos;
   	                                        
   	wire                            sb_axi_rvalid;
   	wire                            sb_axi_rready;
   	wire [`RV_SB_BUS_TAG-1:0]       sb_axi_rid;
   	wire [63:0]                     sb_axi_rdata;
   	wire [1:0]                      sb_axi_rresp;
   	wire                            sb_axi_rlast;

   	//-------------------------- DMA AXI signals--------------------------
   	// AXI Write Channels
   	wire                         dma_axi_awvalid = 1'b0;
   	wire                         dma_axi_awready;
   	wire [`RV_DMA_BUS_TAG-1:0]   dma_axi_awid = {`RV_DMA_BUS_TAG{1'b0}};
   	wire [31:0]                  dma_axi_awaddr = {32{1'b0}};
   	wire [2:0]                   dma_axi_awsize = {3{1'b0}};
   	wire [2:0]                   dma_axi_awprot = {3{1'b0}};
   	wire [7:0]                   dma_axi_awlen = {8{1'b0}};
   	wire [1:0]                   dma_axi_awburst = {2{1'b0}};


   	wire                         dma_axi_wvalid = 1'b0;                                       
   	wire                         dma_axi_wready;
   	wire [63:0]                  dma_axi_wdata = {64{1'b0}};
   	wire [7:0]                   dma_axi_wstrb = {8{1'b0}};
   	wire                         dma_axi_wlast = 1'b0;
                                        
   	wire                         dma_axi_bvalid;
   	wire                         dma_axi_bready = 1'b0;
   	wire [1:0]                   dma_axi_bresp;
   	wire [`RV_DMA_BUS_TAG-1:0]   dma_axi_bid;

   	// AXI Read Channels
   	wire                         dma_axi_arvalid = 1'b0;
   	wire                         dma_axi_arready;
   	wire [`RV_DMA_BUS_TAG-1:0]   dma_axi_arid = {`RV_DMA_BUS_TAG{1'b0}};
   	wire [31:0]                  dma_axi_araddr = {32{1'b0}};                                     
   	wire [2:0]                   dma_axi_arsize = {3{1'b0}};
   	wire [2:0]                   dma_axi_arprot = {3{1'b0}};
   	wire [7:0]                   dma_axi_arlen = {8{1'b0}};
   	wire [1:0]                   dma_axi_arburst = {2{1'b0}};

   	wire                         dma_axi_rvalid;
   	wire                         dma_axi_rready = 1'b0;
   	wire [`RV_DMA_BUS_TAG-1:0]   dma_axi_rid;
   	wire [63:0]                  dma_axi_rdata;
   	wire [1:0]                   dma_axi_rresp;
   	wire                         dma_axi_rlast;
                       

   	// clk ratio signals
   	wire 			   lsu_bus_clk_en = 1'b1; // Clock ratio b/w cpu core clk & AHB master interface
   	wire                ifu_bus_clk_en = 1'b1; // Clock ratio b/w cpu core clk & AHB master interface
   	wire                dbg_bus_clk_en = 1'b1; // Clock ratio b/w cpu core clk & AHB master interface
   	wire 			   dma_bus_clk_en = 1'b1; // Clock ratio b/w cpu core clk & AHB slave interface	       

   
   	wire 			     timer_int = 1'b0;
   	wire [`RV_PIC_TOTAL_INT:1] extintsrc_req = 0;

   	wire dec_tlu_perfcnt0; // toggles when slot0 perf counter 0 has an event inc
   	wire dec_tlu_perfcnt1;
   	wire dec_tlu_perfcnt2;
   	wire dec_tlu_perfcnt3;

   	// ports added by the soc team	       
//   	wire 			     jtag_tck = 1'b0; // JTAG clk
//   	wire 			     jtag_tms = 1'b0; // JTAG TMS  
//   	wire 			     jtag_tdi = 1'b0; // JTAG tdi
//   	wire 			     jtag_trst_n = 1'b0; // JTAG Reset
//   	wire 		     	 jtag_tdo; // JTAG TDO

   	wire 			     i_cpu_halt_req = 1'b0; // Async halt req to CPU
   	wire 		     	 o_cpu_halt_ack; // core response to halt
   	wire 		     	 o_cpu_halt_status; // 1'b1 indicates core is halted
   	wire                  o_debug_mode_status; // Core to the PMU that core is in debug mode. When core is in debug mode; the PMU should refrain from sendng a halt or run request
   	wire 			     i_cpu_run_req = 1'b0; // Async restart req to CPU
   	wire 		     	 o_cpu_run_ack; // Core response to run req
   	wire 			     scan_mode = 1'b0; // To enable scan mode
   	wire 			     mbist_mode = 1'b0; // to enable mbist 



	///
	//clock and reset
	wire clk;
	wire interconnect_aresetn;
	wire peripheral_aresetn;
	wire peripheral_reset;
	wire bus_struct_reset;
	wire cpu_reset;
	wire rst_n = ~cpu_reset;

	clk_and_rst_wrapper clk_and_rst_wrapper_inst
     (
		.bus_struct_reset_0(bus_struct_reset),
        .clk_out1_0(clk),
        .interconnect_aresetn_0(interconnect_aresetn),
        .mb_reset_0(cpu_reset),
        .peripheral_aresetn_0(peripheral_aresetn),
        .peripheral_reset_0(peripheral_reset),
        .reset(reset),
        .sys_clock(sys_clock)

	 );
	
	
	PULLUP pullup_jtag_tdi(.O(jtag_tdi));
	PULLUP pullup_jtag_tms(.O(jtag_tms));
    PULLUP pullup_jtag_nrst(.O(jtag_nrst));
            
	wire jtag_tck_ibufg;
  	
	IBUFG ibufg_jtag_tck ( 
    	.I(jtag_tck),
    	.O(jtag_tck_ibufg)
   	);




	swerv_wrapper swerv_wrapper_inst
	(
		.clk(clk),
		.rst_l(rst_n),
		.rst_vec(rst_vec),
		.nmi_int(nmi_int),
		.nmi_vec(nmi_vec),

		.trace_rv_i_insn_ip(trace_rv_i_insn_ip),
		.trace_rv_i_address_ip(trace_rv_i_address_ip),
		.trace_rv_i_valid_ip(trace_rv_i_valid_ip),
		.trace_rv_i_exception_ip(trace_rv_i_exception_ip),
		.trace_rv_i_ecause_ip(trace_rv_i_ecause_ip),
		.trace_rv_i_interrupt_ip(trace_rv_i_interrupt_ip),
		.trace_rv_i_tval_ip(trace_rv_i_tval_ip),

		//LSU
		.lsu_axi_awvalid(lsu_axi_awvalid),
		.lsu_axi_awready(lsu_axi_awready),
		.lsu_axi_awid(lsu_axi_awid),
		.lsu_axi_awaddr(lsu_axi_awaddr),
		.lsu_axi_awregion(lsu_axi_awregion),
		.lsu_axi_awlen(lsu_axi_awlen),
		.lsu_axi_awsize(lsu_axi_awsize),
		.lsu_axi_awburst(lsu_axi_awburst),
		.lsu_axi_awlock(lsu_axi_awlock),
		.lsu_axi_awcache(lsu_axi_awcache),
		.lsu_axi_awprot(lsu_axi_awprot),
		.lsu_axi_awqos(lsu_axi_awqos),

		.lsu_axi_wvalid(lsu_axi_wvalid),                                       
		.lsu_axi_wready(lsu_axi_wready),
		.lsu_axi_wdata(lsu_axi_wdata),
		.lsu_axi_wstrb(lsu_axi_wstrb),
		.lsu_axi_wlast(lsu_axi_wlast),

		.lsu_axi_bvalid(lsu_axi_bvalid),
		.lsu_axi_bready(lsu_axi_bready),
		.lsu_axi_bresp(lsu_axi_bresp),
		.lsu_axi_bid(lsu_axi_bid),


		.lsu_axi_arvalid(lsu_axi_arvalid),
		.lsu_axi_arready(lsu_axi_arready),
		.lsu_axi_arid(lsu_axi_arid),
		.lsu_axi_araddr(lsu_axi_araddr),
		.lsu_axi_arregion(lsu_axi_arregion),
		.lsu_axi_arlen(lsu_axi_arlen),
		.lsu_axi_arsize(lsu_axi_arsize),
		.lsu_axi_arburst(lsu_axi_arburst),
		.lsu_axi_arlock(lsu_axi_arlock),
		.lsu_axi_arcache(lsu_axi_arcache),
		.lsu_axi_arprot(lsu_axi_arprot),
		.lsu_axi_arqos(lsu_axi_arqos),

		.lsu_axi_rvalid(lsu_axi_rvalid),
		.lsu_axi_rready(lsu_axi_rready),
		.lsu_axi_rid(lsu_axi_rid),
		.lsu_axi_rdata(lsu_axi_rdata),
		.lsu_axi_rresp(lsu_axi_rresp),
		.lsu_axi_rlast(lsu_axi_rlast),


		//IFU
 
		.ifu_axi_awvalid(ifu_axi_awvalid),
		.ifu_axi_awready(ifu_axi_awready),
		.ifu_axi_awid(ifu_axi_awid),
		.ifu_axi_awaddr(ifu_axi_awaddr),
		.ifu_axi_awregion(ifu_axi_awregion),
		.ifu_axi_awlen(ifu_axi_awlen),
		.ifu_axi_awsize(ifu_axi_awsize),
		.ifu_axi_awburst(ifu_axi_awburst),
		.ifu_axi_awlock(ifu_axi_awlock),
		.ifu_axi_awcache(ifu_axi_awcache),
		.ifu_axi_awprot(ifu_axi_awprot),
		.ifu_axi_awqos(ifu_axi_awqos),

		.ifu_axi_wvalid(ifu_axi_wvalid),                                       
		.ifu_axi_wready(ifu_axi_wready),
		.ifu_axi_wdata(ifu_axi_wdata),
		.ifu_axi_wstrb(ifu_axi_wstrb),
		.ifu_axi_wlast(ifu_axi_wlast),

		.ifu_axi_bvalid(ifu_axi_bvalid),
		.ifu_axi_bready(ifu_axi_bready),
		.ifu_axi_bresp(ifu_axi_bresp),
		.ifu_axi_bid(ifu_axi_bid),


		.ifu_axi_arvalid(ifu_axi_arvalid),
		.ifu_axi_arready(ifu_axi_arready),
		.ifu_axi_arid(ifu_axi_arid),
		.ifu_axi_araddr(ifu_axi_araddr),
		.ifu_axi_arregion(ifu_axi_arregion),
		.ifu_axi_arlen(ifu_axi_arlen),
		.ifu_axi_arsize(ifu_axi_arsize),
		.ifu_axi_arburst(ifu_axi_arburst),
		.ifu_axi_arlock(ifu_axi_arlock),
		.ifu_axi_arcache(ifu_axi_arcache),
		.ifu_axi_arprot(ifu_axi_arprot),
		.ifu_axi_arqos(ifu_axi_arqos),

		.ifu_axi_rvalid(ifu_axi_rvalid),
		.ifu_axi_rready(ifu_axi_rready),
		.ifu_axi_rid(ifu_axi_rid),
		.ifu_axi_rdata(ifu_axi_rdata),
		.ifu_axi_rresp(ifu_axi_rresp),
		.ifu_axi_rlast(ifu_axi_rlast),


		//SB
		.sb_axi_awvalid(sb_axi_awvalid),
		.sb_axi_awready(sb_axi_awready),
		.sb_axi_awid(sb_axi_awid),
		.sb_axi_awaddr(sb_axi_awaddr),
		.sb_axi_awregion(sb_axi_awregion),
		.sb_axi_awlen(sb_axi_awlen),
		.sb_axi_awsize(sb_axi_awsize),
		.sb_axi_awburst(sb_axi_awburst),
		.sb_axi_awlock(sb_axi_awlock),
		.sb_axi_awcache(sb_axi_awcache),
		.sb_axi_awprot(sb_axi_awprot),
		.sb_axi_awqos(sb_axi_awqos),

		.sb_axi_wvalid(sb_axi_wvalid),                                       
		.sb_axi_wready(sb_axi_wready),
		.sb_axi_wdata(sb_axi_wdata),
		.sb_axi_wstrb(sb_axi_wstrb),
		.sb_axi_wlast(sb_axi_wlast),

		.sb_axi_bvalid(sb_axi_bvalid),
		.sb_axi_bready(sb_axi_bready),
		.sb_axi_bresp(sb_axi_bresp),
		.sb_axi_bid(sb_axi_bid),


		.sb_axi_arvalid(sb_axi_arvalid),
		.sb_axi_arready(sb_axi_arready),
		.sb_axi_arid(sb_axi_arid),
		.sb_axi_araddr(sb_axi_araddr),
		.sb_axi_arregion(sb_axi_arregion),
		.sb_axi_arlen(sb_axi_arlen),
		.sb_axi_arsize(sb_axi_arsize),
		.sb_axi_arburst(sb_axi_arburst),
		.sb_axi_arlock(sb_axi_arlock),
		.sb_axi_arcache(sb_axi_arcache),
		.sb_axi_arprot(sb_axi_arprot),
		.sb_axi_arqos(sb_axi_arqos),

		.sb_axi_rvalid(sb_axi_rvalid),
		.sb_axi_rready(sb_axi_rready),
		.sb_axi_rid(sb_axi_rid),
		.sb_axi_rdata(sb_axi_rdata),
		.sb_axi_rresp(sb_axi_rresp),
		.sb_axi_rlast(sb_axi_rlast),


		//DMA - 
		.dma_axi_awvalid(dma_axi_awvalid),
		.dma_axi_awready(dma_axi_awready),
		.dma_axi_awid(dma_axi_awid),
		.dma_axi_awaddr(dma_axi_awaddr),
		.dma_axi_awsize(dma_axi_awsize),
		.dma_axi_awprot(dma_axi_awprot),
		.dma_axi_awlen(dma_axi_awlen),
		.dma_axi_awburst(dma_axi_awburst),

		.dma_axi_wvalid(dma_axi_wvalid),                                       
		.dma_axi_wready(dma_axi_wready),
		.dma_axi_wdata(dma_axi_wdata),
		.dma_axi_wstrb(dma_axi_wstrb),
		.dma_axi_wlast(dma_axi_wlast),

		.dma_axi_bvalid(dma_axi_bvalid),
		.dma_axi_bready(dma_axi_bready),
		.dma_axi_bresp(dma_axi_bresp),
		.dma_axi_bid(dma_axi_bid),

		.dma_axi_arvalid(dma_axi_arvalid),
		.dma_axi_arready(dma_axi_arready),
		.dma_axi_arid(dma_axi_arid),
		.dma_axi_araddr(dma_axi_araddr),                                     
		.dma_axi_arsize(dma_axi_arsize),
		.dma_axi_arprot(dma_axi_arprot),
		.dma_axi_arlen(dma_axi_arlen),
		.dma_axi_arburst(dma_axi_arburst),

		.dma_axi_rvalid(dma_axi_rvalid),
		.dma_axi_rready(dma_axi_rready),
		.dma_axi_rid(dma_axi_rid),
		.dma_axi_rdata(dma_axi_rdata),
		.dma_axi_rresp(dma_axi_rresp),
		.dma_axi_rlast(dma_axi_rlast),

		
   		// clk ratio signals
  		.lsu_bus_clk_en(lsu_bus_clk_en), // Clock ratio b/w cpu core clk & AHB master interface
  		.ifu_bus_clk_en(ifu_bus_clk_en), // Clock ratio b/w cpu core clk & AHB master interface
   		.dbg_bus_clk_en(dbg_bus_clk_en), // Clock ratio b/w cpu core clk & AHB master interface
   		.dma_bus_clk_en(dma_bus_clk_en), // Clock ratio b/w cpu core clk & AHB slave interface	       
  	 
   		.timer_int(timer_int),
   		.extintsrc_req(extintsrc_req),

  		.dec_tlu_perfcnt0(dec_tlu_perfcnt0), // toggles when slot0 perf counter 0 has an event inc
  		.dec_tlu_perfcnt1(dec_tlu_perfcnt1),
  		.dec_tlu_perfcnt2(dec_tlu_perfcnt2),
   		.dec_tlu_perfcnt3(dec_tlu_perfcnt3),

   		// ports added by the soc team	       
  		.jtag_tck(jtag_tck_ibufg), // JTAG clk
  		.jtag_tms(jtag_tms), // JTAG TMS  
  		.jtag_tdi(jtag_tdi), // JTAG tdi
  		.jtag_trst_n(jtag_trst_n), // JTAG Reset
 	 	.jtag_tdo(jtag_tdo), // JTAG TDO
  
		.i_cpu_halt_req(i_cpu_halt_req), // Async halt req to CPU
  		.o_cpu_halt_ack(o_cpu_halt_ack), // core response to halt
  		.o_cpu_halt_status(o_cpu_halt_status), // 1'b1 indicates core is halted
        .o_debug_mode_status(o_debug_mode_status), // Core to the PMU that core is in debug mode. When core is in debug mode, the PMU should refrain from sendng a halt or run request
   		.i_cpu_run_req(i_cpu_run_req), // Async restart req to CPU
   		.o_cpu_run_ack(o_cpu_run_ack), // Core response to run req
   		.scan_mode(scan_mode), // To enable scan mode
   		.mbist_mode(mbist_mode) // to enable mbist 

	);


	axi_intc_wrapper axi_intc_wrapper_inst
       (
		.ACLK_0(clk),
        .ARESETN_0(interconnect_aresetn),

        .S00_ACLK_0(clk),
        .S00_ARESETN_0(peripheral_aresetn),

        .S00_AXI_0_araddr(lsu_axi_araddr),
        .S00_AXI_0_arburst(lsu_axi_arburst),
        .S00_AXI_0_arcache(lsu_axi_arcache),
        .S00_AXI_0_arid(lsu_axi_arid),
        .S00_AXI_0_arlen(lsu_axi_arlen),
        .S00_AXI_0_arlock(lsu_axi_arlock),
        .S00_AXI_0_arprot(lsu_axi_arprot),
        .S00_AXI_0_arqos(lsu_axi_arqos),
        .S00_AXI_0_arready(lsu_axi_arready),
        .S00_AXI_0_arregion(lsu_axi_arregion),
        .S00_AXI_0_arsize(lsu_axi_arsize),
        .S00_AXI_0_arvalid(lsu_axi_arvalid),
        .S00_AXI_0_awaddr(lsu_axi_awaddr),
        .S00_AXI_0_awburst(lsu_axi_awburst),
        .S00_AXI_0_awcache(lsu_axi_awcache),
        .S00_AXI_0_awid(lsu_axi_awid),
        .S00_AXI_0_awlen(lsu_axi_awlen),
        .S00_AXI_0_awlock(lsu_axi_awlock),
        .S00_AXI_0_awprot(lsu_axi_awprot),
        .S00_AXI_0_awqos(lsu_axi_awqos),
        .S00_AXI_0_awready(lsu_axi_awready),
        .S00_AXI_0_awregion(lsu_axi_awregion),
        .S00_AXI_0_awsize(lsu_axi_awsize),
        .S00_AXI_0_awvalid(lsu_axi_awvalid),
        .S00_AXI_0_bid(lsu_axi_bid),
        .S00_AXI_0_bready(lsu_axi_bready),
        .S00_AXI_0_bresp(lsu_axi_bresp),
        .S00_AXI_0_bvalid(lsu_axi_bvalid),
        .S00_AXI_0_rdata(lsu_axi_rdata),
        .S00_AXI_0_rid(lsu_axi_rid),
        .S00_AXI_0_rlast(lsu_axi_rlast),
        .S00_AXI_0_rready(lsu_axi_rready),
        .S00_AXI_0_rresp(lsu_axi_rresp),
        .S00_AXI_0_rvalid(lsu_axi_rvalid),
        .S00_AXI_0_wdata(lsu_axi_wdata),
        .S00_AXI_0_wlast(lsu_axi_wlast),
        .S00_AXI_0_wready(lsu_axi_wready),
        .S00_AXI_0_wstrb(lsu_axi_wstrb),
        .S00_AXI_0_wvalid(lsu_axi_wvalid),


        .S01_AXI_0_araddr(ifu_axi_araddr),
        .S01_AXI_0_arburst(ifu_axi_arburst),
        .S01_AXI_0_arcache(ifu_axi_arcache),
        .S01_AXI_0_arid(ifu_axi_arid),
        .S01_AXI_0_arlen(ifu_axi_arlen),
        .S01_AXI_0_arlock(ifu_axi_arlock),
        .S01_AXI_0_arprot(ifu_axi_arprot),
        .S01_AXI_0_arqos(ifu_axi_arqos),
        .S01_AXI_0_arready(ifu_axi_arready),
        .S01_AXI_0_arregion(ifu_axi_arregion),
        .S01_AXI_0_arsize(ifu_axi_arsize),
        .S01_AXI_0_arvalid(ifu_axi_arvalid),
        .S01_AXI_0_awaddr(ifu_axi_awaddr),
        .S01_AXI_0_awburst(ifu_axi_awburst),
        .S01_AXI_0_awcache(ifu_axi_awcache),
        .S01_AXI_0_awid(ifu_axi_awid),
        .S01_AXI_0_awlen(ifu_axi_awlen),
        .S01_AXI_0_awlock(ifu_axi_awlock),
        .S01_AXI_0_awprot(ifu_axi_awprot),
        .S01_AXI_0_awqos(ifu_axi_awqos),
        .S01_AXI_0_awready(ifu_axi_awready),
        .S01_AXI_0_awregion(ifu_axi_awregion),
        .S01_AXI_0_awsize(ifu_axi_awsize),
        .S01_AXI_0_awvalid(ifu_axi_awvalid),
        .S01_AXI_0_bid(ifu_axi_bid),
        .S01_AXI_0_bready(ifu_axi_bready),
        .S01_AXI_0_bresp(ifu_axi_bresp),
        .S01_AXI_0_bvalid(ifu_axi_bvalid),
        .S01_AXI_0_rdata(ifu_axi_rdata),
        .S01_AXI_0_rid(ifu_axi_rid),
        .S01_AXI_0_rlast(ifu_axi_rlast),
        .S01_AXI_0_rready(ifu_axi_rready),
        .S01_AXI_0_rresp(ifu_axi_rresp),
        .S01_AXI_0_rvalid(ifu_axi_rvalid),
        .S01_AXI_0_wdata(ifu_axi_wdata),
        .S01_AXI_0_wlast(ifu_axi_wlast),
        .S01_AXI_0_wready(ifu_axi_wready),
        .S01_AXI_0_wstrb(ifu_axi_wstrb),
        .S01_AXI_0_wvalid(ifu_axi_wvalid),


        .S02_AXI_0_araddr(sb_axi_araddr),
        .S02_AXI_0_arburst(sb_axi_arburst),
        .S02_AXI_0_arcache(sb_axi_arcache),
        .S02_AXI_0_arid(sb_axi_arid),
        .S02_AXI_0_arlen(sb_axi_arlen),
        .S02_AXI_0_arlock(sb_axi_arlock),
        .S02_AXI_0_arprot(sb_axi_arprot),
        .S02_AXI_0_arqos(sb_axi_arqos),
        .S02_AXI_0_arready(sb_axi_arready),
        .S02_AXI_0_arregion(sb_axi_arregion),
        .S02_AXI_0_arsize(sb_axi_arsize),
        .S02_AXI_0_arvalid(sb_axi_arvalid),
        .S02_AXI_0_awaddr(sb_axi_awaddr),
        .S02_AXI_0_awburst(sb_axi_awburst),
        .S02_AXI_0_awcache(sb_axi_awcache),
        .S02_AXI_0_awid(sb_axi_awid),
        .S02_AXI_0_awlen(sb_axi_awlen),
        .S02_AXI_0_awlock(sb_axi_awlock),
        .S02_AXI_0_awprot(sb_axi_awprot),
        .S02_AXI_0_awqos(sb_axi_awqos),
        .S02_AXI_0_awready(sb_axi_awready),
        .S02_AXI_0_awregion(sb_axi_awregion),
        .S02_AXI_0_awsize(sb_axi_awsize),
        .S02_AXI_0_awvalid(sb_axi_awvalid),
        .S02_AXI_0_bid(sb_axi_bid),
        .S02_AXI_0_bready(sb_axi_bready),
        .S02_AXI_0_bresp(sb_axi_bresp),
        .S02_AXI_0_bvalid(sb_axi_bvalid),
        .S02_AXI_0_rdata(sb_axi_rdata),
        .S02_AXI_0_rid(sb_axi_rid),
        .S02_AXI_0_rlast(sb_axi_rlast),
        .S02_AXI_0_rready(sb_axi_rready),
        .S02_AXI_0_rresp(sb_axi_rresp),
        .S02_AXI_0_rvalid(sb_axi_rvalid),
        .S02_AXI_0_wdata(sb_axi_wdata),
        .S02_AXI_0_wlast(sb_axi_wlast),
        .S02_AXI_0_wready(sb_axi_wready),
        .S02_AXI_0_wstrb(sb_axi_wstrb),
        .S02_AXI_0_wvalid(sb_axi_wvalid),

		.UART_0_txd(uart_txd),
		.UART_0_rxd(uart_rxd)
);

        
OBUF led_0_obuf (.O(led_0), .I(rst_n));       
OBUF led_1_obuf (.O(led_1), .I(peripheral_aresetn));       
OBUF led_2_obuf (.O(led_2), .I(interconnect_aresetn)); 

endmodule
