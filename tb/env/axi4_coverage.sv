import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_coverage extends uvm_subscriber #(axi4_write_txn);
  `uvm_component_utils(axi4_coverage)

  function new(string name = "axi4_coverage", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("COVERAGE", "build_phase executed", UVM_LOW)
  endfunction

  function void write(axi4_write_txn t);
    `uvm_info("COVERAGE", "Sampling coverage item", UVM_HIGH)
  endfunction

endclass
