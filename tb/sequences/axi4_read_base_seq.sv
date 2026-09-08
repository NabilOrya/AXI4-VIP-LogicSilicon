import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_read_base_seq extends uvm_sequence #(axi4_read_txn);
  `uvm_object_utils(axi4_read_base_seq)

  // Configurable transaction knobs
  rand bit [3:0]  seq_id;
  rand bit [15:0] seq_addr;
  rand bit [7:0]  seq_len;
  rand bit [2:0]  seq_size;
  rand bit [1:0]  seq_burst;

  function new(string name = "axi4_read_base_seq");
    super.new(name);
  endfunction

  virtual task body();
    axi4_read_txn tr;
    tr = axi4_read_txn::type_id::create("tr");

    start_item(tr);

    if (!tr.randomize() with {
      id    == seq_id;
      addr  == seq_addr;
      len   == seq_len;
      size  == seq_size;
      burst == seq_burst;
    }) begin
      `uvm_error("READ_BASE_SEQ", "Randomization failed for read transaction item")
    end

    finish_item(tr);
  endtask

endclass
