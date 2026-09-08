import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_write_driver extends uvm_driver #(axi4_write_txn);
  `uvm_component_utils(axi4_write_driver)

  virtual axi4_if vif;

  function new(string name = "axi4_write_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("WRITE_DRV", "build_phase executed", UVM_LOW)
    if (!uvm_config_db#(virtual axi4_if)::get(this, "", "vif", vif))
      `uvm_fatal("WRITE_DRV", "Virtual interface 'vif' not found in config DB")
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info("WRITE_DRV", "run_phase started", UVM_LOW)
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("WRITE_DRV", $sformatf("Driving write txn: ID=%0d Addr=0x%0h", req.id, req.addr), UVM_HIGH)
      #10;
      seq_item_port.item_done();
    end
  endtask

endclass


/*import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_write_driver extends uvm_driver #(axi4_write_txn);
  `uvm_component_utils(axi4_write_driver)

  virtual axi4_if vif;

  function new(string name = "axi4_write_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("WRITE_DRV", "build_phase executed", UVM_LOW)
    if (!uvm_config_db#(virtual axi4_if)::get(this, "", "vif", vif))
      `uvm_fatal("WRITE_DRV", "Virtual interface 'vif' not found in config DB")
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info("WRITE_DRV", "run_phase started", UVM_LOW)
    
    // Reset signals initially
    reset_signals();

    forever begin
      // Wait until reset is deasserted before driving transactions
      wait(vif.aresetn === 1'b1);

      seq_item_port.get_next_item(req);
      `uvm_info("WRITE_DRV", $sformatf("Driving write txn: ID=%0d Addr=0x%0h Len=%0d", 
                req.id, req.addr, req.len), UVM_HIGH)

      drive_write_txn(req);

      seq_item_port.item_done();
    end
  endtask

  // Task to initialize interface driving signals
  task reset_signals();
    vif.awid    <= '0;
    vif.awaddr  <= '0;
    vif.awlen   <= '0;
    vif.awsize  <= '0;
    vif.awburst <= '0;
    vif.awvalid <= 1'b0;

    vif.wdata   <= '0;
    vif.wstrb   <= '0;
    vif.wlast   <= 1'b0;
    vif.wvalid  <= 1'b0;

    vif.bready  <= 1'b0;
  endtask

  // Main driving task for AW, W, and B channels
  task drive_write_txn(axi4_write_txn txn);
    // 1. Drive Write Address (AW Channel)
    @(posedge vif.aclk);
    vif.awid    <= txn.id;
    vif.awaddr  <= txn.addr;
    vif.awlen   <= txn.len;
    vif.awsize  <= txn.size;
    vif.awburst <= txn.burst;
    vif.awvalid <= 1'b1;

    // Wait for AWREADY handshake
    do begin
      @(posedge vif.aclk);
    end while (!vif.awready);
    vif.awvalid <= 1'b0;

    // 2. Drive Write Data Beats (W Channel)
    for (int i = 0; i <= txn.len; i++) begin
      vif.wdata  <= txn.data[i];
      vif.wstrb  <= txn.strb[i];
      vif.wlast  <= (i == txn.len) ? 1'b1 : 1'b0;
      vif.wvalid <= 1'b1;

      // Wait for WREADY handshake
      do begin
        @(posedge vif.aclk);
      end while (!vif.wready);
    end
    vif.wvalid <= 1'b0;
    vif.wlast  <= 1 me; // clean up wlast

    // 3. Collect Response (B Channel)
    vif.bready <= 1'b1;
    do begin
      @(posedge vif.aclk);
    end while (!vif.bvalid);
    
    // Sample response
    txn.resp = vif.bresp;
    vif.bready <= 1'b0;
  endtask

endclass*/
