import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_read_driver extends uvm_driver #(axi4_read_txn);
  `uvm_component_utils(axi4_read_driver)

  virtual axi4_if vif;

  function new(string name = "axi4_read_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("READ_DRV", "build_phase executed", UVM_LOW)
    if (!uvm_config_db#(virtual axi4_if)::get(this, "", "vif", vif))
      `uvm_fatal("READ_DRV", "Virtual interface 'vif' not found in config DB")
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info("READ_DRV", "run_phase started", UVM_LOW)
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("READ_DRV", $sformatf("Driving read txn: ID=%0d Addr=0x%0h", req.id, req.addr), UVM_HIGH)
      #10;
      seq_item_port.item_done();
    end
  endtask

endclass
