`timescale 1ns/1ps

module top_example;

  logic ACLK=0;
  always #5 ACLK=~ACLK;

  axi4_if axi(ACLK);

  axi4_peripheral dut(
    .ACLK(ACLK),
    .ARESETn(axi.ARESETn),

    .AWID(axi.AWID),
    .AWADDR(axi.AWADDR),
    .AWLEN(axi.AWLEN),
    .AWSIZE(axi.AWSIZE),
    .AWBURST(axi.AWBURST),
    .AWVALID(axi.AWVALID),
    .AWREADY(axi.AWREADY),

    .WDATA(axi.WDATA),
    .WSTRB(axi.WSTRB),
    .WLAST(axi.WLAST),
    .WVALID(axi.WVALID),
    .WREADY(axi.WREADY),

    .BID(axi.BID),
    .BRESP(axi.BRESP),
    .BVALID(axi.BVALID),
    .BREADY(axi.BREADY),

    .ARID(axi.ARID),
    .ARADDR(axi.ARADDR),
    .ARLEN(axi.ARLEN),
    .ARSIZE(axi.ARSIZE),
    .ARBURST(axi.ARBURST),
    .ARVALID(axi.ARVALID),
    .ARREADY(axi.ARREADY),

    .RID(axi.RID),
    .RDATA(axi.RDATA),
    .RRESP(axi.RRESP),
    .RLAST(axi.RLAST),
    .RVALID(axi.RVALID),
    .RREADY(axi.RREADY),

    .IRQ()
  );

endmodule
