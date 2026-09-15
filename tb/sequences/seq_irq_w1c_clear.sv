// Sequence #46: seq_irq_w1c_clear
// Feature: F23 (IRQ Deassertion via INT_STATUS W1C)
// Objective: Triggers error interrupt status, issues Write-1-to-Clear (W1C) write, and verifies IRQ deasserts.

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq_irq_w1c_clear extends uvm_sequence #(axi4_write_txn);
  `uvm_object_utils(seq_irq_w1c_clear)

  function new(string name = "seq_irq_w1c_clear");
    super.new(name);
  endfunction

  virtual task body();
    axi4_write_base_seq wr_seq;

    `uvm_info("SEQ_IRQ_W1C_CLEAR", "Executing Sequence #46: IRQ W1C Clear Test", UVM_LOW)

    // Step 1: Enable IRQ & INT_EN[2]
    wr_seq = axi4_write_base_seq::type_id::create("wr_ctrl");
    wr_seq.seq_id       = 4'h3;
    wr_seq.seq_addr     = 16'h1000;
    wr_seq.seq_len      = 8'h00;
    wr_seq.seq_size     = 3'b010;
    wr_seq.seq_burst    = 2'b00;
    wr_seq.override_data= 1;
    wr_seq.seq_data     = new[1];
    wr_seq.seq_data[0]  = 32'h00000001;
    wr_seq.start(m_sequencer);

    wr_seq = axi4_write_base_seq::type_id::create("wr_inten");
    wr_seq.seq_id       = 4'h3;
    wr_seq.seq_addr     = 16'h1008;
    wr_seq.seq_len      = 8'h00;
    wr_seq.seq_size     = 3'b010;
    wr_seq.seq_burst    = 2'b00;
    wr_seq.override_data= 1;
    wr_seq.seq_data     = new[1];
    wr_seq.seq_data[0]  = 32'h00000004;
    wr_seq.start(m_sequencer);

    // Step 2: Trigger error event to set INT_STATUS[2]
    wr_seq = axi4_write_base_seq::type_id::create("trig_err");
    wr_seq.seq_id       = 4'h3;
    wr_seq.seq_addr     = 16'h1004;
    wr_seq.seq_len      = 8'h00;
    wr_seq.seq_size     = 3'b010;
    wr_seq.seq_burst    = 2'b00;
    wr_seq.override_data= 1;
    wr_seq.seq_data     = new[1];
    wr_seq.seq_data[0]  = 32'hFFFFFFFF;
    wr_seq.start(m_sequencer);

    // Step 3: Clear INT_STATUS[2] by writing 1 to bit 2
    wr_seq = axi4_write_base_seq::type_id::create("clear_w1c");
    wr_seq.seq_id       = 4'h3;
    wr_seq.seq_addr     = 16'h100C; // A_INT_STATUS
    wr_seq.seq_len      = 8'h00;
    wr_seq.seq_size     = 3'b010;
    wr_seq.seq_burst    = 2'b00;
    wr_seq.override_data= 1;
    wr_seq.seq_data     = new[1];
    wr_seq.seq_data[0]  = 32'h00000004; // Write 1 to clear bit 2
    wr_seq.start(m_sequencer);

    `uvm_info("SEQ_IRQ_W1C_CLEAR", "Sequence #46 completed", UVM_LOW)
  endtask

endclass
