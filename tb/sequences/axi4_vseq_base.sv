// Virtual Sequence Base Class: axi4_vseq_base
// Objective: Base virtual sequence class providing handles for write and read sequencers to coordinate concurrent stimulus.

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi4_vseq_base extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(axi4_vseq_base)

  axi4_write_sequencer write_seqr;
  axi4_read_sequencer  read_seqr;

  function new(string name = "axi4_vseq_base");
    super.new(name);
  endfunction

endclass
