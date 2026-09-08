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

  // Env Components
  `include "env/axi4_ref_model.sv"
  `include "env/axi4_coverage.sv"
  `include "env/axi4_scoreboard.sv"
  `include "env/axi4_env.sv"

  // Tests
  `include "tests/axi4_base_test.sv"
endpackage
