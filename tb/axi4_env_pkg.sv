`timescale 1ns/1ps

package axi4_env_pkg;
  `include "uvm_macros.svh"

  // Write Agent
  `include "agents/write_agent/axi4_write_txn.sv"
  `include "agents/write_agent/axi4_write_driver.sv"
  `include "agents/write_agent/axi4_write_monitor.sv"
  `include "agents/write_agent/axi4_write_sequencer.sv"
  `include "agents/write_agent/axi4_write_agent.sv"

  // Read Agent
  `include "agents/read_agent/axi4_read_txn.sv"
  `include "agents/read_agent/axi4_read_driver.sv"
  `include "agents/read_agent/axi4_read_monitor.sv"
  `include "agents/read_agent/axi4_read_sequencer.sv"
  `include "agents/read_agent/axi4_read_agent.sv"

  // Sequences
  `include "sequences/axi4_write_base_seq.sv"
  `include "sequences/axi4_read_base_seq.sv"
  `include "sequences/seq_reset_basic.sv"
  `include "sequences/seq_reset_readback_zero.sv"
  `include "sequences/seq_reset_midtxn.sv"
  `include "sequences/seq_reg_ctrl_rw.sv"
  `include "sequences/seq_reg_status_ro_check.sv"
  `include "sequences/seq_reg_int_en_rw.sv"
  `include "sequences/seq_reg_int_status_w1c.sv"
  `include "sequences/seq_reg_fifo_data_access.sv"
  `include "sequences/seq_reg_fifo_status_ro_check.sv"
  `include "sequences/seq_reg_delay_cfg_rw.sv"

  // Env Components
  `include "env/axi4_ref_model.sv"
  `include "env/axi4_coverage.sv"
  `include "env/axi4_scoreboard.sv"
  `include "env/axi4_env.sv"

  // Tests
  `include "tests/axi4_base_test.sv"
endpackage
