import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_write_monitor extends uvm_monitor;
  `uvm_component_utils(axi4_write_monitor)

  virtual axi4_if vif;
  uvm_analysis_port #(axi4_write_txn) item_collected_port;

  function new(string name = "axi4_write_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("WRITE_MON", "build_phase executed", UVM_LOW)
    if (!uvm_config_db#(virtual axi4_if)::get(this, "", "vif", vif))
      `uvm_fatal("WRITE_MON", "Virtual interface 'vif' not found in config DB")
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info("WRITE_MON", "run_phase started", UVM_LOW)
  endtask

endclass
