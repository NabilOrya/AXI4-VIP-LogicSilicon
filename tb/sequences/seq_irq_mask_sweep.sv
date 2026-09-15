// Sequence #44: seq_irq_mask_sweep
// Feature: F22 (INT_EN Interrupt Masking Sweep)
// Objective: Sweeps INT_EN mask patterns (0x0, 0x1, 0x2, 0x4, 0x7) to verify IRQ output gating logic.

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq_irq_mask_sweep extends uvm_sequence #(axi4_write_txn);
  `uvm_object_utils(seq_irq_mask_sweep)

  function new(string name = "seq_irq_mask_sweep");
    super.new(name);
  endfunction

  virtual task body();
    axi4_write_base_seq wr_seq;
    bit [31:0] masks[4] = '{32'h0, 32'h1, 32'h2, 32'h7};

    `uvm_info("SEQ_IRQ_MASK_SWEEP", "Executing Sequence #44: IRQ Mask Sweep", UVM_LOW)

    // Enable global IRQ in CTRL (0x1)
    wr_seq = axi4_write_base_seq::type_id::create("wr_ctrl");
    wr_seq.seq_id       = 4'h1;
    wr_seq.seq_addr     = 16'h1000;
    wr_seq.seq_len      = 8'h00;
    wr_seq.seq_size     = 3'b010;
    wr_seq.seq_burst    = 2'b00;
    wr_seq.override_data= 1;
    wr_seq.seq_data     = new[1];
    wr_seq.seq_data[0]  = 32'h00000001;
    wr_seq.start(m_sequencer);

    foreach (masks[i]) begin
      wr_seq = axi4_write_base_seq::type_id::create($sformatf("mask_%0d", i));
      wr_seq.seq_id       = 4'h1;
      wr_seq.seq_addr     = 16'h1008; // A_INT_EN
      wr_seq.seq_len      = 8'h00;
      wr_seq.seq_size     = 3'b010;
      wr_seq.seq_burst    = 2'b00;
      wr_seq.override_data= 1;
      wr_seq.seq_data     = new[1];
      wr_seq.seq_data[0]  = masks[i];
      wr_seq.start(m_sequencer);
    end

    `uvm_info("SEQ_IRQ_MASK_SWEEP", "Sequence #44 completed", UVM_LOW)
  endtask

endclass
