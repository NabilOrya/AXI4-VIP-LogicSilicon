`timescale 1ns/1ps

module top_example;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import axi4_env_pkg::*;

  // Clock and Reset Signals
  logic aclk;
  logic aresetn;

  // Clock Generation (100 MHz -> 10ns period)
  initial begin
    aclk = 0;
    forever #5 aclk = ~aclk;
  end

  // Reset Generation
  initial begin
    aresetn = 0;
    #20;
    aresetn = 1;
  end

  // Interface Instantiation (Passing only ACLK per interface definition)
  axi4_if intf (aclk);

  // Connect active-low reset to interface signal
  assign intf.ARESETn = aresetn;

  // DUT Instantiation
  axi4_peripheral #(
    .ADDR_W(16),
    .DATA_W(32),
    .ID_W(4)
  ) dut (
    .ACLK(intf.ACLK),
    .ARESETn(intf.ARESETn),

    // Write Address Channel
    .AWID(intf.AWID),
    .AWADDR(intf.AWADDR),
    .AWLEN(intf.AWLEN),
    .AWSIZE(intf.AWSIZE),
    .AWBURST(intf.AWBURST),
    .AWVALID(intf.AWVALID),
    .AWREADY(intf.AWREADY),

    // Write Data Channel
    .WDATA(intf.WDATA),
    .WSTRB(intf.WSTRB),
    .WLAST(intf.WLAST),
    .WVALID(intf.WVALID),
    .WREADY(intf.WREADY),

    // Write Response Channel
    .BID(intf.BID),
    .BRESP(intf.BRESP),
    .BVALID(intf.BVALID),
    .BREADY(intf.BREADY),

    // Read Address Channel
    .ARID(intf.ARID),
    .ARADDR(intf.ARADDR),
    .ARLEN(intf.ARLEN),
    .ARSIZE(intf.ARSIZE),
    .ARBURST(intf.ARBURST),
    .ARVALID(intf.ARVALID),
    .ARREADY(intf.ARREADY),

    // Read Data Channel
    .RID(intf.RID),
    .RDATA(intf.RDATA),
    .RRESP(intf.RRESP),
    .RLAST(intf.RLAST),
    .RVALID(intf.RVALID),
    .RREADY(intf.RREADY),

    // Interrupt Request Output Port
    .IRQ(intf.IRQ)
  );

  // UVM Configuration and Test Initiation
  initial begin
    uvm_config_db#(virtual axi4_if)::set(null, "*", "vif", intf);
    run_test("axi4_base_test");
  end

endmodule
