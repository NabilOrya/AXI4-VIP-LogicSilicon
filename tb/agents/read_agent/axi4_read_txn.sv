import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_read_txn extends uvm_sequence_item;

  rand bit [3:0]  id;
  rand bit [15:0] addr;
  rand bit [7:0]  len;

  `uvm_object_utils_begin(axi4_read_txn)
    `uvm_field_int(id, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(len, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "axi4_read_txn");
    super.new(name);
  endfunction

  function void post_randomize();
    `uvm_info("READ_TXN", $sformatf("Randomized Read Txn: ID=%0d Addr=0x%0h", id, addr), UVM_HIGH)
  endfunction

endclass
