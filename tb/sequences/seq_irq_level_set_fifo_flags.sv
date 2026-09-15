// Sequence #47: seq_irq_level_set_fifo_flags
// Feature: F24 (INT_STATUS Level-Set FIFO Flags Check)
// Objective: Verifies INT_STATUS[0] (full) and INT_STATUS[1] (empty) level-set behavior post-reset.

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq_irq_level_set_fifo_flags extends uvm_sequence #(axi4_read_txn);
  `uvm_object_utils(seq_irq_level_set_fifo_flags)

  function new(string name = "seq_irq_level_set_fifo_flags");
    super.new(name);
  endfunction

  virtual task body();
    axi4_read_base_seq rd_seq;

    `uvm_info("SEQ_IRQ_LEVEL_SET", "Executing Sequence #47: INT_STATUS Level-Set FIFO Flags Check", UVM_LOW)

    // Read INT_STATUS post-reset (FIFO starts empty -> bit1 must be set to 1)
    rd_seq = axi4_read_base_seq::type_id::create("rd_intstat");
    rd_seq.seq_id   = 4'h4;
    rd_seq.seq_addr = 16'h100C; // A_INT_STATUS
    rd_seq.seq_len  = 8'h00;
    rd_seq.seq_size = 3'b010;
    rd_seq.seq_burst= 2'b00;
    rd_seq.start(m_sequencer);

    `uvm_info("SEQ_IRQ_LEVEL_SET", "Sequence #47 completed", UVM_LOW)
  endtask

endclass
